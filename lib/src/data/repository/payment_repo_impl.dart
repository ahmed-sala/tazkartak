import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_execute.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/data/datasource/contract/payment_datasource.dart';
import 'package:tazkartak_app/src/data/models/ticket_model.dart';

import '../../domain/repository_contracts/payment_repo.dart';

@Injectable(as: PaymentRepo)
class PaymentRepoImpl implements PaymentRepo {
  PaymentDatasource paymentDatasource;

  PaymentRepoImpl(this.paymentDatasource);
  @override
  Future<void> processPayment(String amount, String currency) async {
    await paymentDatasource.initPaymentSheet(amount, currency);
    await paymentDatasource.presentPaymentSheet();
  }

  @override
  Future<ApiResult<String>> storeTicket(TicketModel ticket) async {
    return await executeApi<String>(apiCall: () async {
      var id = await paymentDatasource.getUserId();
      return await paymentDatasource.storeTicket(ticket, id);
    });
  }
}
