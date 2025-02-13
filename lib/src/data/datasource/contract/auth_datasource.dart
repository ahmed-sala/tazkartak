import 'package:tazkartak_app/src/data/models/register_model.dart';

abstract interface class AuthDataSource {
  Future<void> login(String email, String password);
  Future<void> saveUser(RegisterModel registerModel);
  Future<void> sendVerificationEmail();
  Future<void> register(RegisterModel registerModel);
  Future<bool> checkVerificationStatus();
  Future<RegisterModel> getUser();
  Future<void> logout();
  Future<void> updateProfile(RegisterModel registerModel);
}
