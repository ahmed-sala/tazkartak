import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/core/common/api/api_result.dart';
import 'package:tazkartak_app/src/domain/repository_contracts/auth_repo.dart';

@injectable
class LoginUsecase {
  AuthRepo _authRepo;
  LoginUsecase(this._authRepo);
  Future<ApiResult<void>> invoke(String email, String password) async {
    var result = await _authRepo.login(email, password);
    return result;
  }
}
