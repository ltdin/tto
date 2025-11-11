import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/widgets/box/item_small_health_bylaw.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:news/widgets/header_box_sso.dart';

class IteamHealthBylaw extends StatelessWidget {
  const IteamHealthBylaw(
      {Key key, this.articles, this.topic, this.onTapButtonSendRequest})
      : super(key: key);

  final List<Article> articles;
  final String topic;
  final VoidCallback onTapButtonSendRequest;

  @override
  Widget build(BuildContext context) {
    printDebug('Build IteamHealthBylaw');

    return Container(
      margin: const EdgeInsets.only(top: paddingNews),
      child: Column(
        children: [
          // Header
          HeaderBoxSSO(
            inmageAsset: 'assets/icons/icon_legal_advice_tts.svg',
            topic: topic,
          ),

          // List
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, int index) {
              return ItemSmallHealthBylaw(
                article: this.articles[index],
                index: index,
              );
            },
          ),

          // Button send question for
          Padding(
            padding: const EdgeInsets.only(
              top: paddingNews32,
              left: paddingNews,
              right: paddingNews,
            ),
            child: ButtonElevatedCustom(
              width: double.maxFinite,
              height: 50,
              text: KString.strQuestionsExperts,
              color: buttonVoteColor,
              onTap: () => onTapButtonSendRequest != null
                  ? onTapButtonSendRequest.call()
                  : null,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: cardNewsBackgroundColor,
        border: Border.all(color: voteBackgroundColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
    );
  }
}
