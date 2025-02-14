// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../src/data/api/api_services.dart' as _i318;
import '../../src/data/api/network_factory.dart' as _i801;
import '../../src/data/datasource/contract/auth_datasource.dart' as _i49;
import '../../src/data/datasource/contract/payment_datasource.dart' as _i706;
import '../../src/data/datasource/impl/auth_datasource_impl.dart' as _i1005;
import '../../src/data/datasource/impl/payment_datasource_impl.dart' as _i509;
import '../../src/data/repository/auth_repo_impl.dart' as _i644;
import '../../src/data/repository/payment_repo_impl.dart' as _i132;
import '../../src/domain/repository_contracts/auth_repo.dart' as _i146;
import '../../src/domain/repository_contracts/payment_repo.dart' as _i305;
import '../../src/domain/usecase/login_usecase.dart' as _i601;
import '../../src/domain/usecase/payment_usecase.dart' as _i863;
import '../../src/domain/usecase/profile_usecase.dart' as _i117;
import '../../src/domain/usecase/register_usecase.dart' as _i293;
import '../../src/presentation/mangers/auth/login/login_viewmodel.dart'
    as _i426;
import '../../src/presentation/mangers/auth/profile/profile_viewmodel.dart'
    as _i902;
import '../../src/presentation/mangers/auth/register/register_viewmodel.dart'
    as _i853;
import '../../src/presentation/mangers/payment/payment_cubit.dart' as _i177;
import '../../src/presentation/mangers/section/home/home_cubit.dart' as _i446;
import '../../src/presentation/mangers/section/section_Screen_viewmodel.dart'
    as _i290;
import '../helpers/firestore/firestore_module.dart' as _i929;
import '../helpers/firestore/firestore_services.dart' as _i769;
import '../helpers/shared_pref/shared_pref_moduel.dart' as _i802;
import '../service/location_manger/location_manger.dart' as _i861;
import '../service/location_manger/location_manger_impl.dart' as _i877;
import '../service/open_route_servie/open_route_service_api.dart' as _i938;
import '../service/open_route_servie/open_route_service_api_impl.dart' as _i107;

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
    final dioProvider = _$DioProvider();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPrefModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i290.SectionScreenViewmodel>(
        () => _i290.SectionScreenViewmodel());
    gh.lazySingleton<_i974.FirebaseFirestore>(
        () => firebaseModule.firebaseFirestore);
    gh.lazySingleton<_i361.Dio>(() => dioProvider.dioProvider());
    gh.lazySingleton<_i528.PrettyDioLogger>(() => dioProvider.providePretty());
    gh.factory<_i861.LocationManger>(() => _i877.LocationMangerImpl());
    gh.singleton<_i318.StripeDioService>(
        () => _i318.StripeDioService(gh<_i361.Dio>()));
    gh.factory<_i938.OpenRouteServiceApi>(
        () => _i107.OpenRouteServiceApiImpl());
    gh.factory<_i769.FirestoreService>(
        () => _i769.FirestoreService(gh<_i974.FirebaseFirestore>()));
    gh.factory<_i49.AuthDataSource>(() => _i1005.AuthDatasourceImpl(
          gh<_i769.FirestoreService>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.factory<_i146.AuthRepo>(
        () => _i644.AuthRepoImpl(gh<_i49.AuthDataSource>()));
    gh.factory<_i706.PaymentDatasource>(() => _i509.PaymentDatasourceImpl(
          gh<_i318.StripeDioService>(),
          gh<_i769.FirestoreService>(),
        ));
    gh.factory<_i305.PaymentRepo>(
        () => _i132.PaymentRepoImpl(gh<_i706.PaymentDatasource>()));
    gh.factory<_i601.LoginUsecase>(
        () => _i601.LoginUsecase(gh<_i146.AuthRepo>()));
    gh.factory<_i117.ProfileUsecase>(
        () => _i117.ProfileUsecase(gh<_i146.AuthRepo>()));
    gh.factory<_i293.RegisterUsecase>(
        () => _i293.RegisterUsecase(gh<_i146.AuthRepo>()));
    gh.factory<_i853.RegisterViewmodel>(
        () => _i853.RegisterViewmodel(gh<_i293.RegisterUsecase>()));
    gh.factory<_i863.PaymentUsecase>(
        () => _i863.PaymentUsecase(gh<_i305.PaymentRepo>()));
    gh.factory<_i902.ProfileViewmodel>(
        () => _i902.ProfileViewmodel(gh<_i117.ProfileUsecase>()));
    gh.factory<_i426.LoginViewmodel>(
        () => _i426.LoginViewmodel(gh<_i601.LoginUsecase>()));
    gh.factory<_i446.HomeCubit>(() => _i446.HomeCubit(
          gh<_i861.LocationManger>(),
          gh<_i938.OpenRouteServiceApi>(),
          gh<_i863.PaymentUsecase>(),
        ));
    gh.factory<_i177.PaymentCubit>(
        () => _i177.PaymentCubit(gh<_i863.PaymentUsecase>()));
    return this;
  }
}

class _$SharedPrefModule extends _i802.SharedPrefModule {}

class _$FirebaseModule extends _i929.FirebaseModule {}

class _$DioProvider extends _i801.DioProvider {}
