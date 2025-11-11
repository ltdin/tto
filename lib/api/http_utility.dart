import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/models/request_model.dart';
import 'package:news/models/sso_response_model.dart';

class Service {
  Client _client = Client();

  Future<dynamic> getRequest(RequestModel request,
      {bool isSsoApi = false}) async {
    // Add headers
    request.headers
        .addEntries({'user_agent': Platform.isIOS ? 'ios' : 'android'}.entries);

    try {
      final response = await _client
          .get(
            Uri.tryParse(request.urlApi),
            headers: request.headers,
          )
          .timeout(REQUEST_TIME_OUT);

      // Print api url
      printDebug('Response for: GET : ${request.urlApi}');

      // Is show body
      if (globals.IS_SHOW_DEBUG_RESPONSE) {
        printDebug('BODY : ${json.decode(response.body)}');
      }

      // Check sso api
      if (isSsoApi) {
        final jsonResponse = json.decode(response.body);
        return SsoResponseModel.fromJson(jsonResponse);
      } else {
        return (response.statusCode == 200)
            ? json.decode(response.body)
            : throw Exception('Failed to Load');
      }
    } on TimeoutException catch (_) {
      printDebug("Error : TimeoutException");
    } catch (error) {
      printDebug("Error : $error");
    }

    return null;
  }

  Future<dynamic> postRequest(RequestModel request,
      {bool isSsoApi = false}) async {
    // Add headers
    request.headers.addEntries(
      {'user_agent': Platform.isIOS ? 'ios' : 'android'}.entries,
    );

    try {
      final response = await _client
          .post(
            Uri.tryParse(request.urlApi),
            headers: request.headers,
            body: request.params,
          )
          .timeout(REQUEST_TIME_OUT);

      // Print api url
      printDebug('------------------------------------------------------\n'
          'Response for: POST ${request.urlApi}\n');

      // Is show body
      if (globals.IS_SHOW_DEBUG_RESPONSE) {
        printDebug('BODY : ${json.decode(response.body)}\n');
      }

      // Check sso api
      if (isSsoApi) {
        return SsoResponseModel.fromJson(json.decode(response.body));
      } else {
        return (response.statusCode == 200) ? json.decode(response.body) : null;
      }
    } on TimeoutException catch (_) {
      printDebug("Error : TimeoutException");
    } catch (error) {
      printDebug("Error : $error");
    }

    return null;
  }
}
