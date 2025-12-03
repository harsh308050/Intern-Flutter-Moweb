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

  List<Widget> get tabScreens => [
    LoginScreen(onSwitchTab: () => _tabController.animateTo(1)),
    SignupScreen(onSwitchTab: () => _tabController.animateTo(0)),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: UISizes.aroundPadding),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: tabs,
                dividerColor: UIColours.transparent,
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
