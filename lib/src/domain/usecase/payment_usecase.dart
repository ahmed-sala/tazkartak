import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/src/domain/repository_contracts/payment_repo.dart';

@injectable
class PaymentUsecase {
  PaymentRepo paymentRepo;

  PaymentUsecase(this.paymentRepo);
}
