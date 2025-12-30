import 'dart:developer';
import 'package:UserMe/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> remoteConfigSetup() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: Duration.zero,
      minimumFetchInterval: Duration.zero,
    ),
  );
  await remoteConfig.setDefaults(const {
    "primary_color": "0xFF4a90e2",
    "app_version": "1.0.0",
  });
  await remoteConfig.fetchAndActivate();
  log(
    "=================Primary Color: ${remoteConfig.getString('primary_color')}",
  );
  UIColours.primaryColor = Color(
    int.parse(remoteConfig.getString("primary_color")),
  );
  log("=================App Version: ${remoteConfig.getString('app_version')}");
  remoteConfig.onConfigUpdated.listen((event) async {
    await remoteConfig.activate();
  });
}
