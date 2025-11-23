import 'dart:developer';
import '../../../Http/http_helper.dart';
import '../../../Utils/APIConstant.dart';

class DataSource {
  final String baseUrl = APIConstant.baseUrl;

  Future<dynamic> getAllUsers() async {
    final response = await getMethod(endpoint: APIConstant.allusers);
    log('Login response: $response');
    return response;
  }

  Future<dynamic> getAllUsersDetailsData(num id) async {
    final response = await getMethod(endpoint: "${APIConstant.allusers}/$id");
    log('Login response: $response');
    return response;
  }
}
