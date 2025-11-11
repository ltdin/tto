import 'package:news/constant/bool.dart';

class Apis {
  // Gobal
  static const bool ENV = LIVE_ENV;

  static const String api_demo = 'https://app5.tuoitre.vn/beta';
  static const String api_live = 'https://app5.tuoitre.vn';

  static const String raovat = 'https://raovat.tuoitre.vn';
  static const String tvo = 'https://video.tuoitre.vn';
  static const String nhatbao = 'https://nhatbao.tuoitre.vn';

  static const String sso_beta = 'https://beta-sso.tuoitre.vn';
  static const String sso_live = 'https://sso.tuoitre.vn';
  static const String ss5 = 'https://s5.tuoitre.vn';
  static const String domainfe = 'https://epaper.tuoitre.vn/api/mobile';

  static const String broker_name_beta = 'beta-client';
  static const String broker_name_live = 'app-tuoitre';

  static const String public_key_beta =
      'oQt5MjeoVNokTWVmdUu0bUPNd7HPDkXrtCtChMBnqLVdS8ck';
  static const String public_key_live =
      'rcpZizmWTxxPnfNcT8pXyiyTfD3lLCQW9KIF4kF2QdHc8Rgj';

  static const String live_secret_key = r'0A83425hWdn#@^I6ccrgo19Y';
  static const String demo_secret_key = r'erR35c7eZr$%^Sj99KOj7OYOvzt7@48e';

  static const String webviewUrl = 'https://app.tuoitre.vn';
  static const String basePhotoUrl = 'https://cdn2.tuoitre.vn/';
  static const String basePhotoUrl600 = '${basePhotoUrl}thumb_w/600/';
  static const String basePhotoUrl300x187 = '${basePhotoUrl}zoom/300_187/';
  static const String basePhotoUrl480x300 = '${basePhotoUrl}zoom/480_300/';

  // Get
  static const api_tto_url = ENV ? api_live : api_demo;
  static const sso_url = ENV ? sso_live : sso_beta;
  static const broker_name = ENV ? broker_name_live : broker_name_beta;
  static const public_key = ENV ? public_key_live : public_key_beta;
  static const secretKey = live_secret_key;

  // Home page lists
  static const String homeData = '$api_tto_url/tuoitre-api/app/home';
  static const String homePaging = '$api_tto_url/tuoitre-api/app/home/paging';
  static const String threadPaging= '$api_tto_url/tuoitre-api/app/home-thread-paging';

  static const String classiFieds =
      '$raovat/api/list/list-top-ttorv?page=1&number=5';
  static const String ttNews =
      'https://tuoitrenews.vn/api/vcc/tto/get-data-ttnews';


  // Article
  static const String articleDetail =
      '$api_tto_url/tuoitre-api/app/news/detail';
  static const String articleDetailNative =
      '$api_tto_url/tuoitre-api/app/news/detail/native';
  static const String articleVideoDetail =
      '$api_tto_url/tuoitre-api/app/video/detail';
  static const String newsInterest =
      '$api_tto_url/tuoitre-api/app/news/interest';
  static const String newsLastest = '$api_tto_url/tuoitre-api/app/news/lastest';
  static const String hightViews =
      '$api_tto_url/tuoitre-api/app/zone/hight-views';
  static const String searchTag = '$api_tto_url/tuoitre-api/app/search/tag';
  static const String authorList =
      '$api_tto_url/tuoitre-api/app/news/by-author';

  // Category
  static const String zoneList = '$api_tto_url/tuoitre-api/app/zone/list';
  static const String videoList = '$api_tto_url/tuoitre-api/app/video';
  static const String podcastList =
      '$api_tto_url/tuoitre-api/app/podcast/lastest';
  static const String photoList = '$api_tto_url/tuoitre-api/app/photo';
  static const String megaStoryList = '$api_tto_url/tuoitre-api/app/megastory';
  static const String listingByZone = '$api_tto_url/tuoitre-api/app/zone';
  static const String zoneListPaging =
      '$api_tto_url/tuoitre-api/app/zone/paging';

  // Search
  static const String searchList = '$api_tto_url/tuoitre-api/app/search';

  // Account
  static const String newsGetComment =
      '$api_tto_url/tuoitre-api/app/account/get/comments';
  static const String accountAddNews =
      '$api_tto_url/tuoitre-api/app/account/add/news';
  static const String accountAddComment =
      '$api_tto_url/tuoitre-api/app/account/add/comment';
  static const String accountInteractiveComment =
      '$api_tto_url/tuoitre-api/app/account/interactive/comment';
  static const String accountLogin =
      '$api_tto_url/tuoitre-api/app/account/login';
  static const String accountRegister =
      '$api_tto_url/tuoitre-api/app/account/register';
  static const String accountChangeInfo =
      '$api_tto_url/tuoitre-api/app/account/change/info';
  static const String accountChangePassword =
      '$api_tto_url/tuoitre-api/app/account/change/password';
  static const String accountDelete =
      '$api_tto_url/tuoitre-api/app/account/delete';
  static const String getSettingApp =
      'http://45.32.19.162/app_tto/get_setting.php';
  static const String updateSetting =
      'http://45.32.19.162/app_tto/update_id_news.php';

  // SSO
  static const String sendOtpToPhone = '$sso_url/sso/v1/receive-otp';
  static const String refreshToken = '$sso_url/sso/v1/refresh-token';
  static const String renewToken =
      '$sso_url/sso/v1/token?broker=$broker_name&publicKey=$public_key';
  static const String verifyOtp = '$sso_url/sso/v1/otp';
  static const String logout = '$sso_url/sso/v1/logout';
  static const String resetPasswordForPhone = '$sso_url/sso/v1/reset-password';
  static const String resetPasswordForEmail =
      '$sso_url/sso/v1/forgot-password-by-email';
  static const String register = '$sso_url/sso/v1/register';
  static const String registerByEmail = '$sso_url/sso/v1/register-by-email';
  static const String login = '$sso_url/sso/v1/login';
  static const String donate = '$sso_url/sso/v1/donate';
  static const String info = '$sso_url/sso/v1/info';
  static const String voteReaction = '$ss5/vote-reaction.htm';
  static const String updateVoteReaction = '$ss5/updatevote-reaction.htm';
  static const String sendTheQuestion = '$ss5/Handlers/SendQuestion.ashx';

  // NewsPaper
  static const String detailDailyNewsPaper =
      '$domainfe/fe/newspaper/list-newspaper';
  static const String latestNewspaper =
      '$domainfe/fe/newspaper/latest-newspaper';
  static const String latestSpecialtyNews =
      '$domainfe/fe/newspaper/latest-ttds';
  static const String listNewspaper = '$domainfe/fe/profile-detail/search';

}
