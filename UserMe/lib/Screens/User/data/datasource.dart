import 'dart:developer';

import '../../../Http/http_helper.dart';
import '../../../Utils/APIConstant.dart';

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
}
