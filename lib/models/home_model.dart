import 'dart:convert';

import 'package:news/models/article_model.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/box_highlight_video_model.dart';
import 'package:news/models/box_vote.dart';
import 'package:news/models/classifieds.dart';
import 'package:news/models/daily_newspaper.dart';
import 'package:news/models/news_by_zone.dart';
import 'package:news/models/play_list.dart';
import 'package:news/models/podcast_model.dart';
import 'package:news/models/special_article.dart';
import 'package:news/models/thread_model.dart';
import 'package:news/models/tto_news.dart';
import 'package:news/models/zone_data.dart';

HomeStruct homeFromJson(String str) {
  final jsonData = json.decode(str);
  return HomeStruct.fromJson(lookup<dynamic>(jsonData, ['data']));
}

List<ClassiFieds> classiFiedsFromJson(String str) {
  final jsonData = json.decode(str);
  return lookup<List>(jsonData, ['items'])
      ?.map<ClassiFieds>((o) => ClassiFieds.fromJson(o))
      ?.toList() ??
      <ClassiFieds>[];
}

List<DailyNewspaper> dailyNewspaperFromJson(String str) {
  final jsonData = json.decode(str);
  return lookup<List>(jsonData, ['data'])
      ?.map<DailyNewspaper>((o) => DailyNewspaper.fromJson(o))
      ?.toList() ??
      <DailyNewspaper>[];
}

List<TtoNews> ttoNewsFromJson(String str) {
  final jsonData = json.decode(str);
  return lookup<List>(jsonData, ['items'])
      ?.map<TtoNews>((o) => TtoNews.fromJson(o))
      ?.toList() ??
      <TtoNews>[];
}

class HomeStruct {
  final List<Article> boxFeatures;
  final List<Article> boxFeatured2;
  final List<Article> topHot1;
  final SpecialArticle topHotSpecial1;
  final List<Article> topHot2;
  final SpecialArticle topHotSpecial2;
  final List<Article> topHot3;
  final SpecialArticle topHotSpecial3;
  final List<Article> topHot4;
  final PlayList playlist;
  final List<Article> topHot5;
  final BoxVote boxVote;
  final List<Article> topHot6;
  final List<Article> boxNicePicture;
  final List<Article> boxMegastoryHot;
  final List<Article> boxInfographic;
  final List<Article> boxTopView;
  final List<Article> boxTopStar;
  final BoxHighlightVideoModel boxHighlightVideo;
  final PodcastModel boxPodcast;
  final List<ZoneData> boxNewsSubZone;
  final List<NewsByZone> newsByZone;
  final List<ClassiFieds> classiFieds;
  final List<Article> boxTVPL;
  final List<Article> boxHCSK;
  final List<TtoNews> ttNews;
  final List<ThreadModel> threads;


  const HomeStruct({
    this.boxFeatures,
    this.boxFeatured2,
    this.topHot1,
    this.topHotSpecial1,
    this.topHot2,
    this.topHotSpecial2,
    this.topHot3,
    this.topHotSpecial3,
    this.topHot4,
    this.playlist,
    this.topHot5,
    this.boxVote,
    this.topHot6,
    this.boxNicePicture,
    this.boxMegastoryHot,
    this.boxInfographic,
    this.boxTopView,
    this.boxTopStar,
    this.boxHighlightVideo,
    this.boxPodcast,
    this.boxNewsSubZone,
    this.newsByZone,
    this.classiFieds,
    this.boxTVPL,
    this.boxHCSK,
    this.ttNews,
    this.threads
  });

