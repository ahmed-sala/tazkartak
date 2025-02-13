import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/src/data/datasource/contract/payment_datasource.dart';

import '../../domain/repository_contracts/payment_repo.dart';

@Injectable(as: PaymentRepo)
class PaymentRepoImpl implements PaymentRepo {
  PaymentDatasource paymentDatasource;

  PaymentRepoImpl(this.paymentDatasource);
}
