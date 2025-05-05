import 'package:tazkartak_app/core/common/api/api_result.dart';

import '../../data/models/ticket_model.dart';
import '../../data/models/ticket_model_with_id.dart';

abstract interface class PaymentRepo {
  Future<void> processPayment(String amount, String currency);
  Future<ApiResult<String>> storeTicket(TicketModel ticket);
  Future<ApiResult<TicketModel?>> getTicketById(String ticketId);
  Future<ApiResult<List<TicketModelWithId>?>> getAllTicketsByUserId();
  Stream<TicketModel?> watchTicketById(String ticketId);
}
