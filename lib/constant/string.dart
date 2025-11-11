import 'package:news/models/zone_model.dart';

String strToken = 'copy';

class KString {
  static const String strCheckVersion = 'Phiên bản';

  // Update app
  static const APP_STORE_URL =
      'https://apps.apple.com/us/app/tu%E1%BB%95i-tr%E1%BA%BB-online/id974433568?l';
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=vn.tuoitre.app';

  // Url web
  static const TTO_URL = 'https://tuoitre.vn';
  static const TECH_TTO_URL = 'https://congnghe.tuoitre.vn';
  static const SPORT_TTO_URL = 'https://thethao.tuoitre.vn';
  static const TRAVEL_TTO_URL = 'https://dulich.tuoitre.vn';
  static const APP_TTO_URL = 'https://app.tuoitre.vn';
  static const TVO_URL = 'https://tv.tuoitre.vn';
  static const PODCAST_URL = 'https://podcast.tuoitre.vn';
  static const TT_NEWS_URL = 'https://news.tuoitre.vn/';
  static const TT_MUCTIM_URL = 'https://muctim.tuoitre.vn';
  static const VIDEO_URL = 'https://video.tuoitre.vn/';
  static const CUOI_TUAN_URL = 'https://cuoituan.tuoitre.vn';
  static const CUOI_URL = 'https://cuoi.tuoitre.vn';
  static const RAO_VAT_URL = 'https://raovat.tuoitre.vn';
  static const QUANG_CAO_URL = 'https://quangcao.tuoitre.vn';
  // static const DAT_BAO_URL = 'https://pay.tuoitre.vn/dat-bao';
  static const DAT_BAO_URL = 'https://order.tuoitre.vn/formOrder.aspx';
  static const THREAD_URL = 'https://tuoitre.vn/nhom-chu-de.htm';
  static const THOI_TIET_URL = 'https://tuoitre.vn/thoi-tiet.htm';
  static const TTSHOP_URL = 'https://tuoitreshop.vn';

  static const TNDG_URL = 'https://tuoitre.vn/trai-nghiem-va-danh-gia.htm';

  // Search page
  static const String searchHomeTitleNavigation = "Tìm kiếm";
  static const String searchBarTextBoxHome = "Nhập từ khoá tìm kiếm ...";
  static const String searchHomeBoxRecommendTitle = "Mọi người cũng tìm kiếm";
  static const String categoryListTitleNavigation = "DANH MỤC";

  // Text
  static const String msgNoData = "Không có dữ liệu";
  static const String msgFunctionNotFinish =
      'Tính năng đang phát triển.Vui lòng chờ bản cập nhật sau!';
  static const String msgSignInFaild =
      "Tên đăng nhập hoặc mật khẩu không đúng. Vui lòng thử lại.";
  static const String msgDeleteAccountFaild = "Xoá tài khoản không thành công.";
  static const String msgDeleteAccountSuccess =
      "Đã xoá tài khoản. Vui lòng đợi một vài phút để hoàn tất quá trình xoá tài khoản";
  static const String msgRegisterFaild =
      "Tài khoản đã tồn tại. Vui lòng chọn một tài khoản khác";
  static const String msgRegisterSuccess = "Đăng ký thành công.";
  static const String msgEmailFaild = "Tên hoặc email không hợp lệ.";
  static const String msgSent = "Đã gửi";
  static const String msgLiked = 'Bạn đã yêu thích bài viết';

  // Home page
  static const String strRegisterAccount = "Đăng ký tài khoản";
  static const String strRecentlyRead = "Tin đã xem";
  static const String strHome = 'Trang nhất';
  static const String strSetting = "Cài đặt";
  static const String strLogin = "Đăng nhập";
  static const String strAccount = "Cá nhân";
  static const String strNumberHotline = "+84918033133";
  static const String strForYou = "Dành cho bạn";
  static const String strNewest = 'Mới nhất';
  static const String strResult = 'Kết quả';
  static const String strProbe = 'Thăm dò';
  static const String strVote = 'Bỏ phiếu';
  static const String strListenThisNews = 'Nghe tập này';
  static const String strPleaseChoose = 'Vui lòng chọn ý kiến của bạn';
  static const String strThanksVoted = 'Cám ơn bạn đã bình chọn';
  static const String strRegisterTTS = 'Đăng ký Tuổi Trẻ sao';
  static const String strQuestionsExperts = 'Câu hỏi cho chuyên gia';
  static const String strLegalAdvice = 'Tư vấn pháp luật';
  static const String strAskAboutHealth = 'Hỏi chuyện sức khỏe';
  static const String strReadPrintNewspaper = 'Đọc báo in';

