import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/data/models/register_model.dart';
import 'package:tazkartak_app/src/domain/repository_contracts/auth_repo.dart';

@injectable
class RegisterUsecase {
  AuthRepo _authRepo;
  RegisterUsecase(this._authRepo);
  Future<ApiResult<void>> invoke(RegisterModel registerModel) async {
    var result = await _authRepo.register(registerModel);
    return result;
  }

  Future<ApiResult<void>> saveUser(RegisterModel registerModel) async {
    var result = await _authRepo.saveUser(registerModel);
    return result;
  }
}
