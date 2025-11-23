import 'package:flutter/material.dart';
import '../Screens/AllUser/AllUsersDetailsScreen.dart';
import '../Screens/Home/homepage.dart';
import '../Screens/User/EditUserDetailsScreen.dart';
import '../Screens/User/UserDetailsScreen.dart';
import '../screens/auth/loginscreen.dart';
import '../screens/auth/signupscreen.dart';

class Routes {
  static popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  static navigateToSignupScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  static navigateToHomePage(BuildContext context, {required user}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }

  static navigateToUserDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailsScreen()),
    );
  }

  static navigateToEditUserDetailsScreen(
    BuildContext context, {
    required user,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserDetailsScreen(userid: user.id.toString()),
      ),
    );
  }

  static navigateToAllUsersDetailsScreen(
    BuildContext context, {
    required num id,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AllUsersDetailsScreen(id: id)),
    );
  }
}
