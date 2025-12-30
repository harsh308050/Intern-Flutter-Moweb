import 'package:UserMe/Components/CM.dart';
import 'package:UserMe/Screens/Home/homepage.dart';
import 'package:UserMe/Screens/Theme/Theme_colors.dart';
import '../../Utils/extensions.dart';
import '../../Utils/utils.dart';
import 'package:flutter/material.dart';
import '/main.dart';
import '/utils/SharedPrefHelper.dart';
import 'OnBoarding.dart';
import '../../Utils/updateUI.dart';
import '../../Utils/updateChecker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initial();
    });
  }

  Future<void> initial() async {
    final currentVersion = await checkAppVersion();
    final latestVersion = await getLatestAppVersion();
    if (isUpdateAvailable(currentVersion, latestVersion)) {
      final forceUpdate = isForceUpdate(currentVersion, latestVersion);
      await showUpdateDialog(context, isForce: forceUpdate);
      if (forceUpdate) return;
    }
    if (!mounted) return;
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
      backgroundColor: AppTheme.lightTheme.primaryColor,
      body: Center(
        child: Text(
          'UserMe',
          style: TextStyle(
            fontSize: UISizes.titleFontSize,
            fontWeight: FontWeight.bold,
            color: UIColours.white,
          ),
        ),
      ),
    );
  }
}
