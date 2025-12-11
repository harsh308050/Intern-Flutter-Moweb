import 'package:UserMe/Components/CustomButton.dart';
import 'package:UserMe/Screens/Auth/AuthScreen.dart';
import 'package:UserMe/Utils/utils.dart';
import 'package:flutter/material.dart';

import '../../Components/CM.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController pageController;
  int currentIndex = 0;
  List<Widget> get onboarding => [
    buildPage(
      image: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      title: 'Welcome to UserMe',
    ),
    buildPage(
      image: 'https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d',
      title: 'Connect with Harsh',
    ),
    buildPage(
      image:
          'https://img.freepik.com/free-photo/businesspeople-meeting-doing-greeting-handshake-gesture-office-workspace_482257-101727.jpg',
      title: 'Discover New People',
    ),
  ];

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: pageController,
              onPageChanged: handlePageViewChanged,
              children: onboarding,
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      opacity: currentIndex == 0 ? 0 : 1,
                      duration: Duration(milliseconds: 300),
                      child: CustomButton(
                        btnWidth: 100,
                        onButtonPressed: () {
                          setState(() {
                            if (currentIndex > 0) {
                              updateCurrentPageIndex(currentIndex - 1);
                            }
                          });
                        },
                        buttonText: "Back",
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: currentIndex == onboarding.length - 1 ? 0 : 1,
                      duration: Duration(milliseconds: 300),
                      child: CustomButton(
                        btnWidth: 100,
                        onButtonPressed: () {
                          if (currentIndex < onboarding.length - 1) {
                            updateCurrentPageIndex(currentIndex + 1);
                          }
                        },

                        buttonText: "Next",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  callNextScreenAndClearStack(context, AuthScreen());
                },
                child: Text(
                  "Skip",
                  style: TextStyle(fontSize: 16, color: UIColours.primaryColor),
                ),
              ),
            ),
            Positioned(
              bottom: 140,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboarding.length, (index) {
                  return AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: currentIndex == index ? 18 : 8,
                    width: currentIndex == index ? 18 : 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? UIColours.primaryColor
                          : UIColours.black,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPage({required String image, required String title}) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: UIColours.primaryColor.withValues(alpha: 0.15),
      child: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.6,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: height / 2,
              left: 0,
              right: 0,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: UIColours.black,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handlePageViewChanged(int currentPageIndex) {
    setState(() {
      currentIndex = currentPageIndex;
    });
  }

  void updateCurrentPageIndex(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
