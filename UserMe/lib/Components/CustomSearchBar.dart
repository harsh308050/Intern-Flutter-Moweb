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
      decoration: InputDecoration(
        fillColor: UIColours.white,
        filled: true,
        hintText: hintText,
        prefixIcon: Icon(Icons.search, color: UIColours.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UISizes.inputRadius),
          borderSide: BorderSide(color: UIColours.greyShade.withOpacity(0.5)),
        ),
      ),
    );
  }
}
