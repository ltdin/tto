import 'package:news/base/app_helpers.dart';

class ResponseModel {
  final dynamic data;
  final String message;
  final int statusCode;
  final StatusRequest status;

  const ResponseModel({
    this.statusCode = 200,
    this.status = StatusRequest.FAILURE,
    this.message,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData == null || (jsonData?.isEmpty ?? false)) {
      return null;
    }

    return ResponseModel(
      data: lookup<dynamic>(jsonData, ['data']),
      message: lookup<String>(jsonData, ['message']),
      statusCode: lookup<int>(jsonData, ['code']),
      status: lookup<String>(jsonData, ['data', 'status']) == "false"
          ? StatusRequest.FAILURE
          : StatusRequest.SUCCESS,
    );
  }
}

enum StatusRequest { SUCCESS, FAILURE, TIMEOUT }
