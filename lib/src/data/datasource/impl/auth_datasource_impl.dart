import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tazkartak_app/core/helpers/firestore/firestore_services.dart';
import 'package:tazkartak_app/src/data/datasource/contract/auth_datasource.dart';
import 'package:tazkartak_app/src/data/models/register_model.dart';

@Injectable(as: AuthDataSource)
class AuthDatasourceImpl implements AuthDataSource {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirestoreService _firestoreService;
  SharedPreferences _sharedPreferences;
  AuthDatasourceImpl(this._firestoreService, this._sharedPreferences);
  @override
  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> register(RegisterModel registerModel) async {
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerModel.email, password: registerModel.password);
  }

  @override
  Future<void> saveUser(RegisterModel registerModel) async {
    registerModel.id = _firebaseAuth.currentUser!.uid;
    await _firestoreService.addDocument(
        'users', registerModel.toJson(), registerModel.id!);
  }

  @override
  Future<void> sendVerificationEmail() async {
    await _firebaseAuth.currentUser!.sendEmailVerification();
  }

  @override
  Future<bool> checkVerificationStatus() async {
    return await _firebaseAuth.currentUser!.emailVerified;
  }

  @override
  Future<RegisterModel> getUser() async {
    var currentUser = _firebaseAuth.currentUser;
    var user =
        await _firestoreService.getDocumentById('users', currentUser!.uid);
    RegisterModel registerModel = RegisterModel.fromJson(user!);
    return registerModel;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> updateProfile(RegisterModel registerModel) async {
    var currentUser = _firebaseAuth.currentUser;
    await _firestoreService.updateDocument(
        'users', currentUser!.uid, registerModel.toJson());
  }

  @override
  Future<void> saveUserId(String userId) async {
    await _sharedPreferences.setString('userId', userId);
  }

  @override
  Future<String> getUserId() async {
    return _firebaseAuth.currentUser!.uid;
  }
}
