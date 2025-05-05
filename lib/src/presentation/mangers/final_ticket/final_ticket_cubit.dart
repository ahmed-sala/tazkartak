import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/error_handeler/error_handler.dart';
import 'package:tazkartak_app/src/data/models/ticket_model.dart';
import 'package:tazkartak_app/src/domain/usecase/payment_usecase.dart';

import 'final_ticket_state.dart';

// src/presentation/mangers/final_ticket/final_ticket_cubit.dart

@injectable
class FinalTicketCubit extends Cubit<FinalTicketState> {
  final PaymentUsecase _paymentUsecase;
  StreamSubscription<TicketModel?>? _sub;

  FinalTicketCubit(this._paymentUsecase) : super(const FinalTicketInitial());

  TicketModel? ticketModel;

  void subscribeToTicket(String ticketId) {
    emit(const FinalTicketLoading());
    _sub?.cancel();
    _sub = _paymentUsecase.watchTicketById(ticketId).listen(
      (ticket) {
        ticketModel = ticket;
        emit(const FinalTicketSuccess());
      },
      onError: (e) {
        final msg = ErrorHandler.fromException(e).errorMessage;
        emit(FinalTicketError(msg));
      },
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
