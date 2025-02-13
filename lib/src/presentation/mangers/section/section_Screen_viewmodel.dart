import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tazkartak_app/src/presentation/mangers/section/section_screen_states.dart';
import 'package:tazkartak_app/src/presentation/views/screens/profile_screen.dart';

import '../../views/screens/home/home_screen.dart';
import '../../views/screens/tikets_hitory/line_metro.dart';

@injectable
class SectionScreenViewmodel extends Cubit<SectionScreenState> {
  SectionScreenViewmodel() : super(HomeInitial());

  int _currentIndex = 0;

  // Expose current index
  int get currentIndex => _currentIndex;

  final List<String> _titles = [
    'Home',
    'Categories',
    'Cart',
    'Profile',
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    LineMetro(),
    ProfileScreen(),
  ];

  String get currentTitle => _titles[_currentIndex];
  Widget get currentScreen => _screens[_currentIndex];

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    emit(HomeStateUpdated());
  }
}
