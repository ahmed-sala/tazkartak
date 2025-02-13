import 'package:injectable/injectable.dart';

import '../contract/payment_datasource.dart';

@Injectable(as: PaymentDatasource)
class PaymentDatasourceImpl implements PaymentDatasource {}
