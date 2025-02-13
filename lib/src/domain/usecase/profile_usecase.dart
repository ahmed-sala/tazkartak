import 'package:injectable/injectable.dart';

import '../../../core/common/api/api_result.dart';
import '../../data/models/register_model.dart';
import '../repository_contracts/auth_repo.dart';

@injectable
class ProfileUsecase {
  AuthRepo _authRepo;
  ProfileUsecase(this._authRepo);
  Future<ApiResult<RegisterModel>> getUser() async {
    return await _authRepo.getUser();
  }
}
