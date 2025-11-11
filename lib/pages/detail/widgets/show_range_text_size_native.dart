import 'package:flutter/material.dart';
import 'package:news/base/app_cache.dart';
import 'package:news/constant/number.dart';

class ShowRangeTextSizeNative extends StatefulWidget {
  const ShowRangeTextSizeNative({
    Key key,
    @required this.textZoom,
    this.setTextZoom,
    this.textStyle,
  }) : super(key: key);

  final int textZoom;
  final Function setTextZoom;
  final TextStyle textStyle;

  @override
  _ShowRangeTextSizeState createState() => _ShowRangeTextSizeState();
}

class _ShowRangeTextSizeState extends State<ShowRangeTextSizeNative> {
  double _valueTextZoom;

  @override
  void initState() {
    _valueTextZoom = double.tryParse(widget.textZoom.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      child: Row(
        children: [
          Text(
            'A',
            style: widget.textStyle.copyWith(
              fontSize: widget.textStyle.fontSize - 5,
            ),
          ),
          Expanded(
            child: Slider(
              min: TEXT_SIZE_MIN,
              max: TEXT_SIZE_MAX,
              value: _valueTextZoom,
              onChanged: (double value) {
                setState(() {
                  _valueTextZoom = value;
                });
              },
              onChangeEnd: (double value) {
                _valueTextZoom = value;
                widget.setTextZoom(_valueTextZoom.round());
                AppCache().textSize = _valueTextZoom.round();
              },
            ),
          ),
          Text(
            'A',
            style: widget.textStyle.copyWith(
              fontSize: widget.textStyle.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
