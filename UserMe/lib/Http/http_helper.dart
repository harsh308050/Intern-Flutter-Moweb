import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../utils/APIConstant.dart';
import '../utils/SharedPrefHelper.dart';
import '../Screens/User/data/datasource.dart';

Future<dynamic> postMethod({
  required String endpoint,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(APIConstant.baseUrl + endpoint);
    final requestHeaders = await getSessionData();

    log("--------- URL ---------- $url");
    log("---------- Request ----------${jsonEncode(body)}");

    final response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(body),
    );

    log("---------- Response ----------${response.body}");
    return response;
  } catch (e) {
    log("POST ERROR $e");
  }
}

Map<String, String> getSessionData() {
  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "",
  };
}

Future<dynamic> getMethod({
  required String endpoint,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(APIConstant.baseUrl + endpoint);

    final requestHeaders = {
      ...getSessionData(),
      ...?headers,
      "Authorization": "Bearer ${sharedPrefGetToken()}",
    };

    log("--------- URL (GET) ---------- $url");
    log("--------- Headers ---------- $requestHeaders");

    final response = await http.get(url, headers: requestHeaders);

    if (response.statusCode == 401) {
      log('=============Token expired');
      final newToken = await DataSource().getRefreshToken();

      if (newToken != null) {
        log('=============Retrying');
        final retryResponse = await getMethod(
          endpoint: endpoint,
          headers: requestHeaders
            ..update("Authorization", (_) => "Bearer $newToken"),
        );
        return retryResponse;
      } else {
        log('=============Failed');
        return response;
      }
    }

    log("----------- GET Response ----------- ${response.body}");
    return response;
  } catch (e) {
    log("GET ERROR $e");
  }
}

Future<dynamic> deleteMethod(
  String endpoints, {
  Map<String, dynamic>? queryParams,
}) async {
  try {
    final uri = Uri.parse(APIConstant.baseUrl + endpoints);

    log("----------URL------------   ${uri.toString()}");
    log("----------REQUEST------------   $queryParams");

    final response = await http.delete(
      uri,
      body: jsonEncode(queryParams),
      headers: getSessionData(),
    );

    log("----------RESPONSE------------   ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('Error with Api and the status code is ${response.statusCode}');
    }
  } catch (e) {
    log('DELETE Error: $e');
  }
}

Future<dynamic> patchMethod({
  required String endpoint,
  Object? body,
  Map<String, String>? headers,
}) async {
  try {
    final url = Uri.parse(APIConstant.baseUrl + endpoint);

    log("--------- URL (PATCH) ---------- $url");
    log("--------- Request ---------- ${jsonEncode(body)}");
    final response = await http.patch(
      url,
      headers: getSessionData(),
      body: jsonEncode(body),
    );

    log("--------- PATCH Response ---------- ${response.body}");
    return response;
  } catch (e) {
    log("PATCH ERROR $e");
  }
}
