import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/models/article_model.dart';
import 'package:news/pages/comment/bloc/comment_bloc.dart';
import 'package:news/pages/comment/widgets/comment_list_widget.dart';
import 'package:news/pages/comment/widgets/page_bottom_widget.dart';
import 'package:news/pages/comment/viewmodels/comment_page_view_model.dart';
import 'package:news/pages/comment/settings/comment_page_settings_ui.dart';
import 'package:news/widgets/appbar_for_tab.dart';

class TTOCommentPage extends StatefulWidget {
  final Article article;
  const TTOCommentPage({Key key, this.article}) : super(key: key);

  @override
  _TTOCommentPageState createState() => _TTOCommentPageState();
}

class _TTOCommentPageState extends State<TTOCommentPage> {
  TTOCommentPageViewModel viewModel;
  TTOCommentPageSettingsUI settingsUI;

  @override
  void initState() {
    viewModel = new TTOCommentPageViewModel();
    settingsUI = new TTOCommentPageSettingsUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: "Bình luận"),
      body: BlocProvider<CommentBloc>(
        create: (context) =>
            CommentBloc()..add(GetListCommentEvent(article: widget.article)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: CommentListWidget(
                viewModel: viewModel,
                settingsUI: settingsUI,
                article: widget.article,
              ),
            ),

            // EditText comment
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: TTOCommentPageBottomWidget(
                  viewModel: viewModel,
                  settingsUI: settingsUI,
                  article: widget.article,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    viewModel = null;
    settingsUI = null;

    super.dispose();
  }
}
