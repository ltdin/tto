import 'package:news/base/app_helpers.dart';
import 'package:news/models/setting.dart';
import 'package:news/repository/account_provider.dart';
import 'package:news/util/validators.dart';

class AuthBloc extends Validators {
  final authRepository = TTOAccountProvider();

  String storeEmail = null;
  String storePass = null;
  String errorName = null;
  String errorEmailLogin = null;
  String errorPhone = null;
  String errorGetPassAgain = null;
  String errorEmailRegister = null;
  String errorPassRegister = null;

  // SSO
  Future<bool> sendOtpToPhone(String phone) async {
    return await authRepository.sendOtpToPhone(phone);
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    return await authRepository.verifyOtp(phone, otp);
  }

  Future<bool> login(String email, String pass) async {
    return await authRepository.login(email, pass);
  }

  Future<bool> logout() async {
    return await authRepository.logout();
  }

  Future<bool> getPassAgain(String phoneOrEmail) async {
    return await authRepository.getPassAgain(phoneOrEmail);
  }

  Future<bool> register(String email, String pass) async {
    return await authRepository.register(email, pass);
  }

  Future<bool> giftStar(String articleLink, int number) async {
    return await authRepository.giftStar(articleLink, number);
  }

  Future<bool> getUpdateUserInfo() async {
    return await authRepository.getUpdateUserInfo();
  }

  Future<bool> voteReaction(int action, String newsId,
      {String starcount = '1'}) async {
    return await authRepository.voteReaction(
      action,
      newsId,
      starcount: starcount,
    );
  }

  Future<Setting> getSetting() async {
    return await authRepository.getSetting();
  }

  Future<void> updateSetting(String idNews) async {
    return await authRepository.updateSetting(idNews);
  }

  // TTO
  bool isValidRegister(String email, String pass) {
    // Valid email
    if (email.length == 0 || email == null) {
      errorEmailRegister = "Vui lòng nhập email";
      return false;
    }

    if (!Validators.isValidEmail(email)) {
      errorEmailRegister = "Email không hợp lệ";
      return false;
    }
    errorEmailRegister = null;

    // Valid pass
    if (pass.length == 0 || pass == null) {
      errorPassRegister = "Vui lòng nhập mật khẩu";
      return false;
    }
    if (!Validators.isValidPass(pass)) {
      errorPassRegister = "Mật khẩu phải trên 5 ký tự";
      return false;
    }
    errorPassRegister = null;

    return true;
  }

  bool isValidPhone(String phone) {
    // Valid email
    if (phone == null || phone.length < 8) {
      errorPhone = "Vui lòng nhập số điện thoại hợp lệ";
      return false;
    }

    if (!AppHelpers.isNumeric(phone)) {
      errorPhone = "Sai định dạng";
      return false;
    }

    errorPhone = null;

    return true;
  }

  bool isValidGetPassAgain(String phoneOrEmail) {
    // Valid null email/phone
    if (phoneOrEmail == null) {
      errorGetPassAgain = "Vui lòng nhập thông tin";
      return false;
    }

    // Check is email or phone
    if (!Validators.isValidEmail(phoneOrEmail) &&
        !AppHelpers.isNumeric(phoneOrEmail)) {
      errorGetPassAgain = "Sai định dạng";
      return false;
    }

    errorGetPassAgain = null;
    return true;
  }

  bool isValidLogin(String email, String pass) {
    // Save for email + pass
    storeEmail = email;
    storePass = pass;

    // Valid email
    if (email.length == 0 || email == null) {
      errorEmailLogin = "Vui lòng nhập email";
      return false;
    }
    if (!Validators.isValidEmail(email)) {
      errorEmailLogin = "Email không hợp lệ";
      return false;
    }
    errorEmailLogin = null;

    // Valid pass
    if (pass.length == 0 || pass == null) {
      errorPassRegister = "Vui lòng nhập mật khẩu";
      return false;
    }

    if (!Validators.isValidPass(pass)) {
      errorPassRegister = "Mật khẩu phải trên 5 ký tự";
      return false;
    }

    errorPassRegister = null;

    return true;
  }

  Future<dynamic> deleteAccount() async {
    return await authRepository.deleteUser();
  }
}

final authBloc = AuthBloc();
