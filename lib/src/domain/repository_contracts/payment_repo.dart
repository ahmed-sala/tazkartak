import 'package:tazkartak_app/core/common/api/api_result.dart';

import '../../data/models/ticket_model.dart';

abstract interface class PaymentRepo {
  Future<void> processPayment(String amount, String currency);
  Future<ApiResult<String>> storeTicket(TicketModel ticket);
}
