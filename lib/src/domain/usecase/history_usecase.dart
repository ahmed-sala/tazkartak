import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/domain/repository_contracts/payment_repo.dart';

import '../../data/models/ticket_model_with_id.dart';

@injectable
class HistoryUsecase {
  final PaymentRepo paymentRepo;
  HistoryUsecase(this.paymentRepo);

  Future<ApiResult<List<TicketModelWithId>?>> getAllTicketsByUserId() async {
    return await paymentRepo.getAllTicketsByUserId();
  }
}
