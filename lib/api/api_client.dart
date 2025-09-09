import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mypaper/app/app_data.dart';
import 'package:mypaper/common/enum/http_method_types.dart';
import 'package:mypaper/other/msg.dart';

class ApiClient {
  final Map<String, String> _headers = {'Accept': 'application/json'};
  Future<Map<String, dynamic>> request({
    required String file,
    required HttpMethodTypes method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? parameter,
  }) async {
    late http.Response response;
    Uri uri = Uri.parse(
      AppData.baseUrl + file,
    ).replace(queryParameters: {if (parameter != null) ...parameter});
    logInfo('ApiClient/Request/URI', msg: "${method.name.toUpperCase()}: $uri");
    logInfo('ApiClient/Request/Header', msg: jsonEncode(_headers));
    if (payload != null) {
      logInfo('ApiClient/Request/Payload', msg: jsonEncode(payload));
    }
    try {
      switch (method) {
        case HttpMethodTypes.get:
          response = await http.get(uri, headers: _headers);
          break;
        case HttpMethodTypes.post:
          response = await http.post(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case HttpMethodTypes.put:
          response = await http.put(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case HttpMethodTypes.delete:
          response = await http.delete(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
        case HttpMethodTypes.patch:
          response = await http.patch(
            uri,
            headers: _headers,
            body: jsonEncode(payload),
          );
          break;
      }
      final jsonResponse = jsonDecode(response.body);
      // logSuccess('ApiClient/Request/Response', msg: response.body);
      // logSuccess('ApiClient/Request/StatusCode', msg: response.statusCode);
      if (response.statusCode == 200) {
        return jsonResponse;
      }
    } catch (ex) {
      toastMsg(ex.toString());
      logError('ApiClient/Request', msg: ex);
    }
    return {};
  }
}
