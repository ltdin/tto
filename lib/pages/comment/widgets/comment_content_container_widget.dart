import 'package:flutter/material.dart';
import 'package:news/pages/comment/viewmodels/comment_view_model.dart';

class TTOCommentContentContainerWidget extends StatefulWidget {
  final TTOCommentViewModel viewModel;

  const TTOCommentContentContainerWidget({Key key, @required this.viewModel})
      : super(key: key);

  @override
  _TTOCommentContentContainerWidgetState createState() =>
      _TTOCommentContentContainerWidgetState();
}

class _TTOCommentContentContainerWidgetState
    extends State<TTOCommentContentContainerWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      child: AnimatedContainer(
        padding: widget.viewModel.settingsUI.contentContainerPadding,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: widget.viewModel.settingsUI.contentContainerBackgroundColor,
          borderRadius:
              widget.viewModel.settingsUI.contentContainerBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.viewModel.commentModel.senderName,
              style: textTheme.subtitle2,
            ),
            SizedBox(height: 5.0),
            Text(
              widget.viewModel.commentModel.contentComment
                  .replaceAll('&nbsp;', ''),
              style: textTheme.bodyText2,
              maxLines: widget.viewModel.isExanded ? null : 4,
              overflow:
                  widget.viewModel.isExanded ? null : TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          widget.viewModel.isExanded = !widget.viewModel.isExanded;
        });
      },
    );
  }
}
