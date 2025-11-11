import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/auth_bloc.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/widgets/popup/popup_gift_star.dart';

class StarLikeHeartWidget extends StatefulWidget {
  const StarLikeHeartWidget({Key key, this.article}) : super(key: key);

  final Article article;

  @override
  State<StarLikeHeartWidget> createState() => _StarLikeHeartWidgetState();
}

class _StarLikeHeartWidgetState extends State<StarLikeHeartWidget> {
  int numberStar = 0;
  int numberLike = 0;
  int numberHeart = 0;

  bool hasAcctionLike = false;
  bool hasAcctionHeart = false;
  int get getSumPoint => numberHeart + numberStar + numberLike;

  @override
  void initState() {
    numberStar = widget?.article?.getStart;
    numberLike = widget?.article?.getLikeCount;
    numberHeart = widget?.article?.getHeart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('Build StarLikeHeartWidget');

    return Container(
      padding: const EdgeInsets.all(paddingNews),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // All point
              Text(
                '$getSumPoint đã tặng',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(width: 20),

              // Star
              Container(
                width: 55,
                height: 35,
                decoration: BoxDecoration(
                  color: cardNewsBorderColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/icon_star.png'),
                      SizedBox(
                        width: 10,
                      ),
                      Text('$numberStar')
                    ],
                  ),
                  onTap: () => showOptionGiftStar(widget?.article),
                ),
              ),

              SizedBox(width: 10),

              // Like
              Container(
                width: 55,
                height: 35,
                decoration: BoxDecoration(
                  color: cardNewsBorderColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/icolikeauthor.png",
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Text('$numberLike')
                    ],
                  ),
                  onTap: () => _voteReaction(LIKE, widget?.article?.newsId),
                ),
              ),
              SizedBox(width: 10),

              // Heart
              Container(
                width: 55,
                height: 35,
                decoration: BoxDecoration(
                  color: cardNewsBorderColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/icoheartauthor.png",
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Text('$numberHeart')
                    ],
                  ),
                  onTap: () => _voteReaction(HEART, widget?.article?.newsId),
                ),
              ),
            ],
          ),

          // Button gift
          if (globals.isTTStar) ...[
            InkWell(
              child: Container(
                constraints: BoxConstraints.loose(Size(300, 40)),
                margin: EdgeInsets.only(top: paddingNews),
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR_TTS,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4.0,
                        top: 4.0,
                        bottom: 4.0,
                      ),
                      child: SizedBox(
                        width: 35,
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 209, 208, 208)
                              .withOpacity(0.5),
                          child: Image.asset('assets/icons/icon_star.png'),
                        ),
                      ),
                    ),

                    // Gift star
                    Expanded(
                      child: ColoredBox(
                        color: Colors.transparent,
                        child: Text(
                          'Bài viết hay? Tặng sao cho Tuổi Trẻ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => showOptionGiftStar(widget?.article),
            )
          ]
        ],
      ),
    );
  }

  void showOptionGiftStar(Article article) {
    // Call api gift star
    if (globals.isTTStar && (userBloc.userInfo.getStar > 0)) {
      AppHelpers.showDialogForWidget(
        context,
        widget: PopupOptionGiftStar(
          onGiftStar: (value) => _giftStar(widget?.article, value),
        ),
        barrierDismissible: true,
      );
    } else {
      if (!globals.isTTStar) {
        AppHelpers.showToast(text: 'Bạn cần đăng nhập Tuổi Trẻ Sao');
        return;
      }

      AppHelpers.showToast(text: 'Bạn không đủ số sao');
    }
  }

  void _giftStar(Article article, int number) {
    // Call api gift star
    setState(() {
      numberStar = numberStar + number;
    });

    _gift(article.getTtoUrl, article.newsId, number);

    // Update userBloc
    int star = userBloc.userInfo.getStar;
    star = star - number;
    userBloc.userInfo = userBloc.userInfo.copyWith(star);
  }

  Future<void> _gift(String articleLink, String newsId, int number) async {
    // Send otp
    final sendIsSuccess = await authBloc.giftStar(articleLink, number);

    // Check result
    if (sendIsSuccess) {
      _voteReaction(STAR, newsId, starcount: number.toString());
    }
  }

  Future<void> _voteReaction(int action, String newsId,
      {String starcount}) async {
    // Update number action
    switch (action) {
      case LIKE:
        if (hasAcctionLike == FLAG_OFF) {
          setState(() {
            numberLike = numberLike + 1;
            hasAcctionLike = !hasAcctionLike;
          });
          await authBloc.voteReaction(action, newsId);
        }
        break;

      case HEART:
        if (hasAcctionHeart == FLAG_OFF) {
          setState(() {
            numberHeart = numberHeart + 1;
            hasAcctionHeart = !hasAcctionHeart;
          });
          await authBloc.voteReaction(action, newsId);
        }
        break;

      case STAR:
        await authBloc.voteReaction(action, newsId, starcount: starcount);
        break;
    }

    // Call api
  }
}