  factory HomeStruct.fromJson(Map<String, dynamic> json,
      {bool fromCache = false}) {
    if (json == null || (json?.isEmpty ?? false)) {
      return HomeStruct();
    }

    return HomeStruct(
      boxFeatures: lookup<List>(json, ['BoxFeatured'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxFeatured2: lookup<List>(json, ['BoxFeatured2'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      topHot1: lookup<List>(json, ['TopHot1'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      topHotSpecial1:
      SpecialArticle.fromJson(lookup<dynamic>(json, ['TopHotSpecial1', 0])),
      topHot2: lookup<List>(json, ['TopHot2'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      topHotSpecial2:
      SpecialArticle.fromJson(lookup<dynamic>(json, ['TopHotSpecial2', 0])),
      topHot3: lookup<List>(json, ['TopHot3'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      topHotSpecial3:
      SpecialArticle.fromJson(lookup<dynamic>(json, ['TopHotSpecial3', 0])),
      topHot4: lookup<List>(json, ['TopHot4'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      playlist: PlayList.fromJson(lookup<dynamic>(json, ['Playlist'])),
      topHot5: lookup<List>(json, ['TopHot5'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxVote: BoxVote.fromJson(lookup<dynamic>(json, ['BoxVote'])),
      topHot6: lookup<List>(json, ['TopHot6'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxNicePicture: lookup<List>(json, ['BoxNicePicture'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxMegastoryHot: lookup<List>(json, ['BoxMegastoryHot'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxInfographic: lookup<List>(json, ['BoxInfographic'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxTopView: lookup<List>(json, ['BoxTopView'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxTopStar: lookup<List>(json, ['BoxTopStar'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxHighlightVideo: BoxHighlightVideoModel.fromJson(
        lookup<dynamic>(json, ['BoxHighlightVideo']),
      ),
      boxPodcast:
      PodcastModel.fromJson(lookup<dynamic>(json, ['BoxPodcast', 0])),
      boxNewsSubZone: lookup<List>(json, ['BoxNewsSubZone'])
          ?.map<ZoneData>((o) => ZoneData.fromJson(o))
          ?.toList() ??
          <ZoneData>[],
      newsByZone: lookup<List>(json, ['NewsByZone'])
          ?.map<NewsByZone>((o) => NewsByZone.fromJson(o))
          ?.toList() ??
          <NewsByZone>[],
      boxTVPL: lookup<List>(json, ['BoxTVPL', 'Data'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      boxHCSK: lookup<List>(json, ['BoxHCSK', 'Data'])
          ?.map<Article>((o) => Article.fromJson(o))
          ?.toList() ??
          <Article>[],
      classiFieds: fromCache
          ? lookup<List>(json, ['ClassiFieds'])
          ?.map<ClassiFieds>((o) => ClassiFieds.fromJson(o))
          ?.toList() ??
          <ClassiFieds>[]
          : <ClassiFieds>[],
      ttNews: fromCache
          ? lookup<List>(json, ['TtoNews'])
          ?.map<TtoNews>((o) => TtoNews.fromJson(o))
          ?.toList() ??
          <TtoNews>[]
          : <TtoNews>[],
      threads: lookup<List>(json, ['Thread'])?.map<ThreadModel>((e) {
        return ThreadModel.fromJson(e['Thread']);

      })?.toList() ?? <ThreadModel>[],
    );
  }



  HomeStruct copyWith({
    List<ClassiFieds> classiFieds,
    List<TtoNews> ttNews,
  }) {
    return HomeStruct(
      boxFeatures: this.boxFeatures,
      boxFeatured2: this.boxFeatured2,
      topHot1: this.topHot1,
      topHotSpecial1: this.topHotSpecial1,
      topHot2: this.topHot2,
      topHotSpecial2: this.topHotSpecial2,
      topHot3: this.topHot3,
      topHotSpecial3: this.topHotSpecial3,
      topHot4: this.topHot4,
      playlist: this.playlist,
      topHot5: this.topHot5,
      boxVote: this.boxVote,
      topHot6: this.topHot6,
      boxNicePicture: this.boxNicePicture,
      boxMegastoryHot: this.boxMegastoryHot,
      boxInfographic: this.boxInfographic,
      boxTopView: this.boxTopView,
      boxTopStar: this.boxTopStar,
      boxHighlightVideo: this.boxHighlightVideo,
      boxPodcast: this.boxPodcast,
      boxNewsSubZone: this.boxNewsSubZone,
      newsByZone: this.newsByZone,
      boxTVPL: this.boxTVPL,
      boxHCSK: this.boxHCSK,
      classiFieds: classiFieds ?? this.classiFieds,
      ttNews: ttNews ?? this.ttNews,
    );
  }

  Map<String, dynamic> toJson() => {
    "BoxFeatured": boxFeatures,
    "BoxFeatured2": boxFeatured2,
    "TopHot1": topHot1,
    "TopHotSpecial1": topHotSpecial1,
    "TopHot2": topHot2,
    "TopHotSpecial2": topHotSpecial2,
    "TopHot3": topHot3,
    "TopHotSpecial3": topHotSpecial3,
    "TopHot4": topHot4,
    "Playlist": playlist,
    "TopHot5": topHot5,
    "BoxVote": boxVote,
    "TopHot6": topHot6,
    "BoxNicePicture": boxNicePicture,
    "BoxMegastoryHot": boxMegastoryHot,
    "BoxInfographic": boxInfographic,
    "BoxTopView": boxTopView,
    "BoxTopStar": boxTopStar,
    "BoxHighlightVideo": boxHighlightVideo,
    "VoxPodcast": boxPodcast,
    "BoxNewsSubZone": boxNewsSubZone,
    "NewsByZone": newsByZone,
    "BoxTVPL": boxTVPL,
    "BoxHCSK": boxHCSK,
    "ClassiFieds": classiFieds,
    "TtoNews": ttNews,
  };
}
