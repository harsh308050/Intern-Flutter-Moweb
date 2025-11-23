import 'dart:convert';
import 'package:http/http.dart';

import '../../../Http/apires.dart';
import '../model/user_model.dart';
import 'datasource.dart';

class Repository {
  final DataSource dataSource;
  Repository(this.dataSource);

  Future<ApiResult<UserModel>> loginUser({
    required String username,
    required String password,
  }) async {
    try {
      Response result = await dataSource.loginUser(
        username: username,
        password: password,
      );
      if (result.statusCode == 200 || result.statusCode == 201) {
        final data = UserModel.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else {
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      return ApiResult.failure(error: "Something went wrong");
    }
  }
}
