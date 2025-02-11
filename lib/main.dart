import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tazkartak_app/src/tazkartak.dart';

import 'core/dependency_injection/di.dart';
import 'core/utils/bloc_observer/bloc_observer.dart';

void main() async {
  WidgetsBinding widgetsFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsFlutterBinding,
  );

  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const TazkartakApp());
}
