import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_debounce_it/just_debounce_it.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/number.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/search/bloc/search_list_bloc.dart';
import 'package:news/pages/search/search_result_list_page.dart';
import 'package:news/pages/search/widgets/search_list.dart';
import 'package:news/pages/search/widgets/search_top_bar_title_widget.dart';
import 'package:news/widgets/app_loading.dart';

class SearchPage extends StatefulWidget {
  final String initialKeyword;

  // const SearchPage({Key key}) : super(key: key);
  const SearchPage({
    Key key,
    this.initialKeyword = '', // giá trị mặc định rỗng
  }) : super(key: key);


  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditController;
  FocusScopeNode focusNode = FocusScopeNode();
  SearchListBloc _blocSearch;

  @override
  void initState() {
    _textEditController = TextEditingController();
    _blocSearch = SearchListBloc();
    super.initState();

    if (widget.initialKeyword.isNotEmpty ?? false) {
      _textEditController.text = widget.initialKeyword;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _txtChanged(widget.initialKeyword);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    focusNode = FocusScope.of(context);
    printDebug('------------------- Build SearchPage --------------------');

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.keyboard_arrow_left),
          onTap: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: SearchTopBarTitleWidget(
          seachTxtChanged: _txtChanged,
          controller: _textEditController,
        ),
      ),
      body: BlocProvider<SearchListBloc>(
          create: (context) => _blocSearch,
          child: BlocBuilder<SearchListBloc, SearchListState>(
              builder: (BuildContext context, SearchListState state) {
            // Handle state is SearchListInitial
            if (state is SearchListInitial) {
              printDebug(
                  '-------------------state is SearchListInitial --------------------');
              return SearchResultListPage();
            }

            // Handle state is SearchListSuccess
            if (state is SearchListSuccess) {
              return state.articles.isNotEmpty
                  ? SearchList(
                      count: state.articles.length,
                      isFinish: state.articles.length < maxItemsPaging,
                      list: state.articles,
                    )
                  : Center(child: Text(KString.msgNoData));
            }

            // Handle state is SearchListFailure
            if (state is SearchListFailure) {
              return Center(child: Text(KString.msgNoData));
            }

            if (state is SearchListLoading) {
              return AppLoadingIndicator();
            }

            return AppLoadingIndicator();
          })),
    );
  }

  void _txtChanged(String keyWord) {
    Debounce.milliseconds(DEBOUNCER_DURATION, searchChanged, <String>[keyWord]);
  }

  Future<void> searchChanged(String keyWord) async {
    if (keyWord.trim().isNotEmpty) {
      _blocSearch.add(GetSearchListEvent(keyword: keyWord));

      // Hide key board
      Future.delayed(Duration(seconds: 1), () {
        AppHelpers.hideKeyboard(focusNode);
      });
    }
  }

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }
}
