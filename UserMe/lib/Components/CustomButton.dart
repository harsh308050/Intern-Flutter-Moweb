import '../Utils/utils.dart';
import 'CustomLoader.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onButtonPressed;
  final String buttonText;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? btnWidth;
  const CustomButton({
    super.key,
    required this.onButtonPressed,
    required this.buttonText,
    this.isLoading = false,
    this.backgroundColor,
    this.borderColor,
    this.btnWidth,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: ElevatedButton(
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? UIColours.primaryColor,
          minimumSize: Size(btnWidth ?? double.infinity, UISizes.btnHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UISizes.inputRadius),
          ),
        ),
        child: isLoading
            ? Transform.scale(
                scale: 0.7,
                child: CustomLoader(color: UIColours.white),
              )
            : Text(
                buttonText,
                style: TextStyle(
                  fontSize: UISizes.btnFontSize,
                  fontWeight: FontWeight.bold,
                  color: UIColours.white,
                ),
              ),
      ),
    );
  }
}
