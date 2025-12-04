import 'dart:developer';

import '../../../Http/http_helper.dart';
import '../../../Utils/APIConstant.dart';

class DataSource {
  final String baseUrl = APIConstant.baseUrl;

  Future<dynamic> loginUser({
    required String username,
    required String password,
  }) async {
    Map<String, dynamic> params = {
      "username": username,
      "password": password,
      'expiresInMins': 30,
    };
    final response = await postMethod(
      endpoint: APIConstant.login,
      body: params,
    );
    log('Login response: $response');
    return response;
  }

  Future<dynamic> getUserDetails() async {
    final response = await getMethod(endpoint: APIConstant.user);
    log('Login response: $response');
    return response;
  }
}
