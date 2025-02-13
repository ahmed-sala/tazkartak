// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../src/data/datasource/contract/auth_datasource.dart' as _i49;
import '../../src/data/datasource/impl/auth_datasource_impl.dart' as _i1005;
import '../../src/data/repository/auth_repo_impl.dart' as _i644;
import '../../src/domain/repository_contracts/auth_repo.dart' as _i146;
import '../../src/domain/usecase/login_usecase.dart' as _i601;
import '../../src/domain/usecase/profile_usecase.dart' as _i117;
import '../../src/domain/usecase/register_usecase.dart' as _i293;
import '../../src/presentation/mangers/auth/login/login_viewmodel.dart'
    as _i426;
import '../../src/presentation/mangers/auth/profile/profile_viewmodel.dart'
    as _i902;
import '../../src/presentation/mangers/auth/register/register_viewmodel.dart'
    as _i853;
import '../../src/presentation/mangers/section/section_Screen_viewmodel.dart'
    as _i290;
import '../helpers/firestore/firestore_module.dart' as _i929;
import '../helpers/firestore/firestore_services.dart' as _i769;
import '../helpers/shared_pref/shared_pref_module.dart' as _i976;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPrefModule = _$SharedPrefModule();
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i290.SectionScreenViewmodel>(
        () => _i290.SectionScreenViewmodel());
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => sharedPrefModule.secureStorage);
    gh.factory<_i769.FirestoreService>(
        () => _i769.FirestoreService(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i49.AuthDataSource>(
        () => _i1005.AuthDatasourceImpl(gh<_i769.FirestoreService>()));
    gh.factory<_i146.AuthRepo>(
        () => _i644.AuthRepoImpl(gh<_i49.AuthDataSource>()));
    gh.factory<_i601.LoginUsecase>(
        () => _i601.LoginUsecase(gh<_i146.AuthRepo>()));
    gh.factory<_i293.RegisterUsecase>(
        () => _i293.RegisterUsecase(gh<_i146.AuthRepo>()));
    gh.factory<_i117.ProfileUsecase>(
        () => _i117.ProfileUsecase(gh<_i146.AuthRepo>()));
    gh.factory<_i853.RegisterViewmodel>(
        () => _i853.RegisterViewmodel(gh<_i293.RegisterUsecase>()));
    gh.factory<_i902.ProfileViewmodel>(
        () => _i902.ProfileViewmodel(gh<_i117.ProfileUsecase>()));
    gh.factory<_i426.LoginViewmodel>(
        () => _i426.LoginViewmodel(gh<_i601.LoginUsecase>()));
    return this;
  }
}

class _$SharedPrefModule extends _i976.SharedPrefModule {}

class _$FirebaseModule extends _i929.FirebaseModule {}
