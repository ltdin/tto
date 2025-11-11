import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';

import 'color.dart';

class KfontConstant {
  static const String SFDisplayRegular = "SFDisplayRegular";
  static const String SFProDisplayBold = "SFProDisplayBold";
  static const String SFProDisplayMedium = "SFProDisplayMedium";
  static const String Roboto = "Roboto";
  static const String RobotoCondenseRegular = "RobotoRegular";
  static const String RobotoCondenseBold = "RobotoCondensedBold";

  static const Color titleFontColor = Color(0xFF222222);
  static const Color sapoFontColor = Color(0xFF565656);
  static const Color recommendFontColor = Color(0xFF333333);
  static const Color contentVoteColor = Color(0xFF656565);
  static const double lineHeight12 = 1.2;
  static const double lineHeight20 = 1.2;
  static const double lineHeight24 = 1.3;
  static const double lineHeight26 = 1.5;
  static const double lineHeight28 = 1.7;

  // Tabbar style
  static const TextStyle activeTabLabelStyle = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.0,
  );
  static const TextStyle tabLabelStyle = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.0,
  );
  static const TextStyle tabLabelAuthStyle = TextStyle(
      fontFamily: Roboto, fontSize: 18.0, fontWeight: FontWeight.bold);
  static const TextStyle defaultStyle = TextStyle(
    fontFamily: Roboto,
    fontSize: 16.0,
    color: recommendFontColor,
  );

  // Home page
  static final TextStyle styleOfTitleLargeType1 = TextStyle(
    fontSize: fontSize24,
    height: lineHeight12,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
  );
  static final TextStyle styleOfSapoLargeType1 = TextStyle(
    fontSize: fontSize16,
    height: lineHeight26,
    color: sapoFontColor,
    fontFamily: Roboto,
    decoration: TextDecoration.none,
  );
  static final TextStyle styleOfTitleSmallType1 = TextStyle(
    fontSize: fontSize18,
    height: lineHeight26,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
  );
  static final TextStyle styleOfTopicLargeType4 = TextStyle(
    fontSize: fontSize16,
    height: lineHeight24,
    color: topicLargeType4Color,
    fontFamily: Roboto,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );
  static final TextStyle styleOfTitleSmallTime = TextStyle(
    fontSize: fontSize14,
    height: lineHeight20,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
  );
  static final TextStyle styleOfRecommend = TextStyle(
    fontSize: fontSize21,
    color: recommendFontColor,
    fontFamily: Roboto,
  );
  static final ButtonStyle styleButtonVote = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 16,
      fontFamily: Roboto,
    ),
  );
  static final TextStyle styleOfContentVote = TextStyle(
    fontSize: fontSize15,
    color: contentVoteColor,
    fontFamily: Roboto,
    height: lineHeight20,
  );
  static final TextStyle styleOfTitleRecommend = TextStyle(
    fontSize: fontSize20,
    height: lineHeight24,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
  );

  // Detail
  static final TextStyle styleOfCommentCount = TextStyle(
    fontSize: fontSize12,
    color: PRIMARY_COLOR,
    fontFamily: Roboto,
  );
  static final TextStyle styleOfContent = TextStyle(
    fontSize: fontSize20,
    height: lineHeight24,
    color: titleFontColor,
    fontFamily: Roboto,
  );
  static final TextStyle styleOfTitleLargeDetail = TextStyle(
    fontSize: fontSize24,
    height: lineHeight26,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle styleOfSapoDetail = TextStyle(
    fontSize: fontSize18,
    height: lineHeight24,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w700,
  );

  // Login
  static final TextStyle styleOfTitleUserInfo = TextStyle(
    fontSize: fontSize18,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle styleOfContentUserInfo = TextStyle(
    fontSize: fontSize18,
    color: recommendFontColor,
    fontFamily: Roboto,
  );
  static final TextStyle styleOfContentRrgister = TextStyle(
    fontSize: fontSize16,
    color: sapoFontColor,
    fontFamily: Roboto,
  );

  // Get font
  static TextStyle get styleOfSapoLargeType2 => styleOfSapoLargeType1;
  static TextStyle get styleOfSapoLargeType3 => styleOfSapoLargeType1;
  static TextStyle get styleOfTitleLargeType2 => styleOfTitleSmallType1;
  static TextStyle get styleOfTitleLargeType3 => styleOfTitleSmallType1;
  static TextStyle get styleOfTitleLargeType4 => styleOfTitleSmallType1;
  static TextStyle get styleOfTitleSmallType2 => styleOfTitleSmallType1;
  static TextStyle get styleOfTitleLargePicture =>
      styleOfTitleSmallType1.copyWith(color: CL_WHITE);
  static TextStyle get styleOfTitleSmallTimeGetTime =>
      styleOfTitleSmallTime.copyWith(
        color: topicLargeType4Color,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get styleOfTimeInRecommend => styleOfRecommend.copyWith(
        fontSize: fontSize14,
      );
  static TextStyle get styleOfSapoVoteBox =>
      styleOfSapoLargeType1.copyWith(fontWeight: FontWeight.w400);
  static TextStyle get styleOfTitleBoxHighlightVideo => styleOfRecommend;
  static TextStyle get styleOfListCategory =>
      styleOfContentVote.copyWith(color: sapoFontColor);
  static TextStyle get styleOfTitlePodcast => styleOfTitleRecommend;
  static TextStyle get styleOfSeeMoreSubZone =>
      styleOfContentVote.copyWith(color: titleFontColor);
  static TextStyle get styleOfSelectedLabelTabBar =>
      styleOfTitleRecommend.copyWith(color: titleFontColor);
  static TextStyle get styleOfUnselectedLabelTabBar =>
      styleOfTitleRecommend.copyWith(color: textVoteColor);
  static TextStyle get styleOfBoxTitleSSo =>
      styleOfContentVote.copyWith(color: titleFontColor);

  static final TextStyle styleOfSmallTitle = TextStyle(
    fontSize: fontSize17,
    height: lineHeight26,
    color: titleFontColor,
    fontFamily: Roboto,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  static final TextStyle fLoorTitleStyle = TextStyle(
    fontSize: 16.0,
    color: floorTitleColor,
  );
  static final TextStyle pinweiCorverSubtitleStyle = TextStyle(
    fontSize: 13.0,
    color: pinweicorverSubtitleColor,
  );

  // Detail
  static final TextStyle cartBottomTotalPriceStyle =
      TextStyle(fontSize: 18, color: priceColor);
  static final TextStyle searchResultItemCommentCountStyle =
      TextStyle(fontSize: 12, color: Color(0xFF999999));
  static final TextStyle searchBarTextBoxHome =
      TextStyle(fontSize: 14, color: Color(0xFF909090));
  static final TextStyle categoryPageTitleNavigationStyle = TextStyle(
      fontFamily: RobotoCondenseBold, color: Colors.white, fontSize: 32);
  static final TextStyle searchHomeTitleNavigationStyle = TextStyle(
    fontFamily: RobotoCondenseBold,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 30,
  );
  static final TextStyle LoginPageTitleNavigationStyle =
      TextStyle(fontFamily: RobotoCondenseBold, fontSize: 23);
  static final TextStyle RobotoRegularWhite12 = TextStyle(
    fontFamily: RobotoCondenseRegular,
    fontSize: 12,
    color: Colors.white,
  );
  static final TextStyle SFDisplayRegular14 =
      TextStyle(fontFamily: RobotoCondenseRegular, fontSize: 14);
  static final TextStyle SFDisplayRegularWhite20 = TextStyle(
      fontFamily: RobotoCondenseRegular, fontSize: 20, color: Colors.white);
  static final TextStyle SFProDisplayBoldWhite24 = TextStyle(
      fontFamily: RobotoCondenseBold, fontSize: 24, color: Colors.white);
  static final TextStyle HomeBigThumbTitleTextStyle =
      TextStyle(fontFamily: RobotoCondenseBold, fontSize: 24);
  static final TextStyle SFProDisplayBoldBlue14 = TextStyle(
      fontFamily: RobotoCondenseBold, fontSize: 14, color: Colors.blue);
}
