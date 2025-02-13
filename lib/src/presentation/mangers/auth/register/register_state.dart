part of 'register_viewmodel.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class UpdateSelectedDateState extends RegisterState {
  final DateTime? selectedDate;
  UpdateSelectedDateState(this.selectedDate);
}

final class RegisterSuccessState extends RegisterState {}

final class RegisterErrorState extends RegisterState {
  final String errorMessage;
  RegisterErrorState(this.errorMessage);
}

final class RegisterLoadingState extends RegisterState {}
