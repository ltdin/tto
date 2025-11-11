import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/widgets/app_loading.dart';

class ButtonElevatedCustom extends StatefulWidget {
  const ButtonElevatedCustom({
    Key key,
    this.height = 40.0,
    this.width = double.maxFinite,
    this.text = 'ElevatedButton',
    this.onTap,
    this.color = buttonVoteColor,
    this.loadingButtonWhenClick = false,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;
  final Color color;
  final bool loadingButtonWhenClick;
  final VoidCallback onTap;

  @override
  State<ButtonElevatedCustom> createState() => _ButtonElevatedCustomState();
}

class _ButtonElevatedCustomState extends State<ButtonElevatedCustom> {
  bool _isLoading = false;
  final _textButtonStyle = KfontConstant.styleOfSmallTitle.copyWith(
    color: CL_WHITE,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        style: KfontConstant.styleButtonVote.copyWith(
          backgroundColor: MaterialStateProperty.all<Color>(widget.color),
        ),
        child: getContentBotton,
        onPressed: (widget?.loadingButtonWhenClick ?? false)
            ? _isLoading
                ? null
                : _onSubmit
            : _onSubmit,
      ),
    );
  }

  Widget get getContentBotton => (widget?.loadingButtonWhenClick ?? false)
      ? _isLoading
          ? AppLoadingIndicator(colorIndicator: CL_WHITE)
          : Text(widget.text, style: _textButtonStyle)
      : Text(widget.text, style: _textButtonStyle);

  void _onSubmit() {
    (widget.onTap != null) ? widget.onTap.call() : null;

    // Update UI
    if (widget?.loadingButtonWhenClick ?? false) {
      setState(() {
        _isLoading = !_isLoading;
      });

      Future.delayed(Duration(seconds: 1), _onResetButton);
    }
  }

  void _onResetButton() {
    if (mounted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }
}
