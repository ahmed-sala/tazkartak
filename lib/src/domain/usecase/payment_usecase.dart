import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/src/domain/repository_contracts/payment_repo.dart';

@injectable
class PaymentUsecase {
  PaymentRepo paymentRepo;

  PaymentUsecase(this.paymentRepo);
  Future<void> executePayment(String amount, String currency) async {
    await paymentRepo.processPayment(amount, currency);
  }
}
