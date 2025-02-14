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
        width: double.infinity,
        // Use a gradient background for a modern metro look
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade700,
              Colors.deepPurple.shade300,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 31),
        child: BlocProvider(
          create: (context) => registerViewmodel,
          child: SingleChildScrollView(
            child: SafeArea(
              child: BlocConsumer<RegisterViewmodel, RegisterState>(
                listener: (context, state) {
                  // Handle state changes using a switch-case style
                  switch (state) {
                    case RegisterSuccessState():
                      hideLoading();
                      showAwesomeDialog(
                        context,
                        title: 'Success',
                        desc:
                            'Registration successful. Check your email to verify your account',
                        onOk: () {
                          navKey.currentState!.pushNamedAndRemoveUntil(
                              RoutesName.login, (route) => false);
                        },
                        dialogType: DialogType.success,
                      );
                      break;
                    case RegisterErrorState():
                      hideLoading();
                      showAwesomeDialog(
                        context,
                        title: 'Error',
                        desc: state.errorMessage,
                        onOk: () {},
                        dialogType: DialogType.error,
                      );
                      break;
                    case RegisterLoadingState():
                      showLoading(context, 'Registering...');
                      break;
                    default:
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: registerViewmodel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(48),
                        // Logo and App Title
                        Center(
                          child: Container(
                            width: 144,
                            height: 144,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(16),
                        Center(
                          child: Text(
                            'Tazkartak',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        verticalSpace(24),
                        // Form Fields Card
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Name Field
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 12),
                                ),
                                verticalSpace(8),
                                CustomTextFormField(
                                  hintText: 'Enter your name',
                                  keyboardType: TextInputType.name,
                                  controller: registerViewmodel.nameController,
                                  validator: (val) =>
                                      Validations.validateName(val),
                                  labelText: 'Full Name',
                                ),
                                verticalSpace(14),
                                // Email Field
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 12),
                                ),
                                verticalSpace(8),
                                CustomTextFormField(
                                  hintText: 'Enter your email',
                                  keyboardType: TextInputType.emailAddress,
                                  controller: registerViewmodel.emailController,
                                  validator: (val) =>
                                      Validations.validateEmail(val),
                                  labelText: 'Email Address',
                                ),
                                verticalSpace(16),
                                // Password Field
                                Text(
                                  'Password',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 12),
                                ),
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
                                  controller:
                                      registerViewmodel.passwordController,
                                  validator: (val) =>
                                      Validations.validatePassword(val),
                                  labelText: 'Password',
                                ),
                                verticalSpace(16),
                                // Confirm Password Field
                                Text(
                                  'Confirm Password',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 12),
                                ),
                                verticalSpace(8),
                                CustomTextFormField(
                                  isPasswordVisible: confirmPasswordVisible,
                                  showPassword: () {
                                    setState(() {
                                      confirmPasswordVisible =
                                          !confirmPasswordVisible;
                                    });
                                  },
                                  hintText: 'Confirm your Password',
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: registerViewmodel
                                      .confirmPasswordController,
                                  validator: (val) =>
                                      Validations.validateConfirmPassword(
                                          val,
                                          registerViewmodel
                                              .passwordController.text),
                                  labelText: 'Confirm Password',
                                ),
                                verticalSpace(16),
                                // Date Input Field
                                DateInputField(
                                  selectedDate: registerViewmodel.selectedDate,
                                  onDateSelected:
                                      registerViewmodel.updateSelectedDate,
                                ),
                                verticalSpace(16),
                                // Gender Selection
                                GenderRadioButtonRow(),
                                verticalSpace(16),
                                // Create Account Button
                                Center(
                                  child: CustomAuthButton(
                                    text: 'Create Account',
                                    onPressed: () {
                                      registerViewmodel.register();
                                    },
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(24),
                        // Divider with "OR"
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white,
                                thickness: 1.2,
                                endIndent: 10,
                              ),
                            ),
                            Text(
                              'OR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white,
                                thickness: 1.2,
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(26),
                        // Already have an account? Log in.
                        Center(
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
                        verticalSpace(28),
                        Center(
                          child: CustomAuthButton(
                            text: 'Log In',
                            onPressed: () {
                              navKey.currentState!.pushNamedAndRemoveUntil(
                                  RoutesName.login, (route) => false);
                            },
                            color: Colors.white,
                            textColor: Colors.black,
                          ),
                        ),
                        verticalSpace(60),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
