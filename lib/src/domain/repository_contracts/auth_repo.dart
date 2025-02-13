import 'package:tazkartak_app/core/common/api/api_result.dart';

import '../../data/models/register_model.dart';

abstract interface class AuthRepo {
  Future<ApiResult<void>> login(String email, String password);
  Future<ApiResult<void>> register(RegisterModel registerModel);
  Future<ApiResult<void>> saveUser(RegisterModel registerModel);
  Future<ApiResult<void>> logout();
  Future<ApiResult<RegisterModel>> getUser();
  Future<ApiResult<void>> updateUser(RegisterModel registerModel);
}
