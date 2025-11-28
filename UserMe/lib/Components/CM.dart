import 'dart:io';

import 'package:UserMe/Utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/utils.dart';

showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w500, color: UIColours.white),
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UISizes.inputRadius),
      ),
    ),
  );
}

String? inputvalidator(String? value, String fieldName) {
  if (value.isNullOrEmpty) {
    return 'Please enter your $fieldName';
  }
  if (fieldName == "Email") {
    RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value!)) {
      return 'Enter a valid email address';
    }
  }
  if (fieldName == "Password") {
    if (value!.length < 3) {
      return 'Password must be at least 3 characters long';
    }
  }
  if (fieldName == "Age") {
    if (value!.length > 3) {
      return 'Please enter a valid age';
    }
  }
  return null;
}

Future<File?> pickImage(ImageSource source, ImagePicker picker) async {
  final pickedFile = await picker.pickImage(source: source);
  if (pickedFile != null) {
    File imageFile = File(pickedFile.path);
    return imageFile;
  } else {
    return null;
  }
}

Widget SbhMain() {
  return SizedBox(height: UISizes.mainSpacing);
}

Widget SbhSub() {
  return SizedBox(height: UISizes.subSpacing);
}

Widget SbhMin() {
  return SizedBox(height: UISizes.minSpacing);
}

void focusNodeRoute(FocusNode focusNode, BuildContext context) {
  FocusScope.of(context).requestFocus(focusNode);
}

void callNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

Future callNextScreenWithResult(BuildContext context, Widget nextScreen) async {
  var action = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );

  return action;
}

void callNextScreenAndClearStack(BuildContext context, Widget nextScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
    (Route<dynamic> route) => false,
  );
}
