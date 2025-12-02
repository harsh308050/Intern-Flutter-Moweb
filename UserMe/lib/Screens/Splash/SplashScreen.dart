import 'package:UserMe/Components/CM.dart';
import 'package:UserMe/Screens/Home/homepage.dart';
import '../../Utils/extensions.dart';
import '../../Utils/utils.dart';
import 'package:flutter/material.dart';
import '/main.dart';
import '/utils/SharedPrefHelper.dart';
import 'OnBoarding.dart';

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
    String? userToken = sharedPrefGetToken();
    user = sharedPrefGetUser();
    Future.delayed(Duration(seconds: 2), () {
      userToken.isNotNullOrEmpty
          ? callNextScreenAndClearStack(context, Homepage())
          : callNextScreenAndClearStack(context, OnBoarding());
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
