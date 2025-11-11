import 'package:flutter/material.dart';
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';
import 'package:news/pages/comment/widgets/comment_avatar_widget.dart';
import 'package:news/pages/comment/widgets/comment_information_widget.dart';

class TTOCommentWidget extends StatefulWidget {
  final TTOCommentViewModel viewModel;

  const TTOCommentWidget({Key key, this.viewModel}) : super(key: key);

  @override
  _TTOCommentWidgetState createState() => _TTOCommentWidgetState();
}

class _TTOCommentWidgetState extends State<TTOCommentWidget> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.onExpandChanged = widget.viewModel.onLikeChanged = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.viewModel.settingsUI.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TTOCommentAvatarWidget(viewModel: widget.viewModel),
          SizedBox(width: 5.0),
          TTOCommentInformationWidget(viewModel: widget.viewModel)
        ],
      ),
    );
  }
}
