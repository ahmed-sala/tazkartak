import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/data/models/register_model.dart';
import 'package:tazkartak_app/src/domain/usecase/profile_usecase.dart';
import 'package:tazkartak_app/src/presentation/mangers/auth/profile/profile_state.dart';

import '../../../../../core/error_handeler/error_handler.dart';

@injectable
class ProfileViewmodel extends Cubit<ProfileState> {
  ProfileUsecase _profileUsecase;
  ProfileViewmodel(this._profileUsecase) : super(ProfileInitial());
  late RegisterModel user;
  Future<void> getUser() async {
    emit(ProfileLoadingState());
    try {
      final result = await _profileUsecase.getUser();
      switch (result) {
        case Success<RegisterModel>():
          user = result.data!;
          emit(ProfileUserUploaded());
        case Failures<RegisterModel>():
          var errorMessage =
              ErrorHandler.fromException(result.exception).errorMessage;
          emit(ProfileErrorState(errorMessage));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
