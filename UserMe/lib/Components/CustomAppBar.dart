import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class CustomAppBar extends StatefulWidget {
  final String appbarTitle;
  final Widget? suffixIcon;
  final bool? isCenter;
  const CustomAppBar({
    super.key,
    required this.appbarTitle,
    this.suffixIcon,
    this.isCenter,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: UIColours.white,
      child: AppBar(
        backgroundColor: UIColours.white,
        forceMaterialTransparency: true,
        actions: widget.suffixIcon != null ? [widget.suffixIcon!] : [],
        centerTitle: widget.isCenter ?? true,
        title: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            widget.appbarTitle,
            style: TextStyle(
              fontSize: UISizes.titleFontSize,
              color: UIColours.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
