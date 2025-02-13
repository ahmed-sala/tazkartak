import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static const String baseUrl = 'https://api.stripe.com/v1';
  // Use the payment_intents endpoint here.
  static const String paymentApiUrl = '$baseUrl/payment_intents';
  static const String secret =
      'sk_test_51NyZm3H430uC8PK4xZCbqteKd02w4MkV4ntWCFP4mOqiu3n2JffFFFMDICNDkqV0CNA0rSlYetvZUeYrEpoyJF3T00ENUh4cLY';
  static Map<String, String> headers = {
    'Authorization': 'Bearer $secret',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    // Set your publishable key for Stripe.
    Stripe.publishableKey =
    'pk_test_51NyZm3H430uC8PK4ORZUe1YkhG51UWI04EzIxCd10nyJAnJPIJTMMZ7Bb7zaYpR2pB5xHD5KIiKALFP0hps8UQhI00s3kNvI7A';
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount, // amount in the smallest currency unit, e.g., cents for USD
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      // Post to the correct endpoint for payment intents.
      var response = await http.post(
        Uri.parse(paymentApiUrl),
        headers: headers,
        body: body,
      );

      // Log the response for debugging.
      print('Payment Intent response status: ${response.statusCode}');
      print('Payment Intent response body: ${response.body}');

      return jsonDecode(response.body);
    } catch (err) {
      print('Error in createPaymentIntent: ${err.toString()}');
      throw Exception('Failed to create payment intent');
    }
  }

  static Future<void> initPaymentSheet(String amount, String currency) async {
    try {
      Map<String, dynamic> paymentIntent =
      await createPaymentIntent(amount, currency);

      // Check that a client secret is returned.
      if (paymentIntent['client_secret'] == null) {
        print('Error: Missing client_secret in payment intent.');
        throw Exception('Failed to create payment intent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Dear Programmer',
          style: ThemeMode.light,
        ),
      );
    } catch (e) {
      print('Error in initPaymentSheet: ${e.toString()}');
      throw Exception('Failed to initialize payment sheet');
    }
  }

  static Future<void> presentPaymentSheet() async {
    try {
      // Note: The correct method is presentPaymentSheet()
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('Error in presentPaymentSheet: ${e.toString()}');
      throw Exception('Failed to present payment sheet');
    }
  }
}
