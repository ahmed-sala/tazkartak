sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileUserUploaded extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  ProfileErrorState(this.errorMessage);
}

class LogOutLoadingState extends ProfileState {}

class LogOutSuccessState extends ProfileState {}

class LogOutErrorState extends ProfileState {
  final String errorMessage;

  LogOutErrorState(this.errorMessage);
}
