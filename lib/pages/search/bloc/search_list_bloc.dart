import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/models/article_model.dart';

part 'search_list_event.dart';
part 'search_list_state.dart';

class SearchListBloc extends Bloc<SearchListEvent, SearchListState> {
  SearchListBloc() : super(SearchListInitial());

  @override
  Stream<SearchListState> mapEventToState(SearchListEvent event) async* {
    final currentState = state;

    if (event is GetSearchListEvent) {
      try {
        yield SearchListLoading();

        final articles = await bloc.fetchSearchList(keyword: event.keyword);

        // Check list video has data
        if (articles?.isNotEmpty ?? false) {
          yield SearchListSuccess(articles: articles);
        } else {
          yield SearchListFailure();
        }
      } catch (e) {
        if (currentState is SearchListSuccess) {
          return;
        }

        yield SearchListFailure();
      }
    }
  }
}
