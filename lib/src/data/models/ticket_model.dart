class TicketModel {
  final String noOfStations;
  final String price;
  final String fromStation;
  final String toStation;

  TicketModel({
    required this.noOfStations,
    required this.price,
    required this.fromStation,
    required this.toStation,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      noOfStations: json['noOfStations'],
      price: json['price'],
      fromStation: json['fromStation'],
      toStation: json['toStation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noOfStations': noOfStations,
      'price': price,
      'fromStation': fromStation,
      'toStation': toStation,
    };
  }
}
