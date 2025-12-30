import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> checkAppVersion() async {
  final info = await PackageInfo.fromPlatform();
  return info.version;
}

Future<String> getLatestAppVersion() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  return remoteConfig.getString("app_version");
}

bool isUpdateAvailable(String current, String remote) {
  List<int> currentParts = current.split('.').map(int.parse).toList();
  List<int> remoteParts = remote.split('.').map(int.parse).toList();

  for (int i = 0; i < remoteParts.length; i++) {
    if (currentParts[i] < remoteParts[i]) return true;
    if (currentParts[i] > remoteParts[i]) return false;
  }
  return false;
}

bool isForceUpdate(String current, String remote) {
  final currentMajor = int.parse(current.split('.')[0]);
  final remoteMajor = int.parse(remote.split('.')[0]);

  return remoteMajor > currentMajor;
}
