import 'package:news/base/app_helpers.dart';
import 'package:news/models/vote_answer.dart';

class BoxVote {
  final String id;
  final String title;
  final String sapo;
  final List<VoteAnswer> voteAnswers;

  const BoxVote({
    this.id,
    this.sapo,
    this.voteAnswers,
    this.title,
  });

  // Get set
  String get getTitle => title ?? sapo;
  bool get isNotEmplty => title != null || sapo != null;

  // Factory
  factory BoxVote.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return BoxVote(
      id: lookup<String>(json, ['Id'] ?? ''),
      title: lookup<String>(json, ['Title']),
      sapo: lookup<String>(json, ['Sapo']),
      voteAnswers: lookup<List>(json, ['VoteAnswers'])
              ?.map<VoteAnswer>((o) => VoteAnswer.fromJson(o))
              ?.toList() ??
          <VoteAnswer>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Sapo": sapo,
        "VoteAnswers": voteAnswers,
      };
}
