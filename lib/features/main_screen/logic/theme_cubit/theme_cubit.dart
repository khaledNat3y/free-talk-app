import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(true); // false = light mode, true = dark mode

  void toggleTheme() {
    emit(!state);
  }

  void setTheme(bool isDark) {
    emit(isDark);
  }

  bool get isDarkMode => state;
}