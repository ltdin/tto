import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/pages/comment/bloc/comment_bloc.dart';
import 'package:news/pages/comment/widgets/comment_widget.dart';
import 'package:news/pages/comment/widgets/comment_load_more_widget.dart';
import 'package:news/pages/comment/viewmodels/comment_page_view_model.dart';
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';
import 'package:news/pages/comment/settings/comment_page_settings_ui.dart';
import 'package:news/widgets/app_loading.dart';

class CommentListWidget extends StatefulWidget {
  const CommentListWidget({
    Key key,
    this.viewModel,
    this.settingsUI,
    this.article,
  }) : super(key: key);

  final TTOCommentPageViewModel viewModel;
  final TTOCommentPageSettingsUI settingsUI;
  final Article article;

  @override
  _CommentListWidgetState createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  final List<TTOCommentItemViewModel> _commentViewModels = [];

  @override
  void initState() {
    widget.viewModel.onCommentsChanged = () {
      setState(() {});
    };
    super.initState();
  }

  List<TTOCommentItemViewModel> get filteredCommentViewModels {
    return _commentViewModels.where((viewModel) {
      return viewModel.isHidden == false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (BuildContext context, CommentState state) {
        if (state is CommentListSuccess) {
          // Clear data
          _commentViewModels.clear();

          // ForEach ?
          final int n = 2;
          state.listTtoComment.forEach(
            (TTOCommentJSONModel model) {
              final TTOCommentViewModel viewModel =
                  TTOCommentViewModel(commentModel: model);
              _commentViewModels.add(viewModel);

              int i = 0;
              List<TTOCommentViewModel> hiddenSubViewModels = [];

              model.childComment.forEach((TTOCommentJSONModel subModel) {
                TTOCommentViewModel subViewModel = TTOCommentViewModel(
                  commentModel: subModel,
                  parentCommentViewModel: viewModel,
                );

                if (i < n) {
                  _commentViewModels.add(subViewModel);
                  ++i;
                } else {
                  hiddenSubViewModels.add(subViewModel);
                }
              });

              if (hiddenSubViewModels.length != 0) {
                TTOCommentLoadMoreViewModel loadMoreViewModel =
                    TTOCommentLoadMoreViewModel()
                      ..commentViewModels.addAll(hiddenSubViewModels);
                _commentViewModels.add(loadMoreViewModel);
              }
            },
          );

          // Return not data if length = 0
          final _filteredCommentViewModels = filteredCommentViewModels;

          //
          if (_filteredCommentViewModels.isEmpty ?? true) {
            return Center(
              child: Text(KString.strNotDataComment),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
            itemCount: _filteredCommentViewModels.length,
            itemBuilder: (BuildContext context, int index) {
              printDebug("Test load comment at index: $index");

              final TTOCommentItemViewModel commentViewModel =
                  _filteredCommentViewModels[index];

              if (commentViewModel is TTOCommentViewModel) {
                return TTOCommentWidget(viewModel: commentViewModel);
              }

              if (commentViewModel is TTOCommentLoadMoreViewModel) {
                return TTOCommentLoadMoreWidget(viewModel: commentViewModel);
              }

              return Offstage();
            },
          );
        }

        return AppLoadingIndicator();
      },
    );
  }
}
