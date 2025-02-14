import 'package:json_annotation/json_annotation.dart';

part 'payment_request.g.dart';

@JsonSerializable()
class PaymentRequest {
  @JsonKey(name: "amount")
  final String? amount;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "payment_method_types[]")
  final String? paymentMethodTypes;

  PaymentRequest({
    this.amount,
    this.currency,
    this.paymentMethodTypes,
  });

  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return _$PaymentRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PaymentRequestToJson(this);
  }
}
