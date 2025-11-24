import 'Screens/User/model/user_res_model.dart';
import 'package:flutter/material.dart';

import 'Screens/Splash/SplashScreen.dart';
import 'Utils/SharedPrefHelper.dart';
import 'Utils/utils.dart';

UserResModel? user;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefInit();
  runApp(MyApp());
}

// final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      color: UIColours.white,
      theme: ThemeData(
        primaryColor: UIColours.primaryColor,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
    );
  }
}
