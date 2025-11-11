import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/models/article_model.dart';
import 'package:news/pages/comment/comment_page.dart';

class IconButtonComment extends StatelessWidget {
  const IconButtonComment({
    Key key,
    @required this.article,
    this.color = Colors.black54,
  }) : super(key: key);

  final Article article;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final _iconComment = IconButton(
      icon: SvgPicture.asset(
        'assets/icons/icon_comment_detail.svg',
      ),
      onPressed: () => _moveToCommentPage(context, article),
    );

    return article.isShowCommentCount
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              _iconComment,
              Positioned(
                top: 10,
                right: 8.0,
                child: IgnorePointer(
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      article.commentCount.toString(),
                      style: KfontConstant.styleOfCommentCount
                          .copyWith(color: CL_WHITE),
                    ),
                    decoration: new BoxDecoration(
                      color: PRIMARY_COLOR.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )
            ],
          )
        : _iconComment;
  }

  void _moveToCommentPage(BuildContext context, Article article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TTOCommentPage(article: article),
        settings: RouteSettings(name: "/detail/comment_page", arguments: null),
        fullscreenDialog: true,
      ),
    );
  }
}
