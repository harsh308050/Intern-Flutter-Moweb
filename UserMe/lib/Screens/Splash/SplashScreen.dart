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
  @override
  void initState() {
    super.initState();

    initializePrefs();
  }

  Future<void> initializePrefs() async {
    await sharedPrefInit();
    var userToken = sharedPrefGetToken();
    user = sharedPrefGetUser();
    Future.delayed(Duration(seconds: 2), () {
      userToken != null
          ? Routes.navigateToHomePage(context, user: user)
          : Routes.navigateToOnboardingScreen(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}
