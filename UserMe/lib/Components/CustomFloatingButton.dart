import 'package:UserMe/Utils/utils.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final String? heroTag;
  final Color? color;
  final Icon? icon;
  final ShapeBorder? shape;
  final VoidCallback? onTap;
  const CustomFloatingButton({
    super.key,
    this.color,
    this.heroTag,
    this.shape,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onTap,
      shape:
          shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: color ?? UIColours.primaryColor,
      child: icon,
    );
  }
}
