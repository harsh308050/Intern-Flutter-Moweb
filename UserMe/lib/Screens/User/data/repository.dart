import 'dart:convert';
import 'dart:developer';
import 'package:UserMe/Utils/SharedPrefHelper.dart';
import 'package:UserMe/Utils/utils.dart';
import 'package:UserMe/utils/APIConstant.dart';
import 'package:http/http.dart';

import '../../../Components/CM.dart';
import '../../../Http/apires.dart';
import '../../../main.dart';
import '../model/user_res_model.dart';
import 'datasource.dart';

class Repository {
  final DataSource dataSource;
  Repository(this.dataSource);

  Future<ApiResult<UserResModel>> getUserDetails() async {
    try {
      Response result = await dataSource.getUserDetails();
      if (result.statusCode == 200 || result.statusCode == 201) {
        final data = UserResModel.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else {
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      return ApiResult.failure(error: "Something went wrong");
    }
  }

  Future<ApiResult<UserResModel>> editUserDetails({
    required String id,
    required Map<String, dynamic> params,
  }) async {
    try {
      Response result = await dataSource.editUserDetails(id, params);
      if (result.statusCode == 200 || result.statusCode == 201) {
        final data = UserResModel.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else {
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      log("Something went wrong ${e.toString()}");
      return ApiResult.failure(error: "Something went wrong ${e.toString()}");
    }
  }

  Future<ApiResult<UserResModel>> addUserDetails({
    required Map<String, dynamic> params,
  }) async {
    try {
      Response result = await dataSource.addUserDetails(params);
      if (result.statusCode == 200 || result.statusCode == 201) {
        final data = UserResModel.fromJson(jsonDecode(result.body));
        return ApiResult.success(data: data);
      } else {
        return ApiResult.failure(error: jsonDecode(result.body)['message']);
      }
    } catch (e) {
      log("Something went wrong ${e.toString()}");
      return ApiResult.failure(error: "Something went wrong ${e.toString()}");
    }
  }
}
