import 'package:flutter/material.dart';
import 'package:tazkartak_app/core/helpers/validations.dart';
import 'package:tazkartak_app/core/styles/spacing.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:tazkartak_app/src/presentation/shared_widgets/custom_auth_text_feild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF0A2C66),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 31),
        child: SafeArea(
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
                isPassword: false,
                controller: TextEditingController(),
                validator: (val) {
                  return Validations.validateEmail(val);
                },
              ),
              verticalSpace(16),
              Text('Password',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              verticalSpace(8),
              CustomTextFormField(
                hintText: 'Enter your Password',
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: TextEditingController(),
                validator: (val) {
                  return Validations.validatePassword(val);
                },
              ),
              verticalSpace(16),
              Row(
                children: [
                  Spacer(),
                  Text('Forgot Password?',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              verticalSpace(16),
              Center(
                child: Container(
                  width: 182,
                  child: CustomAuthButton(
                      text: 'Log In',
                      onPressed: () {},
                      color: Color(0x7F2785E5)),
                ),
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
                      fontSize: 15, // Slightly larger for better visibility
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
                  onPressed: () {},
                  color: Colors.white,
                  textColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
