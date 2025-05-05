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
      userId: userId,
      status: ticket.status,
      departureTime: ticket.departureTime,
      arrivalTime: ticket.arrivalTime,
    );
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

  @override
  Future<TicketModel?> getTicketById(String ticketId) async {
    var result = _firestoreService.getDocumentById('tickets', ticketId);

    var ticketModel = TicketModel.fromJson(await result);
    print('🔍 Firestore raw result: ${ticketModel.fromStation}');

    return ticketModel;
  }

  @override
  Future<List<TicketModelWithId>> getAllTicketsByUserId(String userId) async {
    try {
      // 1. Query for all ticket docs where userId == current user
      final docs = await _firestoreService.getQuerySnapshotsByField(
        'tickets',
        'userId',
        userId,
      );

      // 2. Map each QueryDocumentSnapshot into your model (including the doc ID)
      return docs.map((docSnap) {
        final data = docSnap.data();
        // Use your existing fromJson constructor, then assign the ticketId
        final ticket = TicketModelWithId.fromJson(data)..ticketId = docSnap.id;
        return ticket;
      }).toList();
    } catch (e) {
      print('Error fetching tickets for user $userId: $e');
      throw Exception('Could not load tickets: $e');
    }
  }

  @override
  Stream<TicketModel?> watchTicketById(String ticketId) {
    return _firestoreService
        .documentStream('tickets', ticketId)
        .map((json) => json == null ? null : TicketModel.fromJson(json));
  }
}
