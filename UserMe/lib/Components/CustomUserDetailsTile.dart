import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/utils.dart';

Widget userInfoTile({
  required String title,
  required String value,
  required IconData icon,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: UISizes.mainSpacing),
    child: Row(
      spacing: UISizes.midSpacing,
      crossAxisAlignment: .center,
      children: [
        Icon(
          icon,
          color: UIColours.primaryColor,
          size: UISizes.titleFontSize * 1.2,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: UISizes.tileSubtitle,
                  color: UIColours.grey,
                ),
              ),
              Text(
                value,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: UISizes.tileTitle - 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
