import 'dart:developer';
import 'package:UserMe/Utils/extensions.dart';

import '../../../Http/http_helper.dart';
import '../../../Utils/APIConstant.dart';

class DataSource {
  Future<dynamic> getAllUsers({
    String? query,
    String? order,
    bool? isTyping,
    int? skip,
  }) async {
    final buffer = StringBuffer("${APIConstant.allusers}");
    if (query.isNotNullOrEmpty || isTyping == true) {
      buffer.write("${APIConstant.searchQuery}$query");
    }
    if (order.isNotNullOrEmpty) {
      buffer.write("${APIConstant.sorting}$order");
    }
    if (skip != null) {
      buffer.write("${APIConstant.limit}&${APIConstant.skip}$skip");
    }
    final response = await getMethod(endpoint: buffer.toString());
    log('response: $response');
    return response;
  }

  Future<dynamic> getAllUsersDetailsData(num id) async {
    final response = await getMethod(endpoint: "${APIConstant.allusers}/$id");
    log('response: $response');
    return response;
  }
}