  static const List<ZoneList> cates = [

    ZoneList(zoneId: 3, name: "Thời sự", admChannel: "/thoi-su/"),
    ZoneList(zoneId: 2, name: "Thế giới", admChannel: "/the-gioi/"),
    ZoneList(zoneId: 6, name: "Pháp luật", admChannel: "/phap-luat/"),
    ZoneList(zoneId: 11, name: "Kinh doanh", admChannel: "/kinh-doanh/"),
    ZoneList(zoneId: 200029, name: "Công nghệ", admChannel: "/cong-nghe/home/"),
    ZoneList(zoneId: 659, name: "Xe", admChannel: "/xe/"),
    ZoneList(zoneId: 100, name: "Du lịch", admChannel: "/du-lich/home/"),
    ZoneList(zoneId: 7, name: "Nhịp sống trẻ", admChannel: "/nhip-song-tre/"),
    ZoneList(zoneId: 200017, name: "Văn hóa", admChannel: "/van-hoa/"),
    ZoneList(zoneId: 10, name: "Giải trí", admChannel: "/giai-tri/"),
    ZoneList(zoneId: 1209, name: "Thể thao", admChannel: "/the-thao/home/"),
    ZoneList(zoneId: 13, name: "Giáo dục", admChannel: "/giao-duc/"),
    ZoneList(zoneId: 661, name: "Khoa học", admChannel: "/khoa-hoc/"),
    ZoneList(zoneId: 12, name: "Sức khỏe", admChannel: "/suc-khoe/"),
    ZoneList(zoneId: 200015, name: "Giả Thật", admChannel: "/gia-that/"),
    ZoneList(zoneId: 118, name: "Bạn đọc làm báo", admChannel: "/ban-doc-lam-bao/"),
    ZoneList(zoneId: 334, name: "Cần biết", admChannel: "/can-biet/"),
    // ZoneList(zoneId: 204, name: "Nhà đất", admChannel: "/nha-dat/"), lỗi
    ZoneList(zoneId: 200070, name: "Thời tiết", admChannel: "/thoi-tiet/"),

  ];
  static const List<String> boxPicture = ['Ảnh', ' Megastory', ' Infographic'];
  static const List<String> boxTopView = ['Xem nhiều',' Sao nhiều'];//code tao nè
  static const String CACHE_HOME_PAGE_NEW = 'CACHE_HOME_PAGE_NEW';
  static const String CACHE_RECOMMEND_PAGE_NEW = 'CACHE_RECOMMEND_PAGE_NEW';
  static const String CACHE_LASTEST_PAGE_NEW = 'CACHE_LASTEST_PAGE_NEW';
  static const String CACHE_VIDEO_PAGE_NEW = 'CACHE_VIDEO_PAGE_NEW';
  static const String CACHE_PODCAST_PAGE_NEW = 'CACHE_PODCAST_PAGE_NEW';
  static const String CACHE_SETTING_APP = 'CACHE_SETTING_APP';
  static const String CACHE_STARS_PAGE_NEW = 'CACHE_STARS_PAGE_NEW';
  static const String HOME_PAGE = 'Trang chủ';
  static const String TTS_PAGE = 'Tuổi Trẻ Sao';
  static const String STR_SEE_MORE = 'Xem thêm';
  static const String LASTLEST_PAGE = 'Mới nhất';
  static const String STR_RECOMMEND = 'Xem nhiều';
  static const String STR_MANY_STARS_PAGE = 'Sao nhiều';
  static const String VIDEO_PAGE = 'Video';
  static const String PODCAST_PAGE = 'Podcast';
  static const String TNDG_PAGE = 'Trải nghiệm & Đánh giá';//chưa

