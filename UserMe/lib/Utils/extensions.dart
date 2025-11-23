import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension OnTapExtension on Widget {
  Widget onTap(GestureTapCallback function) {
    return GestureDetector(onTap: function, child: this);
  }
}

// extension DateFormating on DateTime {
//   ///03 Aug 2025
//   String toFormattedDate() {
//     return DateFormat('dd MMM yyyy').format(this);
//   }

//   ///August 03 2025
//   String toLongFormattedDate() {
//     return DateFormat('MMMM dd yyyy').format(this);
//   }
// }

extension DateFormating on String {
  ///03 Aug 2025
  String toFormattedDate() {
    DateTime parsedDate = DateTime.parse(this);
    return DateFormat('dd MMM yyyy').format(parsedDate);
  }

  ///August 03 2025
  String toLongFormattedDate() {
    DateTime parsedDate = DateTime.parse(this);
    return DateFormat('MMMM dd yyyy').format(parsedDate);
  }
}
