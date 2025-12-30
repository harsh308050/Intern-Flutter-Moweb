import 'package:UserMe/Screens/Theme/ThemeBloc.dart';
import 'package:UserMe/Screens/Theme/ThemeState.dart';
import 'package:UserMe/Screens/Theme/Theme_colors.dart';
import 'package:UserMe/Utils/remoteConfig.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Components/CM.dart';
import 'Http/bloc/bloc.dart';
import 'Http/bloc/state.dart';
import 'Screens/Notification/notification_service.dart';
import 'Screens/User/model/user_res_model.dart';
import 'package:flutter/material.dart';
import 'Screens/Splash/SplashScreen.dart';
import 'Utils/SharedPrefHelper.dart';
import 'Utils/utils.dart';
import 'firebase_options.dart';

UserResModel? user;
final navigatorKey = GlobalKey<NavigatorState>();
final ThemeBloc themeBloc = ThemeBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefInit();
  await NotificationService().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await remoteConfigSetup();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConnectionBloc connectionBloc = ConnectionBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().handleInitialNavigation();
    });
  }

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
        builder: (context, themeState) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            home: SplashScreen(),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
