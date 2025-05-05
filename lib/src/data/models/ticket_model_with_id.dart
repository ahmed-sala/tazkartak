class TicketModelWithId {
  final String noOfStations;
  final String price;
  final String fromStation;
  final String toStation;
  final String userId;
  final String status;
  final String departureTime;
  final String arrivalTime;
  final int createdAt;
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
      required this.createdAt,
      required this.arrivalTime});

  factory TicketModelWithId.fromJson(Map<String, dynamic> json) {
    return TicketModelWithId(
      noOfStations: json['noOfStations'],
      price: json['price'],
      fromStation: json['fromStation'],
      toStation: json['toStation'],
      userId: json['userId'],
      status: json['status'] ?? 'Not Entered',
      departureTime: json['departureTime'] ?? 'Not Entered',
      arrivalTime: json['arrivalTime'],
      ticketId: json['ticketId'] ?? 'Not Entered',
      createdAt: json['createdAt'] ?? 0,
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
      'arrivalTime': arrivalTime,
      'ticketId': ticketId,
      'createdAt': createdAt,
    };
  }
}
