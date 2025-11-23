import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/utils.dart';
import 'CM.dart';
import 'CustomTile.dart';

void showImageSourceSheet(
  BuildContext context,
  ImagePicker picker,
  Function setState,
  // Function(File) setImage,
  File image,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(UISizes.aroundPadding),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTile(
                leadingIcon: Icon(Icons.photo_library),
                title: "Choose From Gallery",
                onTap: () {
                  Navigator.pop(context);
                  CM.pickImage(ImageSource.gallery, picker).then((file) async {
                    if (file != null) {
                      setState(() {
                        image = file;
                      });
                    }
                  });
                },
              ),
              CustomTile(
                leadingIcon: Icon(Icons.camera_alt),
                title: "Take a Photo",
                onTap: () {
                  Navigator.pop(context);
                  CM.pickImage(ImageSource.camera, picker).then((file) async {
                    if (file != null) {
                      setState(() {
                        image = file;
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
