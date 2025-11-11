import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/bool.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/box_vote.dart';

class BoxVoteWidget extends StatefulWidget {
  const BoxVoteWidget({Key key, this.boxVote}) : super(key: key);

  final BoxVote boxVote;

  @override
  State<BoxVoteWidget> createState() => _BoxVoteWidgetState();
}

class _BoxVoteWidgetState extends State<BoxVoteWidget>
    with AutomaticKeepAliveClientMixin {
  String _character = "";
  bool hasVote = false;
  bool isShowResult = false;
  BoxVote _boxVote;

  @override
  void initState() {
    _boxVote = widget.boxVote;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    printDebug('Build BoxVoteWidget');

    return Container(
      padding: const EdgeInsets.all(paddingNews),
      margin: const EdgeInsets.symmetric(
        vertical: paddingNews * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            KString.strProbe,
            style: KfontConstant.styleOfTitleLargeType2,
          ),

          Padding(
            padding: const EdgeInsets.only(top: paddingDivider),
            child: Divider(color: dividerColor),
          ),

          // Title
          Text(
            widget.boxVote.getTitle,
            style: KfontConstant.styleOfSapoVoteBox,
          ),

          //
          Padding(
            padding: const EdgeInsets.only(
              top: paddingNews,
              bottom: paddingNews / 2,
            ),
            child: Column(
              children: List.generate(
                _boxVote.voteAnswers.length,
                (i) => Container(
                  margin: const EdgeInsets.only(bottom: paddingNews / 2),
                  child: RadioListTile<String>(
                    title: Text(
                      _boxVote.voteAnswers[i].value,
                      style: KfontConstant.styleOfContentVote,
                    ),
                    subtitle: hasVote || isShowResult
                        ? Text(_boxVote.voteAnswers[i].getVoteRate)
                        : null,
                    value: _boxVote.voteAnswers[i].value,
                    groupValue: _character,
                    onChanged: (String value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                  decoration: BoxDecoration(
                    color: CL_WHITE,
                    borderRadius: BorderRadius.circular(radius4),
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              // Button result
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    style: KfontConstant.styleButtonVote.copyWith(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          cardNewsBackgroundColor),
                    ),
                    child: Text(
                      KString.strResult,
                      style: TextStyle(color: textVoteColor),
                    ),
                    onPressed: () => _onClickResultButton(),
                  ),
                ),
              ),

              // Button vote
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.only(left: paddingNews),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: KfontConstant.styleButtonVote.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(buttonVoteColor),
                      ),
                      child: const Text(KString.strVote),
                      onPressed: () => _onClickVoteButton(),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: voteBackgroundColor,
        border: Border.all(color: cardNewsBorderColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
    );
  }

  void _onClickResultButton() {
    setState(() {
      isShowResult = FLAG_ON;
    });
  }

  void _onClickVoteButton() {
    if (_character.isNotEmpty) {
      AppHelpers.showToast(
        text: KString.strThanksVoted,
        isError: false,
      );
      setState(() {
        hasVote = FLAG_ON;
      });
    } else {
      AppHelpers.showToast(
        text: KString.strPleaseChoose,
        isError: true,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
