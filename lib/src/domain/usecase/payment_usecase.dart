import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/src/domain/repository_contracts/payment_repo.dart';

import '../../../core/common/api/api_result.dart';
import '../../data/models/ticket_model.dart';

@injectable
class PaymentUsecase {
  PaymentRepo paymentRepo;

  PaymentUsecase(this.paymentRepo);
  Future<void> executePayment(String amount, String currency) async {
    await paymentRepo.processPayment(amount, currency);
  }

  Future<ApiResult<String>> executeStoreTicket(TicketModel ticket) async {
    return await paymentRepo.storeTicket(ticket);
  }
}
