import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/string.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/comment_model.dart';
import 'package:news/pages/comment/bloc/comment_bloc.dart';
import 'package:news/pages/comment/viewmodels/comment_page_view_model.dart';
import 'package:news/models/article_model.dart';
import 'package:news/pages/comment/settings/comment_page_settings_ui.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:news/models/globals.dart' as globals;

class TTOCommentPageBottomWidget extends StatefulWidget {
  final TTOCommentPageViewModel viewModel;
  final TTOCommentPageSettingsUI settingsUI;
  final Article article;

  const TTOCommentPageBottomWidget({
    Key key,
    this.viewModel,
    this.settingsUI,
    this.article,
  }) : super(key: key);

  @override
  _TTOCommentPageBottomWidgetState createState() =>
      _TTOCommentPageBottomWidgetState();
}

class _TTOCommentPageBottomWidgetState
    extends State<TTOCommentPageBottomWidget> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.onCommentInputOpened = (String text) {
      _textEditingController.text = text;
      FocusScope.of(context).requestFocus(_focusNode);
    };
    widget.viewModel.onUserLoggedInChanged = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Divider(height: 3.0),
        Row(
          children: [
            // Input comment
            Flexible(
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: "Viết ý kiến của bạn...",
                  contentPadding: widget.settingsUI.inputContentPadding,
                  counterText: "",
                  border: InputBorder.none,
                ),
                focusNode: _focusNode,
                onEditingComplete: () => onEditingComplete(),
              ),
            ),
            SizedBox(height: widget.settingsUI.bottomInputHeight)
          ],
        ),
      ],
    );
  }

  void onEditingComplete() {
    if (_textEditingController.text.isEmpty) {
      return;
    }

    if (globals.isLoggedIn) {
      _sendComment(
        article: widget.article,
        textEditingController: _textEditingController,
        name: userBloc.userInfo.name,
        email: userBloc.userInfo.email,
        isLogin: true,
      );
    } else {
      _showFormInfo();
    }
  }

  void _showFormInfo() {
    Alert(
        context: context,
        title: "Thông tin bạn đọc",
        content: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Tên',
              ),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                labelText: 'Email',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.red,
            onPressed: () => _sendComment(
              article: widget.article,
              textEditingController: _textEditingController,
              name: _nameController.text,
              email: _emailController.text,
            ),
            child: Text(
              "Lưu và gửi bình luận",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Future<void> _sendComment({
    Article article,
    TextEditingController textEditingController,
    String name,
    String email,
    bool isLogin = false,
  }) async {
    if (email.isNotEmpty && name.isNotEmpty) {
      final isSend = await widget.viewModel.addComment(
        textEditingController.text,
        name,
        email,
        article: article,
      );

      if (isSend == true) {
        //
        AppHelpers.showToast(text: KString.msgSent);

        // Update list comment
        BlocProvider.of<CommentBloc>(context).add(
          AddCommentEvent(
            itemComment: TTOCommentJSONModel(
              id: '',
              newsId: article.newsId,
              contentComment: textEditingController.text,
              senderName: name,
              senderAvatar: '',
              senderEmail: email,
              senderPhone: '',
              like: 0,
              childComment: [],
            ),
          ),
        );
      }
    } else {
      AppHelpers.showToast(text: KString.msgEmailFaild);
    }

    // Reset textfiel
    textEditingController.text = "";
    _focusNode.unfocus();

    // Pop context if not login
    if (!isLogin) Navigator.pop(context);
  }
}
