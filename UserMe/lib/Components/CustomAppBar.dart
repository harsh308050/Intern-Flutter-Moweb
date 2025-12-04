import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class CustomAppBar extends StatefulWidget {
  final String appbarTitle;
  final Widget? suffixIcon;
  final bool? isCenter;
  final bool? isPassingData;
  const CustomAppBar({
    super.key,
    required this.appbarTitle,
    this.suffixIcon,
    this.isPassingData,
    this.isCenter,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: false,
      leading: widget.isPassingData == true
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: UIColours.black),
              onPressed: () {
                Navigator.pop(context, true);
              },
            )
          : null,
      actions: widget.suffixIcon != null ? [widget.suffixIcon!] : [],
      centerTitle: widget.isCenter ?? true,
      title: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          widget.appbarTitle,
          style: TextStyle(
            fontSize: UISizes.titleFontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
