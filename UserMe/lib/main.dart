// import 'dart:developer';

import 'package:UserMe/Screens/Theme/ThemeBloc.dart';
import 'package:UserMe/Screens/Theme/ThemeState.dart';
import 'package:UserMe/Screens/Theme/Theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Components/CM.dart';
import 'Http/bloc/bloc.dart';
import 'Http/bloc/state.dart';
import 'Screens/User/model/user_res_model.dart';
import 'package:flutter/material.dart';

import 'Screens/Splash/SplashScreen.dart';
import 'Utils/SharedPrefHelper.dart';
import 'Utils/utils.dart';

UserResModel? user;
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefInit();
  runApp(MyApp());
}

final ThemeBloc themeBloc = ThemeBloc();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ConnectionBloc connectionBloc = ConnectionBloc();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectionBloc, ConnectivityState>(
      bloc: connectionBloc,
      listener: (context, state) {
        if (state.status == Status.failed) {
          showSnackBar(
            navigatorKey.currentContext!,
            'No Internet! Check Your Connection',
            UIColours.errorColor,
          );
        } else if (state.status == Status.success) {
          showSnackBar(
            navigatorKey.currentContext!,
            'Internet Connected',
            UIColours.successColor,
          );
        }
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: themeBloc,
        builder: (context, themeState) => MaterialApp(
          navigatorKey: navigatorKey,
          home: SplashScreen(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
