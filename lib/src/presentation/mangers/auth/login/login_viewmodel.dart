import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/domain/usecase/login_usecase.dart';

import '../../../../../core/error_handeler/error_handler.dart';
import 'login_state.dart';

@injectable
class LoginViewmodel extends Cubit<LoginState> {
  LoginUsecase _loginUsecase;
  LoginViewmodel(this._loginUsecase) : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void login() async {
    if (formKey.currentState!.validate()) {
      // Reset state before making a new login attempt
      FirebaseAuth.instance.setLanguageCode('en');

      emit(LoginLoading());
      print('Login started'); // Debugging line
      try {
        var result = await _loginUsecase.invoke(
          emailController.text,
          passwordController.text,
        );
        print('Result: $result'); // Debugging line

        switch (result) {
          case Success<void>():
            print('Login success'); // Debugging line
            emit(LoginSuccess());
            break;
          case Failures<void>():
            final errorMessage =
                ErrorHandler.fromException(result.exception).errorMessage;
            print('Login failed: $errorMessage'); // Debugging line
            emit(LoginFailure(errorMessage));
            break;
        }
      } catch (e) {
        print('Login error: $e');
        emit(LoginFailure('Unexpected error occurred'));
      }
    }
  }
}
