import 'package:UserMe/Screens/Theme/ThemeEvent.dart';
import 'package:UserMe/Screens/Theme/ThemeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ChangeThemeEvent, ThemeState> {
  ThemeBloc() : super((InitialState())) {
    on<ChangeThemeEvent>(getThemeMode);
  }

  void getThemeMode(ChangeThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeState(event.themeMode));
  }
}
