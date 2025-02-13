import 'package:flutter/material.dart';
import 'package:tazkartak_app/core/routes/routes_name.dart';
import 'package:tazkartak_app/src/presentation/views/screens/section_screen.dart';

import '../../src/presentation/views/screens/login_screen.dart';
import '../../src/presentation/views/screens/register_screen.dart';

class AppRoute {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return _handelMaterialPageRoute(
            settings: settings, widget: LoginScreen());

      case RoutesName.register:
        return _handelMaterialPageRoute(
            settings: settings, widget: RegisterScreen());
      case RoutesName.sectionScreen:
        return _handelMaterialPageRoute(
            settings: settings, widget: SectionScreen());
      default:
        return _handelMaterialPageRoute(
            settings: settings, widget: const Scaffold());
    }
  }

  static MaterialPageRoute<dynamic> _handelMaterialPageRoute(
      {required Widget widget, required RouteSettings settings}) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
