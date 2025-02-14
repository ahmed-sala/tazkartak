abstract interface class PaymentRepo {
  Future<void> processPayment(String amount, String currency);
}
