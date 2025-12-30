import 'dart:io';
import 'package:UserMe/Components/CustomButton.dart';
import 'package:UserMe/Components/CustomTextButton.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key, required this.isForce});
  final bool isForce;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isForce ? false : true,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'New Update!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  'A new update is available!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    CustomButton(
                      onButtonPressed: () {
                        final appStoreUrl =
                            'https://play.google.com/store/search?q=logitx&c=apps&hl=en';
                        launchUrl(Uri.parse(appStoreUrl));
                      },
                      buttonText: 'Update Now',
                    ),

                    !isForce
                        ? CustomTextButton(
                            onTextButtonPressed: () {
                              Navigator.of(context).pop();
                              return;
                              // exit(0);
                            },
                            buttonText: 'Later',
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showUpdateDialog(
  BuildContext context, {
  required bool isForce,
}) async {
  return showModalBottomSheet(
    context: context,
    isDismissible: isForce ? false : true,
    enableDrag: isForce ? false : true,
    builder: (_) {
      return UpdateDialog(isForce: isForce);
    },
  );
}
