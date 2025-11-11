import 'dart:convert';

VoteAnswer voteAnswerFromJson(String str) =>
    VoteAnswer.fromJson(json.decode(str));

String voteAnswerToJson(VoteAnswer data) => json.encode(data.toJson());

class VoteAnswer {
  final int id;
  final int priority;
  final int status;
  final String value;
  final String voteId;
  final int voteRate;

  const VoteAnswer({
    this.id,
    this.priority,
    this.status,
    this.value,
    this.voteId,
    this.voteRate,
  });

  // Get
  String get getVoteRate => voteRate != null
      ? voteRate == 0.0
          ? '0'
          : voteRate.toString()
      : '0';

  // Set

  factory VoteAnswer.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    return VoteAnswer(
      id: json["Id"],
      priority: json["Priority"],
      status: json["Status"],
      value: json["Value"],
      voteId: json["VoteId"],
      voteRate: json["VoteRate"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Priority": priority,
        "Status": status,
        "Value": value,
        "VoteId": voteId,
        "VoteRate": voteRate,
      };
}
