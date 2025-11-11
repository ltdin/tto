import 'package:news/base/app_helpers.dart';
import 'package:news/constant/string.dart';

class BodyRow {
  const BodyRow({
    this.type,
    this.value,
    this.caption,
    this.img,
    this.index,
    this.filename,
    this.avatarVideo,
    this.wrapNotes,
  });

  final String type;
  final String value;
  final String caption;
  final Img img;
  final int index;
  final String filename;
  final String avatarVideo;
  final List<BodyRow> wrapNotes;

  // Get
  bool get isShowCaption =>
      caption.replaceAll(' ', '').isNotEmpty && (caption?.isNotEmpty ?? false);

  factory BodyRow.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return null;
    }

    // Type for check wrapNotes
    final type = lookup<String>(json, ['type']) ?? '';
    final isWrapNote = type == KString.STR_BODY_ROW_TYPE_WRAPNOTE;

    return BodyRow(
      type: type,
      value: !isWrapNote ? lookup<String>(json, ['value']) ?? '' : '',
      caption: lookup<String>(json, ['caption']) ?? '',
      img: Img.fromJson(json["img"]),
      index: lookup<int>(json, ['index'] ?? 0),
      filename: lookup<String>(json, ['filename']) ?? '',
      avatarVideo: lookup<String>(json, ['avatar']) ?? '',
      wrapNotes: isWrapNote
          ? lookup<List>(json, ['value'])
                  ?.map<BodyRow>((o) => BodyRow.fromJson(o))
                  ?.toList() ??
              []
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
        "caption": caption,
        "img": img.toJson(),
        "index": index,
        "filename": filename,
        "avatar": avatarVideo,
      };
}

class Img {
  const Img({
    this.src,
    this.originalImg,
    this.size,
  });

  final String src;
  final String originalImg;
  final Size size;

  factory Img.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return Img(size: Size());
    }
    return Img(
      src: lookup<String>(json, ['src']) ?? '',
      originalImg: lookup<String>(json, ['original_img']) ?? '',
      size: Size.fromJson(json["size"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "src": src,
        "original_img": originalImg,
        "size": size.toJson(),
      };
}

class Size {
  const Size({this.width = 0, this.height = 0});

  final int width;
  final int height;

  factory Size.fromJson(Map<String, dynamic> json) {
    if (json == null || (json?.isEmpty ?? false)) {
      return Size(height: 0, width: 0);
    }

    return Size(
      width: lookup<int>(json, ['width']) ?? 0,
      height: lookup<int>(json, ['height']) ?? 0,
    );
  }

  bool get checkSize => withNotNull && heightNotNull;
  bool get withNotNull => width != 0;
  bool get heightNotNull => height != 0;

  double get aspectRatio {
    double aspectRatio = 1;

    try {
      if (checkSize) {
        aspectRatio = (width / height);
      }
    } catch (e) {
      printDebug("catch: ${e.toString()}");
    }
    return aspectRatio;
  }

  Map<String, dynamic> toJson() => {"width": width, "height": height};
}
