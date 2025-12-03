import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final VoidCallback? onSuffixPressed;
  final IconData? suffixIcon;
  final num? maxLength;
  final bool enabled;
  final bool obscureText;
  final String? Function(String?)? validator;
  const CustomTextfield({
    super.key,
    required this.focusNode,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.keyboardType,
    this.maxLength,
    this.onSuffixPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: UISizes.labelFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: UISizes.minSpacing),
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: UIColours.primaryColor,
          obscureText: obscureText,
          validator: validator,
          maxLength: maxLength != null ? maxLength?.toInt() : null,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.symmetric(
              vertical: UISizes.verticalInputPadding,
              horizontal: UISizes.horizontalInputPadding,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(UISizes.inputRadius),
              ),
              borderSide: BorderSide(color: UIColours.primaryColor, width: 2),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: UISizes.inputFontSize),
            prefixIcon: prefixIcon,
            suffixIcon: IconButton(
              onPressed: onSuffixPressed,
              icon: Icon(suffixIcon),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(UISizes.inputRadius),
              ),
              borderSide: BorderSide(color: UIColours.errorColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UISizes.inputRadius),
              borderSide: BorderSide(color: UIColours.errorColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: UIColours.grey.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(UISizes.inputRadius),
            ),
          ),

          enabled: enabled,
          autovalidateMode: .onUserInteraction,
        ),
      ],
    );
  }
}
