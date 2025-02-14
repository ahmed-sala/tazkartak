import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_execute.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/data/datasource/contract/auth_datasource.dart';
import 'package:tazkartak_app/src/data/models/register_model.dart';
import 'package:tazkartak_app/src/domain/repository_contracts/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthDataSource _authDataSource;
  AuthRepoImpl(this._authDataSource);
  @override
  Future<ApiResult<void>> login(String email, String password) async {
    return await executeApi<void>(apiCall: () async {
      var result = await _authDataSource.login(email, password);
      if (!await _authDataSource.checkVerificationStatus()) {
        throw Exception('Email not verified');
      }
      var id = await _authDataSource.getUserId();
      await _authDataSource.saveUserId(id);
    });
  }

  @override
  Future<ApiResult<void>> register(RegisterModel registerModel) async {
    return await executeApi<void>(apiCall: () async {
      await _authDataSource.register(registerModel);
      await _authDataSource.sendVerificationEmail();
    });
  }

  @override
  Future<ApiResult<void>> saveUser(RegisterModel registerModel) async {
    return await executeApi<void>(apiCall: () async {
      await _authDataSource.saveUser(registerModel);
    });
  }

  @override
  Future<ApiResult<RegisterModel>> getUser() async {
    return await executeApi(apiCall: () async {
      var result = await _authDataSource.getUser();
      return result;
    });
  }

  @override
  Future<ApiResult<void>> logout() async {
    return await executeApi<void>(apiCall: () async {
      await _authDataSource.logout();
    });
  }

  @override
  Future<ApiResult<void>> updateUser(RegisterModel registerModel) async {
    return await executeApi<void>(apiCall: () async {
      await _authDataSource.updateProfile(registerModel);
    });
  }
}
