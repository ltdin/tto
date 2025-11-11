import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/box/item_health_bylaw.dart';
import 'package:news/widgets/popup/send_question.dart';

class BoxHealthBylawWidget extends StatefulWidget {
  const BoxHealthBylawWidget({Key key, this.articles}) : super(key: key);

  final List<List<Article>> articles;

  @override
  State<BoxHealthBylawWidget> createState() => _BoxHealthBylawWidgetState();
}

class _BoxHealthBylawWidgetState extends State<BoxHealthBylawWidget> {
  List<Widget> imageList;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    imageList = [
      IteamHealthBylaw(
        articles: widget.articles[0],
        topic: 'Hỏi chuyện sức khỏe',
        onTapButtonSendRequest: _onTapButtonSendRequest,
      ),
      IteamHealthBylaw(
        articles: widget.articles[1],
        topic: KString.strLegalAdvice,
        onTapButtonSendRequest: _onTapButtonSendRequest,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printDebug('Build BoxHealthBylawWidget ');

    return Column(
      children: [
        // Slider
        CarouselSlider(
          items: imageList.map((item) => item).toList(),
          carouselController: carouselController,
          options: CarouselOptions(
            height: 430,
            scrollPhysics: const BouncingScrollPhysics(),
            autoPlay: false,
            aspectRatio: 2,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        // Dotted
        Padding(
          padding: const EdgeInsets.symmetric(vertical: paddingNews),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              final iscurrentIndex = currentIndex == entry.key;

              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: iscurrentIndex ? 50 : 10.0,
                  height: paddingNewsTitle,
                  margin:
                      const EdgeInsets.symmetric(horizontal: paddingNewsTitle),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: iscurrentIndex ? buttonVoteColor : dotSliderColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _onTapButtonSendRequest() {
    if (currentIndex == 0) {
      AppHelpers.showDialogForWidget(
        context,
        widget: Container(
          margin: EdgeInsets.symmetric(
            horizontal: paddingNews,
            vertical: paddingNews32,
          ),
          child: SendQuestion(
            typeQuestion: TypeQuestion.HCSK,
            topic: KString.strAskAboutHealth,
            assetTopic: 'assets/icons/icon_legal_advice_tts.svg',
          ),
        ),
        barrierDismissible: true,
      );
    } else {
      AppHelpers.showDialogForWidget(
        context,
        widget: Container(
          margin: EdgeInsets.symmetric(
            horizontal: paddingNews,
            vertical: paddingNews32,
          ),
          child: SendQuestion(
            typeQuestion: TypeQuestion.TVPL,
            topic: KString.strLegalAdvice,
            assetTopic: 'assets/icons/icon_law_tts.svg',
          ),
        ),
        barrierDismissible: true,
      );
    }
  }
}
