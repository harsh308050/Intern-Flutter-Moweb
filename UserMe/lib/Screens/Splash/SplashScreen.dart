import 'dart:developer';

import 'package:UserMe/Screens/Splash/bloc/bloc.dart';
import 'package:UserMe/Screens/Splash/bloc/event.dart';
import 'package:UserMe/Screens/Splash/bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Components/CM.dart';
import '../../Utils/utils.dart';
import 'package:flutter/material.dart';
import '/Routes/routes.dart';
import '/main.dart';

import '/utils/SharedPrefHelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ConnectionBloc connectionBloc = ConnectionBloc();

  @override
  void initState() {
    super.initState();
    connectionBloc;
  }

  Future<void> initializePrefs() async {
    await sharedPrefInit();
    var userToken = sharedPrefGetToken();
    user = sharedPrefGetUser();
    Future.delayed(Duration(seconds: 3), () {
      userToken != null
          ? Routes.navigateToHomePage(context, user: user)
          : Routes.navigateToLoginScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ConnectionBloc, ConnectivityState>(
        bloc: connectionBloc,
        listener: (context, state) {
          if (state.status == Status.failed) {
            CM.showSnackBar(
              context,
              'No internet connection. Please try again later.',
              UIColours.errorColor,
            );
          }
          if (state.status == Status.success) {
            initializePrefs();
            log('Internet connected, proceeding to initialize preferences.');
          }
        },
        child: Container(
          color: UIColours.primaryColor,
          child: Center(
            child: Text(
              'UserMe',
              style: TextStyle(
                fontSize: UISizes.titleFontSize,
                fontWeight: FontWeight.bold,
                color: UIColours.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
