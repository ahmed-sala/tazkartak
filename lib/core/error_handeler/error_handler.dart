import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'error_messages.dart';

class ErrorHandler {
  final String errorMessage;
  final int code;

  ErrorHandler._(this.errorMessage, this.code);

  factory ErrorHandler.fromException(dynamic exception) {
    if (exception is DioException) {
      final statusCode = exception.response?.statusCode;
      final responseData = exception.response?.data;

      // Extract error message from server response
      String message = "An error occurred";
      if (responseData is Map<String, dynamic>) {
        message = responseData['error'] ??
            responseData['detail'] ??
            responseData['message'] ??
            message;
      }

      // Handle token expiration specifically
      if (statusCode == 403 && message.contains("token has expired")) {
        // Perform token refresh or force logout
        return ErrorHandler._(
            "Session expired. Please log in again.", statusCode!);
      }

      return ErrorHandler._(message, statusCode ?? -1);
    } else if (exception is FirebaseAuthException) {
      // Handle Firebase Authentication errors.
      String message =
          exception.message ?? ErrorMassage.firebaseAuthErrorMessage;
      int errorCode;

      // Optionally, map the string code from FirebaseAuthException to a numeric code.
      switch (exception.code) {
        case 'user-not-found':
          errorCode = 404;
          message = "No user found with this email.";
          break;
        case 'wrong-password':
          errorCode = 401;
          message = "The password is incorrect.";
          break;
        case 'user-disabled':
          errorCode = 403;
          message = "This user has been disabled.";
          break;
        case 'too-many-requests':
          errorCode = 429;
          message = "Too many requests. Please try again later.";
          break;
        default:
          errorCode = -1;
          break;
      }
      return ErrorHandler._(message, errorCode);
    } else if (exception is FirebaseException) {
      // This branch will catch Firestore and other Firebase exceptions.
      String message = exception.message ?? ErrorMassage.firestoreErrorMessage;

      // If you need to differentiate Firestore errors further, you can check the 'plugin' property.
      if (exception.plugin == 'cloud_firestore') {
        message =
            message.isNotEmpty ? message : ErrorMassage.firestoreErrorMessage;
      }
      return ErrorHandler._(message, -1);
    } else {
      return ErrorHandler._("An unexpected error occurred", -1);
    }
  }
}
