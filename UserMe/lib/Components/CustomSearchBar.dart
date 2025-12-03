import 'package:flutter/material.dart';
import '../Utils/utils.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final FocusNode? focusNode;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.controller,
    required this.onChanged,
    this.onClear,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller ?? TextEditingController(),
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          cursorColor: UIColours.primaryColor,
          decoration: InputDecoration(
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: onClear,
                    icon: Icon(Icons.clear, color: UIColours.grey, size: 18),
                  )
                : null,

            hintText: hintText,
            focusColor: UIColours.primaryColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UISizes.inputRadius),
              borderSide: BorderSide(
                color: UIColours.grey.withValues(alpha: 0.5),
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
              borderSide: BorderSide(
                color: UIColours.grey.withValues(alpha: 0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
