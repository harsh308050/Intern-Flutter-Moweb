import 'package:flutter/material.dart';
import '../../Components/CustomBottomAppBar.dart';
import '../AllUser/AllUserScreen.dart';
import '../User/SettingsScreen.dart';

class Homepage extends StatefulWidget {
  final bool? isFromNotificationTap;
  Homepage({super.key, this.isFromNotificationTap});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  late List<Widget> screen;
  @override
  void initState() {
    super.initState();

    screen = [
      UserScreen(isFromNotificationTap: widget.isFromNotificationTap),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screen[_currentIndex]),
      bottomNavigationBar: CustomBottomAppBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
