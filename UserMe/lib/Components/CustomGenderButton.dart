import 'package:UserMe/Utils/extensions.dart';

import '../Utils/utils.dart';
import 'package:flutter/material.dart';

class Genderbutton extends StatefulWidget {
  final VoidCallback onGenderChanged;
  final String? label;
  final bool? isMale;
  Genderbutton({
    super.key,
    required this.onGenderChanged,
    this.label,
    this.isMale,
  });

  @override
  State<Genderbutton> createState() => _GenderbuttonState();
}

class _GenderbuttonState extends State<Genderbutton> {
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: width * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: widget.isMale!
            ? UIColours.white
            : UIColours.white.withOpacity(0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.label ?? (widget.isMale! ? "Male" : "Female"),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: widget.isMale! ? UIColours.black : UIColours.greyShade,
            ),
          ),
        ],
      ),
    ).onTap(widget.onGenderChanged);
  }
}
