import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/utils.dart';

class CM {
  static showSnackBar(BuildContext context, String message, Color color) {
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

  static String? inputvalidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    if (fieldName == "Email") {
      RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!regex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
    }
    if (fieldName == "Password") {
      if (value.length < 3) {
        return 'Password must be at least 3 characters long';
      }
    }
    if (fieldName == "Age") {
      if (value.length > 3) {
        return 'Please enter a valid age';
      }
    }
    return null;
  }

  static Future<File?> pickImage(ImageSource source, ImagePicker picker) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
    } else {
      return null;
    }
  }

  static Widget SbhMain() {
    return SizedBox(height: UISizes.mainSpacing);
  }

  static Widget SbhSub() {
    return SizedBox(height: UISizes.subSpacing);
  }

  static Widget SbhMin() {
    return SizedBox(height: UISizes.minSpacing);
  }
}

void focusNodeRoute(FocusNode focusNode, BuildContext context) {
  FocusScope.of(context).requestFocus(focusNode);
}
