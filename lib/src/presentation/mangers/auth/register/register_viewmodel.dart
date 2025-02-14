import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/core/error_handeler/error_handler.dart';
import 'package:tazkartak_app/src/data/models/register_model.dart';
import 'package:tazkartak_app/src/domain/usecase/register_usecase.dart';

part 'register_state.dart';

@injectable
class RegisterViewmodel extends Cubit<RegisterState> {
  RegisterUsecase _registerUsecase;
  RegisterViewmodel(this._registerUsecase) : super(RegisterInitial());
  Gender selectedGender = Gender.none;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  DateTime? selectedDate;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    emit(UpdateSelectedDateState(selectedDate));
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      try {
        RegisterModel registerModel = RegisterModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          gender: selectedGender.name,
          birthDate: selectedDate!,
        );
        var result = await _registerUsecase.invoke(registerModel);
        switch (result) {
          case Failures<void>():
            var errorMessage =
                ErrorHandler.fromException(result.exception).errorMessage;
            emit(RegisterErrorState(errorMessage));
            return;

          default:
        }
        var result2 = await _registerUsecase.saveUser(registerModel);
        switch (result2) {
          case Failures<void>():
            var errorMessage =
                ErrorHandler.fromException(result2.exception).errorMessage;
            emit(RegisterErrorState(errorMessage));
            return;
          default:
        }

        emit(RegisterSuccessState());
      } catch (e) {
        emit(RegisterErrorState(e.toString()));
      }
    }
  }
}

enum Gender { none, male, female }
