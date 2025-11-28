import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens/User/model/user_res_model.dart';
import '../main.dart';
import 'utils.dart';

SharedPreferences? prefs;

Future<void> sharedPrefInit() async {
  prefs = await SharedPreferences.getInstance();
}

Future<bool> sharedPrefsaveData(String key, dynamic value) async {
  if (prefs == null) await sharedPrefInit();
  if (value is String) {
    return prefs!.setString(key, value);
  } else if (value is int) {
    return prefs!.setInt(key, value);
  } else if (value is bool) {
    return prefs!.setBool(key, value);
  } else if (value is double) {
    return prefs!.setDouble(key, value);
  } else if (value is List<String>) {
    return prefs!.setStringList(key, value);
  }
  return false;
}

dynamic sharedPrefGetData(String key) {
  if (prefs == null) return null;
  return prefs!.get(key);
}

Future<bool> sharedPrefRemoveData(String key) async {
  if (prefs == null) await sharedPrefInit();
  return prefs!.remove(key);
}

Future<bool> sharedPrefClearAllData() async {
  if (prefs == null) await sharedPrefInit();
  user = null;
  return prefs!.clear();
}

sharedPrefGetUser() {
  final rawUser = sharedPrefGetData(sharedPrefKeys.userDataKey);
  if (rawUser != null && rawUser is String) {
    return UserResModel.fromJson(jsonDecode(rawUser));
  }
  return user;
}

sharedPrefGetToken() {
  final token = sharedPrefGetData(sharedPrefKeys.accessTokenKey);
  if (token != null && token is String) {
    return token;
  }
}
