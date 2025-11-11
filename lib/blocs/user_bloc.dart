import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/user_model.dart';

class UserBloc {
  UserModel userInfo = UserModel();
  List<int> _photoBytes;
  String token;
  String jwtToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2JldGEtc3NvLnR1b2l0cmUudm4iLCJpYXQiOjE2NzkyMDc1MDEsInRva2VuIjoiYWI3YjVhM2YyZmM1ZGY2MzI2NzlmNGY3NWJiNmI0MGZlYTA0YTQxNDA1NDE1NDc2YjY5MDUxNDQxMTFmZTI5ZSIsImJyb2tlciI6ImJldGEtY2xpZW50In0.5De5X0mml5AzuGm5FjSeOq4IIai-wwkq-aaXtZvc5Is';

  // Get
  List<int> get photoBytes => _photoBytes;
  String get getToken =>
      (token?.isNotEmpty ?? false) ? token : KString.tokenDefault;

  Future<void> loadUserInfoFromCache({VoidCallback completionHandler}) async {
    Map<String, dynamic> jsonModel = await AppCache.load(TTO_USER_KEY);
    printDebug("jsonModel: $jsonModel}");
    if (jsonModel != null) {
      userInfo = UserModel.fromJson(jsonModel);
    }
  }

  Future<void> saveCacheUser() async {
    await AppCache.save(key: TTO_USER_KEY, jsonModel: userInfo.toJson());
  }

  /// Image encoded base64
  Future<bool> savePhoto(File photo) async {
    if (photo == null) {
      return null;
    }

    _photoBytes = await photo.readAsBytes();

    // Convert from Uint8List to Base64
    final avataBase64 = base64.encode(_photoBytes);

    // Save base64 to cache
    AppCache().avataUser = avataBase64;

    return _photoBytes != null ? true : false;
  }
}

final userBloc = UserBloc();
