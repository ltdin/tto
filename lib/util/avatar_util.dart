import 'package:news/api/apis.dart';

class AvatarUtil {
  static String avatarMedium(String avatar) {
    avatar = avatar.replaceAll("http://", "https://");
    return avatar.replaceAll(
        Apis.basePhotoUrl, Apis.basePhotoUrl + "zoom/504_315/");
  }

  static String avatar480x300(String avatar) {
    avatar = avatar.replaceAll("http://", "https://");
    return avatar.replaceAll(
        Apis.basePhotoUrl, Apis.basePhotoUrl + "zoom/480_300/");
  }

  static String avatar320x200(String avatar) {
    avatar = avatar.replaceAll("http://", "https://");
    return avatar.replaceAll(
        Apis.basePhotoUrl, Apis.basePhotoUrl + "zoom/320_200/");
  }

  static String avatarGifToPng(String avatar) {
    if (avatar == null) return null;
    if (avatar?.indexOf(".gif") == -1) {
      return avatar;
    }
    return avatar + ".png";
  }
}
