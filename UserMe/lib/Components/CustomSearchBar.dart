import 'package:flutter/material.dart';
import '../Utils/utils.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  const CustomSearchBar({super.key, required this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: UIColours.primaryColor,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            controller?.text = "";
          },
          icon: Icon(Icons.clear, color: UIColours.grey, size: 18),
        ),
        fillColor: UIColours.white,
        filled: true,
        hintText: hintText,
        focusColor: UIColours.primaryColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UISizes.inputRadius),
          borderSide: BorderSide(
            color: UIColours.greyShade.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UISizes.inputRadius),
          borderSide: BorderSide(color: UIColours.primaryColor, width: 2),
        ),
        prefixIcon: Icon(Icons.search, color: UIColours.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UISizes.inputRadius),
          borderSide: BorderSide(color: UIColours.greyShade.withOpacity(0.5)),
        ),
      ),
    );
  }
}
