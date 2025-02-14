import '../../models/ticket_model.dart';

abstract interface class PaymentDatasource {
  /// Calls the Stripe API to create a payment intent.
  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency);

  /// Initializes the Stripe payment sheet with the payment intent.
  Future<void> initPaymentSheet(String amount, String currency);

  /// Presents the payment sheet to the user.
  Future<void> presentPaymentSheet();
  Future<String> storeTicket(TicketModel ticket, String userId);
  Future<String> getUserId();
}
