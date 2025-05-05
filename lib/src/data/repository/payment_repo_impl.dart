import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_execute.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/data/datasource/contract/payment_datasource.dart';
import 'package:tazkartak_app/src/data/models/ticket_model.dart';

import '../../domain/repository_contracts/payment_repo.dart';
import '../models/ticket_model_with_id.dart';

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

  @override
  Future<ApiResult<TicketModel?>> getTicketById(String ticketId) async {
    return await executeApi<TicketModel?>(apiCall: () async {
      return await paymentDatasource.getTicketById(ticketId);
    });
  }

  @override
  Future<ApiResult<List<TicketModelWithId>?>> getAllTicketsByUserId() {
    return executeApi<List<TicketModelWithId>?>(apiCall: () async {
      var id = await paymentDatasource.getUserId();
      return await paymentDatasource.getAllTicketsByUserId(id);
    });
  }

  @override
  Stream<TicketModel?> watchTicketById(String ticketId) {
    return paymentDatasource.watchTicketById(ticketId);
  }
}
