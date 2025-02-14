import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/src/data/api/request/payment_request.dart';
import 'package:tazkartak_app/src/data/models/ticket_model.dart';
import 'package:tazkartak_app/src/data/models/ticket_model_with_id.dart';

import '../../../../core/helpers/firestore/firestore_services.dart';
import '../../api/api_constants.dart';
import '../../api/api_services.dart';
import '../contract/payment_datasource.dart';

@Injectable(as: PaymentDatasource)
class PaymentDatasourceImpl implements PaymentDatasource {
  final StripeDioService stripeApiServices;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreService _firestoreService;

  PaymentDatasourceImpl(this.stripeApiServices, this._firestoreService) {
    Stripe.publishableKey = ApiConstants.publishableKey;
  }
  @override
  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    PaymentRequest paymentRequest = PaymentRequest(
        amount: amount, currency: currency, paymentMethodTypes: 'card');

    return await stripeApiServices.createPaymentIntent(paymentRequest);
  }

  @override
  Future<void> initPaymentSheet(String amount, String currency) async {
    final paymentIntent = await createPaymentIntent(amount, currency);
    if (paymentIntent['client_secret'] == null) {
      throw Exception(
          'Failed to create payment intent: client_secret is missing');
    }
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent['client_secret'],
        merchantDisplayName: 'Dear Programmer',
        style: ThemeMode.light,
      ),
    );
  }

  @override
  Future<void> presentPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  @override
  Future<String> storeTicket(TicketModel ticket, String userId) async {
    print('ticket: ${ticket.toJson()}');
    TicketModelWithId ticketWithId = TicketModelWithId(
        noOfStations: ticket.noOfStations,
        price: ticket.price,
        fromStation: ticket.fromStation,
        toStation: ticket.toStation,
        userId: userId);
    var result = await _firestoreService.addNormalDocument(
        'tickets', ticketWithId.toJson());
    return result.id;
  }

  @override
  Future<String> getUserId() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('No user is signed in');
    }
    return user.uid;
  }
}
