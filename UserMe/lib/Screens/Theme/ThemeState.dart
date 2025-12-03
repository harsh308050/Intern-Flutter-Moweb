import 'package:flutter/material.dart';

class ThemeState {
  final ThemeMode themeMode;

  ThemeState(this.themeMode);

  ThemeState copyWith({ThemeState? status}) {
    return ThemeState(status?.themeMode ?? this.themeMode);
  }
}
