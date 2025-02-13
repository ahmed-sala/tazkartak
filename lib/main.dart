import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tazkartak_app/src/tazkartak.dart';

import 'core/dependency_injection/di.dart';
import 'core/utils/bloc_observer/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsFlutterBinding,
  );
  await configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.clearPersistence();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
    sslEnabled: true,
    host: 'firestore.googleapis.com',
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  Bloc.observer = MyBlocObserver();
  runApp(const TazkartakApp());
}
