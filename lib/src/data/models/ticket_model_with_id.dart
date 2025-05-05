import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModelWithId {
  final String noOfStations;
  final String price;
  final String fromStation;
  final String toStation;
  final String userId;
  final String status;
  final String departureTime;
  final DateTime arrivalTime;
  String? ticketId;
  TicketModelWithId(
      {required this.noOfStations,
      required this.status,
      required this.price,
      required this.fromStation,
      required this.toStation,
      required this.userId,
      required this.departureTime,
      this.ticketId,
      required this.arrivalTime});

  factory TicketModelWithId.fromJson(Map<String, dynamic> json) {
    // Grab the raw arrivalTime
    final rawArrival = json['arrivalTime'];

    // Convert it into a Dart DateTime
    DateTime parsedArrival;
    if (rawArrival is Timestamp) {
      parsedArrival = rawArrival.toDate();
    } else if (rawArrival is String) {
      // In case you ever stored it as ISO string
      parsedArrival = DateTime.tryParse(rawArrival) ?? DateTime.now();
    } else {
      // Fallback
      parsedArrival = DateTime.now();
    }
    return TicketModelWithId(
      noOfStations: json['noOfStations'],
      price: json['price'],
      fromStation: json['fromStation'],
      toStation: json['toStation'],
      userId: json['userId'],
      status: json['status'] ?? 'Not Entered',
      departureTime: json['departureTime'] ?? 'Not Entered',
      arrivalTime: parsedArrival,
      ticketId: json['ticketId'] ?? 'Not Entered',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noOfStations': noOfStations,
      'price': price,
      'fromStation': fromStation,
      'toStation': toStation,
      'userId': userId,
      'status': status,
      'departureTime': departureTime,
      'arrivalTime': Timestamp.fromDate(arrivalTime),
      'ticketId': ticketId,
    };
  }
}
