import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
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
  final FirestoreService _firestoreService;

  final DatabaseReference dbRef;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  PaymentDatasourceImpl(
    this.stripeApiServices,
    this._firestoreService,
  ) : dbRef = FirebaseDatabase.instance.ref('tickets') {
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
    final formattedArrival =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(ticket.arrivalTime);

    final ticketWithId = TicketModelWithId(
      noOfStations: ticket.noOfStations,
      price: ticket.price,
      fromStation: ticket.fromStation,
      toStation: ticket.toStation,
      userId: userId,
      status: ticket.status,
      departureTime: ticket.departureTime,
      arrivalTime: formattedArrival,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    final firestoreResult = await _firestoreService.addNormalDocument(
      'tickets',
      ticketWithId.toJson(),
    );
    final docId = firestoreResult.id;
    ticketWithId.ticketId = docId;

    await dbRef.child(docId).set(ticketWithId.toJson());

    return docId;
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
      final docs = await _firestoreService.getQuerySnapshotsByField(
        'tickets',
        'userId',
        userId,
      );

      return docs.map((docSnap) {
        final data = docSnap.data();
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
    return dbRef.child(ticketId).onValue.map((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data == null) return null;
      final json = Map<String, dynamic>.from(data as Map);

      if (json['arrivalTime'] is int) {
        json['arrivalTime'] =
            Timestamp.fromMillisecondsSinceEpoch(json['arrivalTime']);
      }
      return TicketModel.fromJson(json);
    });
  }
}
