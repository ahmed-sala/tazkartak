import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tazkartak_app/core/dependency_injection/di.dart';
import 'package:tazkartak_app/core/helpers/validations.dart';
import 'package:tazkartak_app/core/styles/spacing.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:tazkartak_app/src/tazkartak.dart';

import '../../../../core/dialogs/awesome_dialoge.dart';
import '../../../../core/dialogs/show_hide_loading.dart';
import '../../../../core/routes/routes_name.dart';
import '../../mangers/auth/login/login_state.dart';
import '../../mangers/auth/login/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewmodel loginViewmodel = getIt<LoginViewmodel>();
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => loginViewmodel,
        child: Container(
          color: Color(0xFF0A2C66),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 31),
          child: BlocConsumer<LoginViewmodel, LoginState>(
              listener: (context, state) {
            if (state is LoginLoading) {
              showLoading(context, 'Logging in...');
            } else if (state is LoginSuccess) {
              // Navigate to the correct screen instead of RoutesName.login
              navKey.currentState!.pushNamedAndRemoveUntil(
                RoutesName.sectionScreen, // Change this to your intended route
                (route) => false,
              );
            } else if (state is LoginFailure) {
              showAwesomeDialog(
                context,
                title: 'Error',
                desc: state.message,
                onOk: () {},
                dialogType: DialogType.error,
              );
            }
          }, listenWhen: (previous, current) {
            if (previous is LoginLoading || previous is LoginFailure) {
              hideLoading();
            }
            return current is! LoginInitial;
          }, builder: (context, state) {
            return SafeArea(
              child: Form(
                key: loginViewmodel.formKey,
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
                    Text('Email',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    verticalSpace(8),
                    CustomTextFormField(
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      controller: loginViewmodel.emailController,
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
                      controller: loginViewmodel.passwordController,
                      validator: (val) {
                        return Validations.validatePassword(val);
                      },
                      labelText: 'Password',
                    ),
                    verticalSpace(16),
                    Row(
                      children: [
                        Spacer(),
                        Text('Forgot Password?',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                    verticalSpace(16),
                    Center(
                      child: CustomAuthButton(
                          text: 'Log In',
                          onPressed: () {
                            loginViewmodel.login();
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
                            fontWeight:
                                FontWeight.w400, // Match bold text in the image
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
                    Center(
                      child: SizedBox(
                        width: 283,
                        child: SizedBox(
                          width: 283,
                          child: Text(
                            'No account yet? Open yours now.',
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
                        text: 'Create Account',
                        onPressed: () {
                          navKey.currentState!.pushNamedAndRemoveUntil(
                              RoutesName.register, (route) => false);
                        },
                        color: Colors.white,
                        textColor: Colors.black),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
