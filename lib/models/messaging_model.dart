class Messaging {
  final String url;

  const Messaging({this.url});

  factory Messaging.fromJson(Map<dynamic, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Messaging(
      url: json["url"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {"url": url};
}
