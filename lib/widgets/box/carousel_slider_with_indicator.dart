import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/box/item_register_sso.dart';

class CarouselSliderWithIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CarouselSliderWithIndicatorState();
  }
}

class CarouselSliderWithIndicatorState
    extends State<CarouselSliderWithIndicator> {
  final List imageList = [
    {
      "id": ItemRegisterSso(
        urlIcon: 'assets/icons/icon_no_ads.svg',
        title: 'Không quảng cáo',
        sapo: 'Tất cả bài viết và video không có quảng cáo',
        urlImage: 'assets/images/banner_no_ads.png',
      )
    },
    {
      "id": ItemRegisterSso(
        urlIcon: 'assets/icons/icon_health_advice.svg',
        title: 'Tư vấn sức khỏe',
        sapo:
            'Cùng các bác sĩ giải đáp những vấn đề về liên quan đến sức khỏe,làm đẹp',
        urlImage: 'assets/images/banner_health_advice.png',
      )
    },
    {
      "id": ItemRegisterSso(
        urlIcon: 'assets/icons/icon_tto_live.svg',
        title: 'Tuổi trẻ live',
        sapo: 'Thường xuyên trực tiếp các sự kiện nóng trên cả nước',
        urlImage: 'assets/images/banner_tto_live.png',
      )
    },
    {
      "id": ItemRegisterSso(
        urlIcon: 'assets/icons/icon_legal_advice.svg',
        title: 'Tư vấn pháp luật',
        sapo: 'Tư vấn nhưng vấn đề liên quan pháp luật mà bạn đọc quan tâm',
        urlImage: 'assets/images/banner_legal_advice.png',
      )
    },
    {
      "id": ItemRegisterSso(
        urlIcon: 'assets/icons/icon_read_print_news.svg',
        title: 'Đọc báo in',
        sapo: 'Báo in bằng những trình duyệt hiện đại',
        urlImage: 'assets/images/banner_read_print_newspaper.png',
      )
    },
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: CarouselSlider(
            items:
                imageList.map((item) => Container(child: item['id'])).toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 2,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: paddingNews),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: paddingNewsTitle,
                  height: paddingNewsTitle,
                  margin:
                      const EdgeInsets.symmetric(horizontal: paddingNewsTitle),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentIndex == entry.key
                        ? buttonVoteColor
                        : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
