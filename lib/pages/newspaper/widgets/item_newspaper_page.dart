import 'package:flutter/material.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/models/newspaper.dart';
import 'package:news/pages/newspaper/widgets/item_newspaper_viewer.dart';

class ItemNewspaperPage extends StatelessWidget {
  const ItemNewspaperPage({
    Key key,
    @required this.newspaper,
    this.tabIndex,
  }) : super(key: key);

  final Newspaper newspaper;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bloc.getPageOfNewsPaper(
        newspaper,
        tabIndex + 1,
      ),
      builder: (context, AsyncSnapshot<Newspaper> item) {
        if (item.connectionState == ConnectionState.waiting) {
          // Hiển thị trang trắng khi đang chờ load dữ liệu
          return Container(color: Colors.white24);
        } else if (item.hasData) {
          // Hiển thị dữ liệu khi đã có
          return ItemNewspaperViewer(urlImage: item?.data?.getUrlImage);
        } else {
          // Xử lý trường hợp có lỗi hoặc dữ liệu không có
          return const Offstage();
        }
      },
    );
  }
}
