import 'package:news/api/apis.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/object_user_change_model.dart';

class UserModel {
  const UserModel({
    this.id = "",
    this.email,
    this.googleId,
    this.facebookId,
    this.name,
    this.avatar,
    this.status,
    this.phone,
    this.createdDate,
    this.objectUserChange,
    this.pass,
    this.gender,
    this.birthTimestamp,
    this.avatarPath,
    this.avatarBaseUrl,
    this.address,
    this.website,
    this.typeAccount,
    this.companyName,
    this.companyCertificate,
    this.created,
    this.star,
    this.expire,
    this.starBonus,
    this.expireBonus,
    this.enableFree,
  });

  final String id;
  final String email;
  final String googleId;
  final String facebookId;
  final String name;
  final String avatar;
  final int status;
  final String phone;
  final String pass;
  final String createdDate;
  final UserChangeModel objectUserChange;
  final dynamic gender;
  final dynamic birthTimestamp;
  final dynamic avatarPath;
  final dynamic avatarBaseUrl;
  final dynamic address;
  final dynamic website;
  final dynamic typeAccount;
  final dynamic companyName;
  final dynamic companyCertificate;
  final int created;
  final int star;
  final int expire;
  final int starBonus;
  final int expireBonus;
  final bool enableFree;

  // Get
  bool get expireNotEmplty => (expire != null && expire > 0);
  int get getCurrentMiliSeconds =>
      (DateTime.now().millisecondsSinceEpoch / 1000).round();
  bool get stillExpired => (expire > getCurrentMiliSeconds);
  bool get isSSOAccount => expireNotEmplty && stillExpired;
  String get getUserName => getName ?? getPhone ?? getEmail ?? ' bạn đọc';
  int get getStar => star ?? 0;
  String get getId => (id?.isNotEmpty ?? false) ? id : '';
  String get getName => (name?.isNotEmpty ?? false) ? name : null;
  String get getPhone => (phone?.isNotEmpty ?? false) ? phone : null;
  String get getEmail => (email?.isNotEmpty ?? false) ? email : null;
  String get getPass => (pass?.isNotEmpty ?? false) ? pass : null;
  String get getExpire => AppHelpers.getStrDayFromMiliSeconds(expire);
  String get getBirthTimestamp => (birthTimestamp?.isNotEmpty ?? false)
      ? AppHelpers.getStrDayFromMiliSeconds(birthTimestamp)
      : '';

  String get currentName => objectUserChange?.name != null
      ? AppHelpers.safeString(objectUserChange.name)
      : name;
  String get currentAvatar => objectUserChange != null &&
          AppHelpers.safeString(objectUserChange.avatar).length != 0
      ? AppHelpers.safeString(objectUserChange.avatar)
      : (AppHelpers.safeString(avatar).length != 0
          ? AppHelpers.safeString(avatar)
          : "");
  String get currentAvatarAbsoluteURL =>
      AppHelpers.safeString(currentAvatar).length != 0
          ? processURL(AppHelpers.safeString(currentAvatar))
          : "";
  String processURL(String url) {
    if (AppHelpers.safeString(url).length == 0) {
      return "";
    }
    return AppHelpers.safeString(url).startsWith("http")
        ? AppHelpers.safeString(url)
        : Apis.basePhotoUrl + AppHelpers.safeString(url);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    if (json == null || json.isEmpty) {
      return UserModel();
    }

    return UserModel(
      id: lookup<String>(json, ['id']) ?? '',
      email: lookup<String>(json, ['email']),
      googleId: lookup<String>(json, ['google_id']) ?? '',
      facebookId: lookup<String>(json, ['facebook_id']) ?? '',
      name: lookup<String>(json, ['name']),
      avatar: lookup<String>(json, ['avatar']) ?? '',
      status: lookup<int>(json, ['status']),
      phone: lookup<String>(json, ['phone']),
      createdDate: lookup<String>(json, ['created_date']) ?? '',
      objectUserChange: json["object_user_change"] != null &&
              json["object_user_change"] is Map
          ? UserChangeModel.fromJson(json["object_user_change"])
          : UserChangeModel(),
      gender: json["gender"],
      birthTimestamp: json["birth_timestamp"],
      avatarPath: json["avatar_path"],
      avatarBaseUrl: json["avatar_base_url"],
      address: json["address"],
      website: json["website"],
      typeAccount: json["type_account"],
      companyName: json["company_name"],
      companyCertificate: json["company_certificate"],
      created: json["created"],
      star: json["star"],
      expire: json["expire"],
      starBonus: json["star_bonus"],
      expireBonus: json["expire_bonus"],
      enableFree: json["enable_free"],
    );
  }

  Map<String, dynamic> get mapping {
    Map<String, dynamic> bodyData = Map<String, dynamic>();

    if (this.id != null && this.id.length != 0) {
      bodyData["id"] = this.id;
    }
    if (this.email != null && this.email.length != 0) {
      bodyData["email"] = this.email;
    }
    if (this.googleId != null && this.googleId.length != 0) {
      bodyData["google_id"] = this.googleId;
    }
    if (this.facebookId != null && this.facebookId.length != 0) {
      bodyData["facebook_id"] = this.facebookId;
    }
    if (this.name != null && this.name.length != 0) {
      bodyData["name"] = this.name;
    }
    if (this.avatar != null && this.avatar.length != 0) {
      bodyData["avatar"] = this.avatar;
    }
    bodyData["status"] = this.status.toString();
    if (this.phone != null && this.phone.length != 0) {
      bodyData["phone"] = this.phone;
    }
    if (this.createdDate != null && this.createdDate.length != 0) {
      bodyData["created_date"] = this.createdDate;
    }
    if (this.objectUserChange != null) {
      bodyData["object_user_change"] = this.objectUserChange.mapping;
    }

    return bodyData;
  }

  UserModel copyWith(int _star) {
    return UserModel(
      id: this.id,
      email: this.email,
      phone: this.phone,
      name: this.name,
      gender: this.gender,
      birthTimestamp: this.birthTimestamp,
      avatarPath: this.avatarPath,
      avatarBaseUrl: this.avatarBaseUrl,
      address: this.address,
      website: this.website,
      typeAccount: this.typeAccount,
      companyName: this.companyName,
      companyCertificate: this.companyCertificate,
      created: this.created,
      star: _star ?? this.star,
      expire: this.expire,
      starBonus: this.starBonus,
      expireBonus: this.expireBonus,
      enableFree: this.enableFree,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "gender": gender,
        "birth_timestamp": birthTimestamp,
        "avatar_path": avatarPath,
        "avatar_base_url": avatarBaseUrl,
        "address": address,
        "website": website,
        "type_account": typeAccount,
        "company_name": companyName,
        "company_certificate": companyCertificate,
        "created": created,
        "star": star,
        "expire": expire,
        "star_bonus": starBonus,
        "expire_bonus": expireBonus,
        "enable_free": enableFree,
      };
}
