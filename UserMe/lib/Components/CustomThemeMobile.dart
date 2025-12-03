import 'package:flutter/material.dart';
import '../Utils/utils.dart';

class CustomThemeMobile extends StatelessWidget {
  final String themeName;
  final Color inColour;
  final Color borderColor;
  final Color selectedColour;
  const CustomThemeMobile({
    super.key,
    required this.themeName,
    required this.inColour,
    required this.borderColor,
    required this.selectedColour,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: UISizes.subSpacing,
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: selectedColour, width: 5),
              left: BorderSide(color: selectedColour, width: 5),
              right: BorderSide(color: selectedColour, width: 5),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(UISizes.inputRadius * 2 + 5),
              topRight: Radius.circular(UISizes.inputRadius * 2 + 5),
            ),
          ),
          // child: Stack(
          //   children: [
          child: Container(
            height: 60,
            width: 70,
            decoration: BoxDecoration(
              color: inColour,
              border: Border(
                top: BorderSide(color: borderColor, width: 5),
                left: BorderSide(color: borderColor, width: 5),
                right: BorderSide(color: borderColor, width: 5),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(UISizes.inputRadius * 2),
                topRight: Radius.circular(UISizes.inputRadius * 2),
              ),
            ),
          ),
          //     Positioned(
          //       top: 10,
          //       left: 24,
          //       // left: 0,
          //       right: 24,
          //       child: Container(
          //         alignment: Alignment.center,
          //         height: 6,
          //         decoration: BoxDecoration(
          //           color: borderColor,
          //           borderRadius: BorderRadius.all(
          //             Radius.circular(UISizes.inputRadius * 2),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
        Text(
          themeName,
          style: TextStyle(
            fontSize: UISizes.inputFontSize,
            fontWeight: FontWeight.w500,
            color: selectedColour == UIColours.transparent
                ? UIColours.grey
                : UIColours.primaryColor,
          ),
        ),
      ],
    );
  }
}
