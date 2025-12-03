import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onTextButtonPressed;
  final String buttonText;
  final Color? buttonColor;
  const CustomTextButton({
    super.key,
    this.onTextButtonPressed,
    this.buttonColor,

    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTextButtonPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: UISizes.inputFontSize,
          color: buttonColor ?? UIColours.primaryColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
