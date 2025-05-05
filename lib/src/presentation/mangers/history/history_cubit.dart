import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/core/error_handeler/error_handler.dart';
import 'package:tazkartak_app/src/data/models/ticket_model_with_id.dart';

import '../../../domain/usecase/history_usecase.dart';
import 'history_state.dart';

@injectable
class HistoryCubit extends Cubit<HistoryState> {
  final HistoryUsecase historyUsecase;
  HistoryCubit(this.historyUsecase) : super(const HistoryInitial());

  List<TicketModelWithId> tickets = [];

  Future<void> getAllTicketsByUserId() async {
    emit(const HistoryLoading());
    var result = await historyUsecase.getAllTicketsByUserId();
    switch (result) {
      case Success<List<TicketModelWithId>?>():
        if (result.data == []) {
          emit(const HistoryEmpty());
        } else {
          tickets = result.data!;
          emit(const HistoryLoaded());
        }
      case Failures<List<TicketModelWithId>?>():
        var error = ErrorHandler.fromException(result.exception);
        emit(HistoryError(error.errorMessage));
    }
  }
}
