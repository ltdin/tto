import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:news/api/apis.dart';
import 'package:news/api/http_utility.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/models/request_model.dart';
import 'package:news/models/setting.dart';
import 'package:news/models/sso_response_model.dart';
import 'package:news/models/user_model.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/util/validators.dart';

class TTOAccountProvider {
  final httpUtility = Service();
  Client client = Client();
  Map<String, String> get headers => {
        "authorization": 'Bearer ${userBloc.jwtToken}',
      };

  // Get
  String get contentTypeHeaderValue => "application/x-www-form-urlencoded";
  String get xAccessTokenHeaderValue => userBloc.token;
  String get userID => userBloc.userInfo.getId;

  // SSO new token
  Future<bool> requireNewTokenSSO({bool isShowToast = true}) async {
    // Setup request
    final request = RequestModel(
      method: Method.GET,
      urlApi: Apis.renewToken,
      headers: headers,
    );

    // Connect api
    final response =
        await Service().getRequest(request, isSsoApi: true) as SsoResponseModel;

    // Handle error network
    if (response == null) {
      if (isShowToast) {
        AppHelpers.showToast(text: KString.strErrorNetwork);
      }
      return false;
    }

    // When success
    if (response.renewIsSuccess) {
      userBloc.jwtToken = response.jwt;
      AppCache().jwtToken = userBloc.jwtToken;
      return true;
    }

    return false;
  }

  // SSO refresh token
  Future<bool> refreshTokenSSO(
    SsoResponseModel _response, {
    bool isShowToast = true,
  }) async {
    // Check Broker not esxist
    if (_response.isBrokerNotExist) {
      await requireNewTokenSSO();
    }

    // Setup request
    final request = RequestModel(
      method: Method.GET,
      urlApi: Apis.refreshToken,
      headers: headers,
    );

    // Connect api
    final response =
        await Service().getRequest(request, isSsoApi: true) as SsoResponseModel;

    // Handle error network
    if (response == null) {
      if (isShowToast) {
        AppHelpers.showToast(text: KString.strErrorNetwork);
      }
      return false;
    }

    // When require new token
    if (response.isTokenRequireNew || response.isBrokerNotExist) {
      final isRenew = await requireNewTokenSSO(isShowToast: isShowToast);

      if (isRenew) {
        return await refreshTokenSSO(
          response,
          isShowToast: isShowToast,
        );
      }
    }

    // When success
    if (response.refreshIsSuccess) {
      // Save jwt
      userBloc.jwtToken = response.jwt;
      AppCache().jwtToken = userBloc.jwtToken;

      // Save token
      userBloc.token = response.token;
      AppCache().token = userBloc.token;

      return true;
    }

    return false;
  }

  // SSO send otp
  Future<bool> sendOtpToPhone(String phone) async {
    // Setup request
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.sendOtpToPhone,
      params: {"phone": phone},
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.postRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      AppHelpers.showToast(text: KString.strErrorNetwork);
      return false;
    }

    // When send is success
    if (response.sendOtpIsSuccess) {
      return true;
    }

    // When send is false
    if (response.sendOtpIsFail) {
      if (response.isTokenHasExpired) {
        // Get new token
        final hasRefresh = await refreshTokenSSO(response);

        // Connect again
        if (hasRefresh) {
          final send = await sendOtpToPhone(phone);
          return send;
        } else {
          AppHelpers.showToast(text: response.message);
        }
      } else {
        AppHelpers.showToast(
            text: response.message + ' . ' + response.errors["other"]);
        return false;
      }
    }

