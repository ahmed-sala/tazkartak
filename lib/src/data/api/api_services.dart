import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/src/data/api/api_constants.dart';
import 'package:tazkartak_app/src/data/api/request/payment_request.dart';

@singleton
class StripeDioService {
  final Dio _dio;

  StripeDioService(this._dio) {
    // Set the base URL from your API constants
    _dio.options.baseUrl = ApiConstants.baseUrl;
  }

  /// Calls Stripe's Payment Intents API using Dio.
  Future<Map<String, dynamic>> createPaymentIntent(
      PaymentRequest paymentRequest) async {
    // Stripe requires form urlencoded data.
    final data = {
      'amount': paymentRequest.amount,
      'currency': paymentRequest.currency,
      'payment_method_types[]': paymentRequest.paymentMethodTypes,
    };

    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ${ApiConstants.secret}',
    };

    try {
      final response = await _dio.post(
        '/payment_intents',
        data: data,
        options: Options(
          headers: headers,
          contentType: 'application/x-www-form-urlencoded',
        ),
      );
      return response.data as Map<String, dynamic>;
    } on DioError catch (dioError) {
      // You can handle Dio errors specifically here
      throw Exception(
          'Dio error: ${dioError.response?.data ?? dioError.message}');
    } catch (e) {
      throw Exception('Error creating payment intent: $e');
    }
  }
}
