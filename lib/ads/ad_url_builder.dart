class AdUrlBuilder {
  static const String siteId = "jmadjflq";

  static String buildUrl({ String zone,  String channel}) {
    return "https://quangcao.tuoitre.vn/zone/app/?site=$siteId&zone=${zone}&channel=${channel}";
    // &bz=m7iycdel&z=jwsn1c2f";
    // &bz=m79wpqzz&z=jwsn1c2f";
    //?bz=m7iycdel&z=jwsn1c2f
  }
}
