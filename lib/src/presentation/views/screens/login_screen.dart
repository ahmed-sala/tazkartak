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
  LoginScreen({Key? key}) : super(key: key);

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
          width: double.infinity,
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
          child: BlocConsumer<LoginViewmodel, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                showLoading(context, 'Logging in...');
              } else if (state is LoginSuccess) {
                // Navigate to your intended route after login success
                navKey.currentState!.pushNamedAndRemoveUntil(
                  RoutesName.sectionScreen,
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
            },
            listenWhen: (previous, current) {
              if (previous is LoginLoading || previous is LoginFailure) {
                hideLoading();
              }
              return current is! LoginInitial;
            },
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: loginViewmodel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(48),
                        // Logo Section
                        Center(
                          child: Container(
                            width: 144,
                            height: 144,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
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
                        // Login Form Card
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                  controller: loginViewmodel.emailController,
                                  validator: (val) {
                                    return Validations.validateEmail(val);
                                  },
                                  labelText: 'Email Address',
                                ),
                                verticalSpace(16),
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
                                  controller: loginViewmodel.passwordController,
                                  validator: (val) {
                                    return Validations.validatePassword(val);
                                  },
                                  labelText: 'Password',
                                ),
                                verticalSpace(16),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                verticalSpace(16),
                                Center(
                                  child: CustomAuthButton(
                                    text: 'Log In',
                                    onPressed: () {
                                      loginViewmodel.login();
                                    },
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        verticalSpace(24),
                        // Divider with OR
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
                        // Create Account Prompt
                        Center(
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
                        verticalSpace(28),
                        Center(
                          child: CustomAuthButton(
                            text: 'Create Account',
                            onPressed: () {
                              navKey.currentState!.pushNamedAndRemoveUntil(
                                RoutesName.register,
                                (route) => false,
                              );
                            },
                            color: Colors.white,
                            textColor: Colors.black,
                          ),
                        ),
                        verticalSpace(52),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
