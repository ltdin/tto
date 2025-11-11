import 'package:flutter/material.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/box/box_bottom_widget.dart';
import 'package:news/widgets/image_network_loading.dart';

class InstructContent extends StatelessWidget {
  const InstructContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final _sizedBox8 = SizedBox(height: 8);
    final _sizedBox16 = SizedBox(height: paddingNews);
    final double _height = 256;

    return SingleChildScrollView(
      padding: EdgeInsets.all(paddingNews),
      child: Column(
        children: [
          SizedBox(height: 40),

          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.black,
                width: 2.0,
              )),
            ),
            child: Text(
              ' HƯỚNG DẪN SỬ DỤNG ',
              style: titleStyle.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
            ),
          ),

          // Step 1
          _sizedBox16,
          _sizedBox16,
          ImageNetworkLoading(
            height: _height,
            urlImage: 'https://epaper.tuoitre.vn/img/huongdan-1.png',
            fit: BoxFit.fill,
          ),

          // Step 2
          ImageNetworkLoading(
            height: _height * 2 + _height / 2,
            urlImage: 'https://epaper.tuoitre.vn/img/huongdan-2.png',
            fit: BoxFit.fill,
          ),

          // Step 3
          ImageNetworkLoading(
            height: _height + _height / 2,
            urlImage: 'https://epaper.tuoitre.vn/img/huongdan-3.png',
            fit: BoxFit.fill,
          ),

          // Step 4
          ImageNetworkLoading(
            height: _height + _height / 2,
            urlImage: 'https://epaper.tuoitre.vn/img/huongdan-4.png',
            fit: BoxFit.fill,
          ),

          // Step 5
          ImageNetworkLoading(
            height: _height + _height / 2,
            urlImage: 'https://epaper.tuoitre.vn/img/huongdan-5.png',
            fit: BoxFit.fill,
          ),
          _sizedBox8,
          _sizedBox16,
          _sizedBox16,

          //  Box info bottom
          BoxBottomInfoWidget(
            padding: EdgeInsets.zero,
            isShowYouthGroupLogo: true,
          )
        ],
      ),
    );
  }
}
