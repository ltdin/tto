import 'package:news/base/app_helpers.dart';
import 'package:news/models/response_model.dart';

class ResultDataModel {
  dynamic result;
  ErrorModel error;
  StatusResponse status = StatusResponse.SUCCESS;
}

enum StatusResponse { SUCCESS, FAILURE }

class ErrorModel {
  String code = '';
  String message = '';
}

class BaseModel {
  ///Map current map
  Map<String, dynamic> map = new Map<String, dynamic>();

  ///status request success/failure/timeout
  StatusRequest statusRequest;

  ///message success/ failure/ timeout
  String message = '';

  ///parse string value
  static String parseString(String forKey, Map<String, dynamic> json) {
    var result = '';
    result = json[forKey].toString() ?? '';
    if (result.toLowerCase().contains('null')) {
      return '';
    }
    return result;
  }

  ///parse bool value
  static bool parseBool(String forKey, Map<String, dynamic> json) {
    var result = false;
    result = json[forKey] ?? false;
    return result;
  }

  ///parse list value
  static List parseList(String forKey, Map<String, dynamic> json) {
    if (json.containsKey(forKey)) {
      final list = json[forKey] as List;
      return list;
    }

    return [];
  }

  ///parse int value
  static int parseInt(String forKey, Map<String, dynamic> json) {
    int result = 0;
    result = json[forKey] ?? 0;
    return result;
  }

  ///parse double value
  static double parseDouble(String forKey, Map<String, dynamic> json) {
    double result = 0.0;
    result = json[forKey] ?? 0.0;
    return result;
  }

  ///parse map value
  static Map<String, dynamic> parseMap(
      String forKey, Map<String, dynamic> json) {
    Map<String, dynamic> result = Map<String, dynamic>();
    // if (json.containsKey(forKey)) {
    result = Map<String, dynamic>.from(json[forKey] ?? Map<String, dynamic>());
    // }

    return result;
  }

  ///parse array map value
  static List<Map<String, dynamic>> parseArrayMap(
      String forKey, Map<String, dynamic> json) {
    List<Map<String, dynamic>> result = [];
    result = json[forKey] ?? [];
    return result;
  }

  ///format string or number value
  int formatNumberOrString(String str) {
    final output = int.tryParse(str) ?? 0;
    // final output = str;
    return output;
  }

  ///format string or double value
  double formatDoubleOrString(String str) {
    final output = double.tryParse(str) ?? 0;
    // final output = str;
    return output;
  }

  ///log my map
  printMe() {
    printDebug('Object PrintMe ===> ${this.map}');
  }
}
