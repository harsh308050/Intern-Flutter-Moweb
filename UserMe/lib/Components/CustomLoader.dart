import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;
  const CustomLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: color ?? UIColours.primaryColor),
    );
  }
}
