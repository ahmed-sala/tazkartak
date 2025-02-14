class TicketModelWithId {
  final String noOfStations;
  final String price;
  final String fromStation;
  final String toStation;
  final String userId;
  TicketModelWithId(
      {required this.noOfStations,
      required this.price,
      required this.fromStation,
      required this.toStation,
      required this.userId});

  factory TicketModelWithId.fromJson(Map<String, dynamic> json) {
    return TicketModelWithId(
      noOfStations: json['noOfStations'],
      price: json['price'],
      fromStation: json['fromStation'],
      toStation: json['toStation'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noOfStations': noOfStations,
      'price': price,
      'fromStation': fromStation,
      'toStation': toStation,
      'userId': userId
    };
  }
}