  // Setting page
  static const String strTextSize = "Kích cỡ chữ";
  static const String strSentMail = 'Gửi mail góp ý';
  static const String strListViewedNews = 'Danh sách tin đã xem';
  static const String strReciveNotification = 'Nhận thông báo';
  static const String strDarkMode = 'Chế độ nền tối';
  static const String strContactAds = 'Liên hệ quảng cáo';
  static const String strDeleteAccount = 'Xóa tài khoản';
  static const String strRateApp = 'Đánh giá app TuoiTre.vn';

  // Video tvo page
  static const String strRelationsVideo = 'Video liên quan';

  // User page
  static const String strLoginWithEmailOrPhone =
      'Nhập email hoặc số điện thoại';
  static const String strGetPassWord =
      'Bạn chưa có hoặc quên mật khẩu? Cài đặt lại mật khẩu qua email hoặc SMS.';
  static const String strRegister = "Đăng ký";
  static const String strCreateAccount = "Tạo tài khoản";
  static const String strFogetPassWord = "Quên mật khẩu ?";
  static const String strGetPassWordAgain = "CÀI ĐẶT LẠI MẬT KHẨU";
  static const String strInputPassWord = "Nhập mật khẩu";
  static const String strErrorNetwork = "Lỗi kết nối hệ thống";
  static const String jwtTokenDefault =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2JldGEtc3NvLnR1b2l0cmUudm4iLCJpYXQiOjE2NzkyMDc1MDEsInRva2VuIjoiYWI3YjVhM2YyZmM1ZGY2MzI2NzlmNGY3NWJiNmI0MGZlYTA0YTQxNDA1NDE1NDc2YjY5MDUxNDQxMTFmZTI5ZSIsImJyb2tlciI6ImJldGEtY2xpZW50In0.5De5X0mml5AzuGm5FjSeOq4IIai-wwkq-aaXtZvc5Is';
  static const String tokenDefault =
      'ab7b5a3f2fc5df632679f4f75bb6b40fea04a41405415476b6905144111fe29e';

  // Detail
  static const String stShareNews = 'Chia sẻ';
  static const String strRelationsNews = 'Tin liên quan';
  static const String STR_BODY_ROW_TYPE_PHOTO = 'photo';
  static const String STR_BODY_ROW_TYPE_P = 'p';
  static const String STR_BODY_ROW_TYPE_VIDEO = 'videoStream';
  static const String STR_BODY_ROW_TYPE_VIDEO_SQUARE = 'videoStreamSquare';
  static const String STR_BODY_ROW_TYPE_WRAPNOTE = 'wrapnote';
  static const String STR_BODY_ROW_TYPE_H1 = 'h1';
  static const String STR_BODY_ROW_TYPE_H2 = 'h2';
  static const String STR_BODY_ROW_TYPE_H3 = 'h3';
  static const String STR_BODY_ROW_TYPE_H4 = 'h4';
  static const String msgIsWebViewNews =
      'Tin bài đặc biệt không sử dụng được chức năng này';
  static const String strNotDataComment = 'Không có bình luận';
  static const String strErrorReadAudioNews = 'Không thể đọc được tin này';
}

// Remote config key
const String is_close_admob_in_app = 'is_close_admob_in_app';

// Cache key
const String THEME_SETTING = 'THEME_SETTING';
const String TEXT_ZOOM = 'TEXT_ZOOM';
const String ADS_INTERSTITIALS_TIME = 'ADS_INTERSTITIALS_TIME';
const String DART_THEME = 'DART_THEME';
const String TTS_THEME = 'TTS_THEME';
const String LIGHT_THEME = 'LIGHT_THEME';
const String SYSTEM_THEME = 'SYSTEM_THEME';
const String NEWS_INTEREST_KEY = 'tto_news_interest';
const String TTO_USER_KEY = 'TTOUserJSONModel';
const String PWD_KEY = "pwd";
const String PHOTO_KEY = "photo";
const String AVATA_USER_BASE64 = "AVATA_USER_BASE64";
const String IS_LOGGED_IN = "is_logged_in";
const String IS_TT_STAR = "is_tt_star";
const String JWT_TOKEN = "jwt_token";
const String TOKEN = "token";
