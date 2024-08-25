import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeController extends Notifier<bool> {
  @override
  bool build() {
    return true;
  }

  void toggleTheme(bool value) {
    state = value;
  }
}

final themeController =
    NotifierProvider<ThemeController, bool>(() => ThemeController());
