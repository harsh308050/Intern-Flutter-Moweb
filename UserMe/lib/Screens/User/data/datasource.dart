import 'dart:convert';
import 'dart:developer';

import '../../../Http/http_helper.dart';
import '../../../Utils/APIConstant.dart';
import '../../../Utils/SharedPrefHelper.dart';
import '../../../Utils/utils.dart';

class DataSource {
  final String baseUrl = APIConstant.baseUrl;

  Future<dynamic> getUserDetails() async {
    final response = await getMethod(endpoint: APIConstant.user);
    log('Login response: $response');
    return response;
  }

  Future<dynamic> editUserDetails(
    String id,
    Map<String, dynamic> params,
  ) async {
    final response = await patchMethod(
      endpoint: "${APIConstant.allusers}/$id",
      body: params,
    );
    log('Edit Profile response: $response');
    return response;
  }

  Future<dynamic> addUserDetails(Map<String, dynamic> params) async {
    final response = await postMethod(
      endpoint: APIConstant.signup,
      body: params,
    );
    log('Add User response: $response');
    return response;
  }

  Future<String?> getRefreshToken() async {
    final oldRefreshToken = sharedPrefGetData(sharedPrefKeys.refreshTokenKey);

    Map<String, dynamic> params = {
      "refreshToken": oldRefreshToken,
      'expiresInMins': 30,
    };

    final response = await postMethod(
      endpoint: APIConstant.refreshToken,
      body: params,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      await sharedPrefsaveData(sharedPrefKeys.accessTokenKey, newAccessToken);

      await sharedPrefsaveData(sharedPrefKeys.refreshTokenKey, newRefreshToken);

      return newAccessToken;
    } else {
      return null;
    }
  }
}
