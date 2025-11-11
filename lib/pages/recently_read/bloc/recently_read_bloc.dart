import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_sqflite.dart';
import 'package:news/models/article_model.dart';

part 'recently_read_event.dart';
part 'recently_read_state.dart';

class RecentlyReadBloc extends Bloc<RecentlyReadEvent, RecentlyReadState> {
  RecentlyReadBloc() : super(RecentlyReadInitial());

  @override
  Stream<RecentlyReadState> mapEventToState(RecentlyReadEvent event) async* {
    if (event is GetRecentlyReadEvent) {
      yield RecentlyReadInitial();

      // Get data from database
      final articles = await AppSqflite.instance.queryAllNews();

      // check list video has data
      if (articles?.isNotEmpty ?? false) {
        yield ViewedNewsSuccess(articles: articles);
      } else {
        yield RecentlyReadNodata();
      }
    }
  }
}
