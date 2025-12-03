import 'package:UserMe/Screens/Theme/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BlocEvent {}

class ChangeThemeEvent extends BlocEvent {
  final ThemeMode themeMode;
  ChangeThemeEvent({required this.themeMode});
}

class InitialState extends ThemeState {
  InitialState() : super(ThemeMode.light);
}
