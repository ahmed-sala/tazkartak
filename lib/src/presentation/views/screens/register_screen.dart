import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tazkartak_app/core/dependency_injection/di.dart';
import 'package:tazkartak_app/core/dialogs/awesome_dialoge.dart';
import 'package:tazkartak_app/core/dialogs/show_hide_loading.dart';
import 'package:tazkartak_app/core/helpers/validations.dart';
import 'package:tazkartak_app/core/routes/routes_name.dart';
import 'package:tazkartak_app/core/styles/spacing.dart';
import 'package:tazkartak_app/src/presentation/mangers/auth/register/register_viewmodel.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_date_feild.dart';
import 'package:tazkartak_app/src/tazkartak.dart';

import '../widgets/gender_radio_button_row.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewmodel registerViewmodel = getIt.get<RegisterViewmodel>();
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF0A2C66),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 31),
        child: BlocProvider(
          create: (context) => registerViewmodel,
          child: SingleChildScrollView(
            child: SafeArea(
              child: BlocConsumer<RegisterViewmodel, RegisterState>(
                  listener: (context, state) {
                switch (state) {
                  case RegisterSuccessState():
                    hideLoading();
                    showAwesomeDialog(context,
                        title: 'Success',
                        desc:
                            'Registration successful check your email to verify your account',
                        onOk: () {
                      navKey.currentState!.pushNamedAndRemoveUntil(
                          RoutesName.login, (route) => false);
                    }, dialogType: DialogType.success);
                  case RegisterErrorState():
                    hideLoading();
                    showAwesomeDialog(context,
                        title: 'Error',
                        desc: state.errorMessage,
                        onOk: () {},
                        dialogType: DialogType.error);
                  case RegisterLoadingState():
                    showLoading(context, 'Registering...');
                  default:
                }
              }, builder: (context, state) {
                return Form(
                  key: registerViewmodel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(48),
                      Center(
                          child: Image.asset('assets/images/logo.png',
                              width: 144, height: 144)),
                      Center(
                        child: const Text('Tazkartak',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                      ),
                      verticalSpace(14),
                      Text('Name',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      verticalSpace(8),
                      CustomTextFormField(
                        hintText: 'Enter your name',
                        keyboardType: TextInputType.name,
                        controller: registerViewmodel.nameController,
                        validator: (val) {
                          return Validations.validateName(val);
                        },
                        labelText: 'Full Name',
                      ),
                      verticalSpace(14),
                      const Text('Email',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      verticalSpace(8),
                      CustomTextFormField(
                        hintText: 'Enter your email',
                        keyboardType: TextInputType.emailAddress,
                        controller: registerViewmodel.emailController,
                        validator: (val) {
                          return Validations.validateEmail(val);
                        },
                        labelText: 'Email Address',
                      ),
                      verticalSpace(16),
                      Text('Password',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      verticalSpace(8),
                      CustomTextFormField(
                        isPasswordVisible: passwordVisible,
                        showPassword: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        hintText: 'Enter your Password',
                        keyboardType: TextInputType.visiblePassword,
                        controller: registerViewmodel.passwordController,
                        validator: (val) {
                          return Validations.validatePassword(val);
                        },
                        labelText: 'Password',
                      ),
                      verticalSpace(16),
                      Text('Confirm Password',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      verticalSpace(8),
                      CustomTextFormField(
                        isPasswordVisible: confirmPasswordVisible,
                        showPassword: () {
                          setState(() {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          });
                        },
                        hintText: 'Confirm your Password',
                        keyboardType: TextInputType.visiblePassword,
                        controller: registerViewmodel.confirmPasswordController,
                        validator: (val) {
                          return Validations.validateConfirmPassword(
                              val, registerViewmodel.passwordController.text);
                        },
                        labelText: 'Confirm Password',
                      ),
                      verticalSpace(16),
                      DateInputField(
                          selectedDate: registerViewmodel.selectedDate,
                          onDateSelected: registerViewmodel.updateSelectedDate),
                      verticalSpace(16),
                      GenderRadioButtonRow(),
                      verticalSpace(16),
                      Center(
                        child: CustomAuthButton(
                            text: 'Create Account',
                            onPressed: () {
                              registerViewmodel.register();
                            },
                            color: Color(0x7F2785E5)),
                      ),
                      verticalSpace(52),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.2, // Adjust thickness if needed
                              endIndent: 10, // Space between line and text
                            ),
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              // Slightly larger for better visibility
                              fontWeight: FontWeight
                                  .w400, // Match bold text in the image
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.2,
                              indent: 10, // Space between line and text
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(26),
                      const Center(
                        child: SizedBox(
                          width: 283,
                          child: SizedBox(
                            width: 283,
                            child: Text(
                              'Already have an account? Log in.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(28),
                      CustomAuthButton(
                          text: 'Log In',
                          onPressed: () {},
                          color: Colors.white,
                          textColor: Colors.black),
                      verticalSpace(60),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
