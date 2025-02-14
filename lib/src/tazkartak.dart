import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:tazkartak_app/core/dependency_injection/di.dart';
import 'package:tazkartak_app/core/routes/routes_name.dart';
import 'package:tazkartak_app/src/domain/usecase/payment_usecase.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/home/home_cubit.dart';

import '../core/routes/app_route.dart';
import '../core/service/location_manger/location_manger_impl.dart';
import '../core/service/open_route_servie/open_route_service_api_impl.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class TazkartakApp extends StatefulWidget {
  const TazkartakApp({super.key});

  @override
  State<TazkartakApp> createState() => _TazkartakAppState();
}

class _TazkartakAppState extends State<TazkartakApp> {
  String? _initialRoute = RoutesName.login;
  bool _isInitialized = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    // // Perform initialization logic

    // Ensure the splash screen is removed after initialization
    FlutterNativeSplash.remove();

    // setState(() {
    //   _isInitialized = true;
    // });
  }

  var paymentUseCase = getIt.get<PaymentUsecase>();

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox
          .shrink(); // Display nothing until initialization is complete
    }
    return BlocProvider(
      create: (context) => HomeCubit(LocationMangerImpl(),
          OpenRouteServiceApiImpl(),paymentUseCase),
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) =>
              MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Tazkartak',
                navigatorKey: navKey,
                initialRoute: _initialRoute,

                onGenerateRoute: AppRoute.onGenerateRoute,
              )),
    );
  }
}