    return false;
  }

  // SSO verify otp
  Future<bool> verifyOtp(String phone, String otp) async {
    // Setup request
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.verifyOtp,
      params: {"phone": phone, "otp": otp},
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.postRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      AppHelpers.showToast(text: KString.strErrorNetwork);
      return false;
    }

    // Check token has expired
    if (response.isTokenHasExpired) {
      // Get new token
      final hasRefresh = await refreshTokenSSO(response);

      // When has refresh
      if (hasRefresh) {
        return await verifyOtp(phone, otp);
      } else {
        AppHelpers.showToast(text: KString.strErrorNetwork);
      }
    }

    // When send is success
    if (response.stateIsSuccess) {
      _handleDataWhenLoginSuccess(response);
      return true;
    }

    AppHelpers.showToast(text: response.message);
    return false;
  }

  // SSO login
  Future<bool> login(String user, String pass) async {
    final deviceCategory = _getDeviceType();

    // Setup request
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.login,
      params: {
        "username": user,
        "password": pass,
        "plaform": Platform.isAndroid ? 'android' : 'ios',
        "device_category": deviceCategory,
      },
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.postRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      AppHelpers.showToast(text: KString.strErrorNetwork);
      return false;
    }

    // Check token has expired
    if (response.isTokenHasExpired) {
      // Get new token
      final hasRefresh = await refreshTokenSSO(response);

      // When has refresh
      if (hasRefresh) {
        return await login(user, pass);
      } else {
        AppHelpers.showToast(text: KString.strErrorNetwork);
      }
    }

    // When send is success
    if (response.stateIsSuccess) {
      _handleDataWhenLoginSuccess(response);
      return true;
    }

    AppHelpers.showToast(text: response.message);
    return false;
  }

  void _handleDataWhenLoginSuccess(SsoResponseModel _response) {
    userBloc.userInfo = UserModel.fromJson(_response.dataInfo);
    userBloc.saveCacheUser();

    // Set token
    userBloc.token = _response.dataToken;
    AppCache().token = userBloc.token;

    // Set jwt
    userBloc.jwtToken = _response.dataJwt;
    AppCache().jwtToken = userBloc.jwtToken;

    // Save flag loggedIn
    globals.isLoggedIn = FLAG_ON;
    AppCache().isLoggedIn = globals.isLoggedIn;

    // Save TTStar
    globals.isTTStar = userBloc.userInfo.isSSOAccount;
    AppCache().isTTStar = globals.isTTStar;
  }

  // SSO login with email
  Future<bool> logout() async {
    // Setup request
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.logout,
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.postRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      AppHelpers.showToast(text: KString.strErrorNetwork);
      return false;
    }

    // Check token has expired
    if (response.isTokenHasExpired) {
      // Get new token
      final hasRefresh = await refreshTokenSSO(response);

      // When has refresh
      if (hasRefresh) {
        return await logout();
      } else {
        AppHelpers.showToast(text: response.message);
      }
    }

    // When send is success
    if (response.stateIsSuccess) {
      return true;
    }

    AppHelpers.showToast(text: response.message);
    return false;
  }

  // SSO login with email
  Future<bool> getPassAgain(String phoneOrEmail) async {
    final _isEmail = Validators.isValidEmail(phoneOrEmail);
    final _urlApi =
        _isEmail ? Apis.resetPasswordForEmail : Apis.resetPasswordForPhone;
    final _params =
        _isEmail ? {"email": phoneOrEmail} : {"emailOrPhone": phoneOrEmail};

    // Setup request
    final request = RequestModel(
      method: Method.POST,
      urlApi: _urlApi,
      params: _params,
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.postRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      AppHelpers.showToast(text: KString.strErrorNetwork);
      return FLAG_OFF;
    }

    // Check token has expired
    if (response.isTokenHasExpired) {
      // Get new token
      final hasRefresh = await refreshTokenSSO(response);

      // When has refresh
      if (hasRefresh) {
        return await getPassAgain(phoneOrEmail);
      }
    }

    // When send is success
    // ignore: unused_local_variable
    bool _isErrorToast = FLAG_ON;

    if (response.stateIsSuccess) {
      _isErrorToast = FLAG_OFF;
    }

    // AppHelpers.showToast(text: response.message, isError: _isErrorToast);
    return response.stateIsSuccess;
  }

  // SSO login with email
  Future<bool> register(String email, String pass) async {
    final deviceCategory = _getDeviceType();

    // Setup request
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.registerByEmail,
      params: {
        "email": email,
        "password": pass,
        "plaform": Platform.isAndroid ? 'android' : 'ios',
        "device_category": deviceCategory,
      },
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.postRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      AppHelpers.showToast(text: KString.strErrorNetwork);
      return FLAG_OFF;
    }

    // Check token has expired
    if (response.isTokenHasExpired) {
      // Get new token
      final hasRefresh = await refreshTokenSSO(response);

      // When has refresh
      if (hasRefresh) {
        return await register(email, pass);
      }
    }

    // When send is success
    bool _isErrorToast = FLAG_ON;

    if (response.stateIsSuccess) {
      _isErrorToast = FLAG_OFF;
    }

    AppHelpers.showToast(text: response.message, isError: _isErrorToast);
    return response.stateIsSuccess;
  }

  // SSO gift Star
  Future<bool> giftStar(String articleLink, int number) async {
    // Setup request
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.donate,
      params: {
        "numberOfStars": '$number',
        "articleLink": articleLink,
      },
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.postRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      AppHelpers.showToast(text: KString.strErrorNetwork);
      return false;
    }

    // Check token has expired
    if (response.isTokenHasExpired) {
      // Get new token
      final hasRefresh = await refreshTokenSSO(response);

      // When has refresh
      if (hasRefresh) {
        return await giftStar(articleLink, number);
      } else {
        AppHelpers.showToast(text: response.message);
      }
    }

    // When send is success
    bool _isErrorToast = FLAG_ON;

    if (response.stateIsSuccess) {
      _isErrorToast = FLAG_OFF;
    }

    AppHelpers.showToast(text: response.message, isError: _isErrorToast);
    return response.stateIsSuccess;
  }

  // SSO get user info
  Future<bool> getUpdateUserInfo() async {
    // Setup request
    final request = RequestModel(
      urlApi: Apis.info,
      headers: headers,
    );

    // Connect api
    final response = await httpUtility.getRequest(request, isSsoApi: true)
        as SsoResponseModel;

    // Handle error network
    if (response == null) {
      return false;
    }

    // Check token has expired
    if (response.isTokenHasExpired) {
      // Get new token
      final hasRefresh = await refreshTokenSSO(response, isShowToast: false);

      // When has refresh
      if (hasRefresh) {
        return await getUpdateUserInfo();
      }
    }

    // When send is success
    userBloc.userInfo = UserModel.fromJson(response.data);
    userBloc.saveCacheUser();

    return response.stateIsSuccess;
  }

  // SSO get user info
  Future<bool> voteReaction(int action, String newsId,
      {String starcount = '1'}) async {
    // Setup request
    final request = RequestModel(
      urlApi: Apis.voteReaction,
      headers: {},
      params: {
        "newsid": newsId,
        "userid": userBloc.userInfo.getId,
        "starcount": starcount,
        "type": action.toString(),
        "status": (action == STAR) ? '0' : '1',
      },
    );

    // Connect api
    final response = await httpUtility.postRequest(request);

    // Handle error network
    if (response == null) {
      return false;
    }

    // Check fail
    if (response["Success"] == false) {
      AppHelpers.showToast(text: response["Message"]);

      return false;
    } else {
      if (action == STAR) {
        _updateVoteReaction(response["Data"].toString());
      }
    }

    return true;
  }

  // SSO update vote reaction
  Future<bool> _updateVoteReaction(String id) async {
    // Setup request
    final request = RequestModel(
      urlApi: Apis.updateVoteReaction,
      headers: {},
      params: {"id": id, "status": '1'},
    );

    // Connect api
    await httpUtility.postRequest(request);

    return true;
  }

  // Delete account
  Future<dynamic> deleteUser() async {
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.accountDelete,
      headers: {
        "Content-Type": contentTypeHeaderValue,
        "x-access-token": xAccessTokenHeaderValue
      },
      params: {
        'secret_key': Apis.secretKey,
        'user_id': userID,
      },
    );

    return await httpUtility.postRequest(request);
  }

  // Setting
  Future<Setting> getSetting() async {
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.getSettingApp,
      params: {'secret_key': Apis.secretKey},
      headers: {},
    );

    final response = await httpUtility.postRequest(request);

    return Setting.fromJson(response);
  }

  // Update setting
  Future<void> updateSetting(String idNews) async {
    final request = RequestModel(
      method: Method.POST,
      urlApi: Apis.updateSetting,
      params: {
        'secret_key': Apis.secretKey,
        'id_news': idNews,
      },
      headers: {},
    );

    final response = await httpUtility.postRequest(request);

    AppHelpers.showToast(text: response.toString());
  }

  /// Add new comment
  Future<bool> accountAddComment(TTOAddCommentParams params) async {
    var _body = params.mapping;

    final response = await client.post(
      Uri.tryParse(Apis.accountAddComment),
      headers: {
        "Content-Type": contentTypeHeaderValue,
        "x-access-token": xAccessTokenHeaderValue
      },
      body: _body,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData["status"] == 1) {
        return true;
      }
      return null;
    } else {
      throw Exception('Failed to Load');
    }
  }

  String _getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'mobile' : 'tablet';
  }
}
