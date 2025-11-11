import 'package:news/models/article_model.dart';

class BoxEvents {
  const BoxEvents({this.boxEventOne});
  final List<Article> boxEventOne;

  factory BoxEvents.fromJson(Map<String, dynamic> json) => BoxEvents(
        boxEventOne: List<Article>.from(
          json["BoxEventOne"].map((x) => Article.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {"BoxEventOne": boxEventOne};
}
