import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:tazkartak_app/src/domain/usecase/payment_usecase.dart';

part 'payment_state.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentUsecase paymentUsecase;
  PaymentCubit(this.paymentUsecase) : super(PaymentInitial());
}
