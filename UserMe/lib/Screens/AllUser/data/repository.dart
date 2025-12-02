import 'dart:convert';
import 'dart:developer';
import '../../../Http/apires.dart';
import '../model/allUser_model.dart';
import 'package:http/http.dart';

import 'datasource.dart';

class Repository {
  final DataSource dataSource;
  Repository(this.dataSource);

  Future<ApiResult<AllUsersModel>> getAllUsers(
    String? query,
    String? order,
    bool? isTyping,
    int? skip,
  ) async {
    try {
      Response result = await dataSource.getAllUsers(
        query: query,
        order: order,
        isTyping: isTyping,
        skip: skip,
      );
      if (result.statusCode == 200 || result.statusCode == 201) {
        final data = AllUsersModel.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else {
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      log("Something went wrong============ ${e.toString()}");
      return ApiResult.failure(error: "Something went wrong");
    }
  }

  Future<ApiResult<AllUsersModel>> getAllUsersDetailsData(num id) async {
    try {
      Response result = await dataSource.getAllUsersDetailsData(id);
      if (result.statusCode == 200 || result.statusCode == 201) {
        final data = AllUsersModel(
          users: [Users.fromJson(jsonDecode(result.body))],
        );
        return ApiResult.success(data: data);
      } else {
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      log("Something went wrong============ ${e.toString()}");
      return ApiResult.failure(error: "Something went wrong");
    }
  }
}
