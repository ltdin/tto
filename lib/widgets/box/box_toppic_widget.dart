import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/widgets/box/threadname_slider.dart';

import '../../blocs/news_bloc.dart';
import '../../models/thread_model.dart';
import '../../pages/thread/all_threads_page.dart';

class BoxToppicWidget extends StatefulWidget {
  const BoxToppicWidget({Key key}) : super(key: key);

  @override
  State<BoxToppicWidget> createState() => _BoxToppicWidgetState();
}

class _BoxToppicWidgetState extends State<BoxToppicWidget> {
  Future<List<ThreadModel>> _futureThreads;
  List<ThreadModel> _cachedThreads;

  @override
  void initState() {
    super.initState();
     _futureThreads = bloc.getThreads(pageIndex: 1).then((value) {
    _cachedThreads = value;
    return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: paddingNews / 2,
        bottom: paddingNews,
        left: paddingNews,
        right: paddingNews,
      ),
      margin: const EdgeInsets.symmetric(vertical: paddingNews),
      decoration: BoxDecoration(
        color: voteBackgroundColor,
        border: Border.all(color: cardNewsBorderColor),
        borderRadius: BorderRadius.circular(radius8),
      ),
      child: Column(
        children: [
          // Header topic
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: paddingDivider, horizontal: 0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'CHỦ ĐỀ NỔI BẬT ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextSpan(
                          text: 'HÔM NAY',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AllThreadsPage()),
                  );
                },
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          FutureBuilder<List<ThreadModel>>(
            future: _futureThreads,
            builder: (context, snapshot) {
              // Khi đang load hoặc lỗi hoặc không có dữ liệu
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data.isEmpty) {
                return const SizedBox.shrink(); // Ẩn sạch slider, không quay quay
              }

              // Đã có dữ liệu → Hiển thị slider
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ThreadSlidersGroup(),
              );
            },
          ),



          // Slider tĩnh
          // FutureBuilder<List<ThreadModel>>(
          //   future: _futureThreads,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 8),
          //         child: Center(child: CircularProgressIndicator()),
          //       );
          //     }
          //
          //     if (snapshot.hasError) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 8),
          //         child: Text('Lỗi: ${snapshot.error}'),
          //       );
          //     }
          //
          //     final threads = snapshot.data ?? [];
          //     if (threads.isEmpty) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 8),
          //         child: Text(KString.msgNoData),
          //       );
          //     }
          //
          //     return Padding(
          //       // padding: const EdgeInsets.only(top: 8),
          //       // child: ThreadNameSlider(threads: threads),
          //       padding: const EdgeInsets.only(top: 8),
          //       child: ThreadSlidersGroup(), //  Gọi widget này là có 2 slider không trùng nhau
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

