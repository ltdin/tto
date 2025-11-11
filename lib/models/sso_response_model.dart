import 'package:news/base/app_helpers.dart';
import 'package:news/constant/number.dart';

class SsoResponseModel {
  const SsoResponseModel({
    this.code = 200,
    this.requireRefresh,
    this.requirNew,
    this.message,
    this.data,
    this.type,
    this.errors,
    this.dataInfo,
    this.token,
    this.dataToken,
    this.jwt,
    this.dataJwt,
  });

  final dynamic data;
  final String message;
  final int code;
  final int type;
  final bool requireRefresh;
  final bool requirNew;
  final dynamic errors;
  final dynamic dataInfo;
  final String token;
  final String dataToken;
  final String jwt;
  final String dataJwt;

  // Get
  bool get sendOtpIsFail =>
      (code == oTPSendingFailed) || (code == tokenHasExpired);
  bool get sendOtpIsSuccess => code == success;
  bool get refreshIsSuccess => code == success;
  bool get renewIsSuccess => code == success;
  bool get stateIsSuccess => code == success;
  bool get isTokenHasExpired =>
      (code == tokenHasExpired) && (type == 11) ||
      isTokenRequireNew ||
      isBrokerNotExist;
  bool get isTokenRequireNew =>
      (code == tokenHasExpired || code == oTPSendingFailed) && (type == 12);
  bool get isBrokerNotExist => (code == tokenHasExpired) && (type == 3);

  factory SsoResponseModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData == null || (jsonData?.isEmpty ?? false)) {
      return null;
    }

    return SsoResponseModel(
      data: lookup<dynamic>(jsonData, ['data']),
      token: lookup<String>(jsonData, ['token']),
      dataToken: lookup<String>(jsonData, ['data', 'token']),
      jwt: lookup<String>(jsonData, ['jwt']),
      dataJwt: lookup<String>(jsonData, ['data', 'jwt']),
      errors: lookup<dynamic>(jsonData, ['errors']),
      dataInfo: lookup<dynamic>(jsonData, ['data', 'info']),
      message: lookup<String>(jsonData, ['message']),
      code: lookup<int>(jsonData, ['code']),
      type: lookup<int>(jsonData, ['type']),
      requireRefresh: lookup<bool>(jsonData, ['require_refresh']) ?? false,
      requirNew: lookup<bool>(jsonData, ['require_new']) ?? false,
    );
  }
}
