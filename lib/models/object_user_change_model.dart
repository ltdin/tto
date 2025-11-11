import 'package:news/base/app_helpers.dart';

class UserChangeModel {
  UserChangeModel({this.name = "", this.avatar = ""});
  String name;
  String avatar;

  factory UserChangeModel.fromJson(Map<String, dynamic> jsonModel) {
    return UserChangeModel(
      name: lookup<String>(jsonModel, ['name']) ?? '',
      avatar: lookup<String>(jsonModel, ['avatar']) ?? '',
    );
  }

  Map<String, String> get mapping {
    Map<String, String> bodyData = Map<String, String>();
    bodyData["name"] = AppHelpers.safeString(name).length != 0
        ? AppHelpers.safeString(name)
        : "";
    bodyData["avatar"] = AppHelpers.safeString(avatar).length != 0
        ? AppHelpers.safeString(avatar)
        : "";
    return bodyData;
  }
}
