import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';

class SearchTopBarTitleWidget extends StatelessWidget {
  const SearchTopBarTitleWidget(
      {Key key, this.seachTxtChanged, this.controller})
      : super(key: key);

  final ValueChanged<String> seachTxtChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: searchTxtFieldHeight,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: divideLineColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.search,
            color: floorTitleColor,
            size: 20,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: seachTxtChanged,
              cursorWidth: 1.5,
              cursorColor: floorTitleColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 5, left: 5),
                hintText: 'Nhập từ khoá',
                hintStyle: TextStyle(fontSize: 14),
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(top: 0, right: 0),
                  onPressed: () {
                    this.controller.clear();
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
