import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/models/list_newspaper.dart';
import 'package:news/models/newspaper.dart';

part 'newspaper_event.dart';
part 'newspaper_state.dart';

class NewspaperBloc extends Bloc<NewspaperEvent, NewspaperState> {
  NewspaperBloc() : super(NewspaperInitial());

  @override
  Stream<NewspaperState> mapEventToState(NewspaperEvent event) async* {
    if (event is GetDetailNewspaperEvent) {
      final _listPageOfNewsPaper =
          await bloc.getListPageOfNewsPaper(event.publishedAt, event.appId);

      // Check empty
      if (_listPageOfNewsPaper?.isNotEmpty ?? false) {
        yield ShowDetailNewspaperState(newspaper: _listPageOfNewsPaper);
      } else {
        yield GetDetailNewspaperFailure();
      }

      return;
    }

    // Handle ShowInstructPageEvent
    if (event is ShowInstructPageEvent) {
      yield ShowAnimationLoading();
      await Future.delayed(Duration(milliseconds: 500));
      yield ShowInstructPageState();
      return;
    }

    // Handle ShowInstructPageEvent
    if (event is ShowListNewspapersEvent) {
      yield ShowAnimationLoading();
      await Future.delayed(Duration(milliseconds: 500));

      // Get list newspapers from api
      final newsPaperModel =
          await bloc.getListNewsPaper(event.appId, event.page);

      // Call update state
      yield ShowListNewspapersState(listNewspaperModel: newsPaperModel);
      return;
    }

    // Handle GetDetailLastestNewspaperEvent
    if (event is GetDetailLastestNewspaperEvent) {
      yield ShowAnimationLoading();

      // Get the first item of list newspapers from api
      final newsPaperModel = await bloc.getFirstItemListNewsPaper(event.appId);

      // Check emplty list
      if (newsPaperModel.list.isEmpty) {
        yield GetDetailNewspaperFailure();
        return;
      }

      // Get first item
      final firstItem = newsPaperModel.list.first;

      // Get detail news
      final listPageOfNewsPaper = await bloc.getListPageOfNewsPaper(
        firstItem.getDayMiliSeconds,
        event.appId,
      );

      // Check empty
      if (listPageOfNewsPaper?.isNotEmpty ?? false) {
        yield ShowDetailNewspaperState(newspaper: listPageOfNewsPaper);
        return;
      } else {
        yield GetDetailNewspaperFailure();
        return;
      }
    }
  }
}
