sealed class HomeState {}

class HomeStateInitialState extends HomeState {}

class GetLocationUserLoadingState extends HomeState {}

class GetLocationUserSuccessState extends HomeState {}

class GetLocationUserFailuresState extends HomeState {
  final String errorMassage;
  GetLocationUserFailuresState({required this.errorMassage});
}

class GetRoutesLoadingState extends HomeState {}

class GetRoutesSuccessState extends HomeState {}

class GetRoutesFailuresState extends HomeState {
  final String errorMassage;
  GetRoutesFailuresState({required this.errorMassage});
}

class CancelPaymentState extends HomeState {}

class PaymentSuccessState extends HomeState {}
