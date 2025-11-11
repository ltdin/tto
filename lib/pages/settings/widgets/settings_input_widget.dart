import 'package:flutter/material.dart';
import 'package:news/util/text_style_util.dart';

class TTOSettingsInputWidget extends StatefulWidget {
  const TTOSettingsInputWidget(
      {Key key,
      this.text = '',
      this.labelText = '',
      this.enabled = true,
      this.hintText = '',
      this.obscureText = false})
      : super(key: key);

  final String text;
  final String labelText;
  final bool enabled;
  final String hintText;
  final bool obscureText;

  @override
  _TTOSettingsInputWidgetState createState() => _TTOSettingsInputWidgetState();
}

class _TTOSettingsInputWidgetState extends State<TTOSettingsInputWidget> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = widget.text;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
            enabled: widget.enabled,
            labelText: widget.labelText,
            labelStyle: TTOTextStyle.regular(
                color: Colors.black.withOpacity(0.7), fontSize: 16.0),
            hintText: widget.hintText,
            hintStyle: TTOTextStyle.regular(
                color: Colors.black.withOpacity(0.3), fontSize: 16.0),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none),
        keyboardType: TextInputType.text,
        style: TTOTextStyle.regular(color: Colors.black, fontSize: 16.0),
        obscureText: widget.obscureText,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();

    super.dispose();
  }
}
