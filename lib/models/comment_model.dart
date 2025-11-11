import 'package:news/api/apis.dart';
import 'package:news/base/app_helpers.dart';

class TTOCommentJSONModel {
  final String id;
  final String newsId;
  final String contentComment;
  final String senderName;
  final String senderAvatar;
  final String senderEmail;
  final String senderPhone;
  final String createdDate;
  final int like;
  final List<TTOCommentJSONModel> childComment;

  String get senderAvatarAbsoluteURL => processURL(senderAvatar);

  String processURL(String url) {
    if (AppHelpers.safeString(url).length == 0) {
      return "";
    }

    return AppHelpers.safeString(url).startsWith("http")
        ? AppHelpers.safeString(url)
        : Apis.basePhotoUrl + AppHelpers.safeString(url);
  }

  TTOCommentJSONModel(
      {this.id,
      this.newsId,
      this.contentComment,
      this.senderName,
      this.senderAvatar,
      this.senderEmail,
      this.senderPhone,
      this.createdDate,
      this.like,
      this.childComment});

  factory TTOCommentJSONModel.fromJson(Map<String, dynamic> json) {
    return TTOCommentJSONModel(
      id: lookup<String>(json, ['Id']) ?? '',
      newsId: lookup<String>(json, ['NewsId']) ?? '',
      contentComment: lookup<String>(json, ['ContentComment']) ?? '',
      senderName: lookup<String>(json, ['SenderName']) ?? '',
      senderAvatar: lookup<String>(json, ['SenderAvatar']) ?? '',
      senderEmail: lookup<String>(json, ['SenderEmail']) ?? '',
      senderPhone: lookup<String>(json, ['SenderPhone']) ?? '',
      createdDate: lookup<String>(json, ['CreatedDate']) ?? '',
      like: lookup<int>(json, ['Like']),
      childComment: lookup<List>(json, ['ChildComment'])
              ?.map<TTOCommentJSONModel>((o) => TTOCommentJSONModel.fromJson(o))
              ?.toList() ??
          <TTOCommentJSONModel>[],
    );
  }

  bool get isVerified => AppHelpers.safeString(id).length != 0;
}

class TTOInteractiveCommentParams {
  final String newsId;
  final int newsType;
  final String commentId;
  final int action;

  TTOInteractiveCommentParams(
      {this.newsId = "",
      this.newsType = 1,
      this.commentId = "",
      this.action = 0});

  Map<String, String> get mapping => {
        "news_id": newsId,
        "news_type": newsType.toString(),
        "comment_id": commentId,
        "action": action.toString()
      };
}

class TTOAddCommentParams {
  String userId;
  String parentId;
  String title;
  String content;
  String objectId;
  String objectTitle;
  String objectUrl;
  int objectType;
  String senderEmail;
  String senderFullname;
  String senderAvatar;
  String senderAddress;
  String senderPhone;
  String createdBy;
  String zoneId;
  String emotion;

  Map<String, String> get mapping {
    Map<String, String> bodyData = Map<String, String>();
    if (this.userId != null && this.userId.length != 0) {
      bodyData["user_id"] = this.userId;
    }
    if (this.parentId != null && this.parentId.length != 0) {
      bodyData["parent_id"] = this.parentId;
    }
    if (this.title != null && this.title.length != 0) {
      bodyData["title"] = this.title;
    }
    if (this.content != null && this.content.length != 0) {
      bodyData["content"] = this.content;
    }
    if (this.objectId != null && this.objectId.length != 0) {
      bodyData["object_id"] = this.objectId;
    }
    if (this.objectTitle != null && this.objectTitle.length != 0) {
      bodyData["object_title"] = this.objectTitle;
    }
    if (this.objectUrl != null && this.objectUrl.length != 0) {
      bodyData["object_url"] = this.objectUrl;
    }
    bodyData["object_type"] = this.objectType.toString();
    if (this.senderEmail != null && this.senderEmail.length != 0) {
      bodyData["sender_email"] = this.senderEmail;
    }
    if (this.senderFullname != null && this.senderFullname.length != 0) {
      bodyData["sender_fullname"] = this.senderFullname;
    }
    if (this.senderAvatar != null && this.senderAvatar.length != 0) {
      bodyData["sender_avatar"] = this.senderAvatar;
    }
    if (this.senderAddress != null && this.senderAddress.length != 0) {
      bodyData["sender_address"] = this.senderAddress;
    }
    if (this.senderPhone != null && this.senderPhone.length != 0) {
      bodyData["sender_phone"] = this.senderPhone;
    }
    if (this.createdBy != null && this.createdBy.length != 0) {
      bodyData["created_by"] = this.createdBy;
    }
    if (this.zoneId != null && this.zoneId.length != 0) {
      bodyData["zone_id"] = this.zoneId;
    }
    if (this.emotion != null && this.emotion.length != 0) {
      bodyData["emotion"] = this.emotion;
    }
    return bodyData;
  }

  TTOAddCommentParams(
      {this.userId,
      this.parentId,
      this.title,
      this.content,
      this.objectId,
      this.objectTitle,
      this.objectUrl,
      this.objectType = 1,
      this.senderEmail,
      this.senderFullname,
      this.senderAvatar,
      this.senderAddress,
      this.senderPhone,
      this.createdBy,
      this.zoneId,
      this.emotion});

  factory TTOAddCommentParams.fromJson(Map<String, dynamic> json) {
    return TTOAddCommentParams(
      userId: lookup<String>(json, ['user_id']) ?? '',
      parentId: lookup<String>(json, ['parent_id']) ?? '',
      title: lookup<String>(json, ['title']) ?? '',
      content: lookup<String>(json, ['content']) ?? '',
      objectId: lookup<String>(json, ['object_id']) ?? '',
      objectTitle: lookup<String>(json, ['object_title']) ?? '',
      objectUrl: lookup<String>(json, ['object_url']) ?? '',
      objectType: lookup<int>(json, ['object_type']) ?? 1,
      senderEmail: lookup<String>(json, ['sender_email']) ?? '',
      senderFullname: lookup<String>(json, ['sender_fullname']) ?? '',
      senderAvatar: lookup<String>(json, ['sender_avatar']) ?? '',
      senderAddress: lookup<String>(json, ['sender_address']) ?? '',
      senderPhone: lookup<String>(json, ['sender_phone']) ?? '',
      createdBy: lookup<String>(json, ['created_by']) ?? '',
      zoneId: lookup<String>(json, ['zone_id']) ?? '',
      emotion: lookup<String>(json, ['emotion']) ?? '',
    );
  }
}
