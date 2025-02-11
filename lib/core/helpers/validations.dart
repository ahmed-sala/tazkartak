import 'app_regexp.dart';

abstract class Validations {
  static String? validateName(String? name) {
    if (name!.isEmpty || !AppRegExp.isNameValid(name)) {
      return 'Name is required';
    }
    return null;
  }

  static String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Email is required!';
    } else if (!AppRegExp.isEmailValid(email)) {
      return 'Invalid Email!';
    }

    return null;
  }

  static String? validateJobTitle(String? jobTitle) {
    if (jobTitle!.isEmpty) {
      return 'Job Title is required!';
    }
    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber!.isEmpty || !AppRegExp.isPhoneNumberValid(phoneNumber)) {
      return 'Phone number is required!';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Password is required!';
    } else if (!AppRegExp.isPasswordValid(password)) {
      return 'Invalid Password!';
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword!.isEmpty ||
        !AppRegExp.isPasswordValid(confirmPassword)) {
      return 'Confirm Password is required!';
    } else if (password != confirmPassword) {
      return 'Password and Confirm Password must be same!';
    }
    return null;
  }

  static String? validateOTP(String? otp) {
    if (otp!.isEmpty || !AppRegExp.isOTPValid(otp)) {
      return 'OTP is required!';
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username!.isEmpty || !AppRegExp.isUsernameValid(username)) {
      return 'Username is required!';
    }
    return null;
  }

  static String? validateAddress(String? address) {
    if (address!.isEmpty) {
      return 'Address is required!';
    }
    return null;
  }
}
