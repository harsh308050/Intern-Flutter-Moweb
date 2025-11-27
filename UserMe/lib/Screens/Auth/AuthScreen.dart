import 'package:UserMe/Screens/Auth/loginscreen.dart';
import 'package:UserMe/Screens/Auth/signupscreen.dart';
import 'package:UserMe/Utils/utils.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  static List<Tab> tabs = <Tab>[Tab(text: 'Login'), Tab(text: 'Signup')];
  final List<Widget> tabScreens = [const LoginScreen(), SignupScreen()];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColours.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: UISizes.aroundPadding),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: tabs,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: UIColours.primaryColor,
                labelColor: UIColours.primaryColor,
                unselectedLabelColor: UIColours.grey,
                labelStyle: TextStyle(
                  fontSize: UISizes.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: UISizes.aroundPadding),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: tabScreens,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
