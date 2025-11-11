import 'package:flutter/material.dart';
import 'package:news/base/app_local_config.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/length.dart';
import 'package:news/constant/string.dart';
import 'package:news/models/zone_model.dart';
import 'package:news/pages/category/sub_category_page.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/box/box_bottom_widget.dart';
import 'package:news/widgets/expandable_group.dart';
import 'package:news/widgets/image_with_border.dart';
import 'package:news/widgets/logo_sso_widget.dart';
import 'package:news/widgets/logo_tto_widget.dart';
import 'package:news/models/globals.dart' as globals;
import 'package:news/pages/search/search_page.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({this.onClickHeader});

  final ValueChanged<int> onClickHeader;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  final TextEditingController _searchController = TextEditingController();

  final List<ZoneList> _cates = [
    ZoneList(
      zoneId: -12,
      name: "Media",
      childZone: [],
    ),
    ZoneList(
      zoneId: 3,
      name: "Thời sự",
      childZone: [
        ZoneList(zoneId: 1579, name: 'Bút Bi'),
        ZoneList(zoneId: 200003, name: 'Xã hội'),
        ZoneList(zoneId: 89, name: 'Phóng sự'),
        ZoneList(zoneId: 87, name: 'Bình luận'),
        ZoneList(zoneId: 200070, name: 'Thời tiết'),
      ],
    ),
    ZoneList(
      zoneId: 2,
      name: "Thế giới",
      childZone: [
        ZoneList(zoneId: 94, name: 'Bình luận'),
        ZoneList(zoneId: 312, name: 'Kiều bào'),
        ZoneList(zoneId: 442, name: 'Muôn màu'),
        ZoneList(zoneId: 20, name: 'Hồ sơ'),
      ],
    ),
    ZoneList(
      zoneId: 6,
      name: "Pháp luật",
      childZone: [
        ZoneList(zoneId: 266, name: 'Chuyện pháp đình'),
        ZoneList(zoneId: 79, name: 'Tư vấn'),
        ZoneList(zoneId: 200005, name: 'Pháp lý'),
      ],
    ),
    ZoneList(
      zoneId: 11,
      name: "Kinh doanh",
      childZone: [
        ZoneList(zoneId: 86, name: 'Tài chính'),
        ZoneList(zoneId: 775, name: 'Doanh nghiệp'),
        ZoneList(zoneId: 200006, name: 'Mua sắm'),
        ZoneList(zoneId: 200007, name: 'Đầu tư'),
      ],
    ),
    ZoneList(
      zoneId: 200029,
      name: "Công nghệ",
      childZone: [
        ZoneList(zoneId: 200064, name: 'Thiết bị'),
        ZoneList(zoneId: 200065, name: 'Chuyển đổi số'),
        ZoneList(zoneId: 200066, name: 'Cầu nối'),
        ZoneList(zoneId: 16, name: 'Nhịp sống số'),
        ZoneList(zoneId: 557, name: 'Trải nghiệm'),
        ZoneList(zoneId: 547, name: 'Thị trường'),
        ZoneList(zoneId: 67, name: 'Thủ thuật'),
        ZoneList(zoneId: 200028, name: 'Gia đình số'),
        ZoneList(zoneId: 297, name: 'Nhịp cầu'),
      ],
    ),
    ZoneList(
      zoneId: 659,
      name: "Xe",
      childZone: [
        ZoneList(zoneId: 1589, name: 'Tin tức'),
        ZoneList(zoneId: 1590, name: 'Tư vấn mua xe'),
        ZoneList(zoneId: 1591, name: 'Đánh giá xe'),
        ZoneList(zoneId: 1592, name: 'Thị trường xe'),
        ZoneList(zoneId: 1594, name: 'Hỏi đáp'),
        ZoneList(zoneId: 1595, name: 'Kỹ thuật'),
        ZoneList(zoneId: 1596, name: 'An toàn giao thông'),
      ],
    ),
    ZoneList(
      zoneId: 100,
      name: "Du lịch",
      childZone: [
        ZoneList(zoneId: 100001, name: 'Cơ hội du lịch'),
        ZoneList(zoneId: 100009, name: 'Đi chơi'),
        ZoneList(zoneId: 384, name: 'Mách bạn'),
        ZoneList(zoneId: 100011, name: 'Quê hương'),
      ],
    ),
    ZoneList(
      zoneId: 7,
      name: "Nhịp sống trẻ",
      childZone: [
        ZoneList(zoneId: 200012, name: 'Xu hướng'),
        ZoneList(zoneId: 1580, name: 'Theo Gương Bác'),
        ZoneList(zoneId: 200013, name: 'Khám phá'),
        ZoneList(zoneId: 194, name: 'Yêu'),
        ZoneList(zoneId: 200014, name: 'Nhân vật'),
        ZoneList(zoneId: 269, name: 'Việc làm'),
        ZoneList(zoneId: 200108, name: 'Tuổi Trẻ Start-Up Award'),
      ],
    ),
    ZoneList(
      zoneId: 200017,
      name: "Văn hóa",
      childZone: [
        ZoneList(zoneId: 200050, name: 'Nhân vật'),
        ZoneList(zoneId: 200051, name: 'Sàn diễn'),
        ZoneList(zoneId: 61, name: 'Sách'),
        ZoneList(zoneId: 200018, name: 'Đời sống'),
        ZoneList(zoneId: 200051, name: 'Sàn diễn'),
        ZoneList(zoneId: 100010, name: 'Ẩm thực'),
      ],
    ),
    ZoneList(
      zoneId: 10,
      name: "Giải trí",
      childZone: [
        ZoneList(zoneId: 1581, name: 'Ăn gì hôm nay'),
        ZoneList(zoneId: 58, name: 'Âm nhạc'),
        ZoneList(zoneId: 57, name: 'Điện ảnh'),
        ZoneList(zoneId: 385, name: 'TV Show'),
        ZoneList(zoneId: 919, name: 'Thời trang'),
        ZoneList(zoneId: 922, name: 'Hậu trường'),
      ],
    ),
    ZoneList(
      zoneId: 1209,
      name: "Thể thao",
      childZone: [
        ZoneList(zoneId: 200109, name: 'SEA Games 32'),
        ZoneList(zoneId: 1212, name: 'Bóng đá'),
        ZoneList(zoneId: 1584, name: 'Bóng rổ'),
        ZoneList(zoneId: 1585, name: 'Võ thuật'),
        ZoneList(zoneId: 1230, name: 'Các môn khác'),
        ZoneList(zoneId: 200067, name: 'Khỏe 360°'),
        ZoneList(zoneId: 200031, name: 'Người hâm mộ'),
      ],
    ),
    ZoneList(
      zoneId: 13,
      name: "Giáo dục",
      childZone: [
        ZoneList(zoneId: 142, name: 'Tuyển sinh'),
        ZoneList(zoneId: 1602, name: 'Nhịp sống học đường'),
        ZoneList(zoneId: 1603, name: 'Chân dung nhà giáo'),
        ZoneList(zoneId: 85, name: 'Du học'),
        ZoneList(zoneId: 913, name: 'Câu chuyện giáo dục'),
      ],
    ),
    ZoneList(
      zoneId: 661,
      name: "Khoa học",
      childZone: [
        ZoneList(zoneId: 200010, name: 'Thường thức'),
        ZoneList(zoneId: 200011, name: 'Phát minh'),
      ],
    ),
    ZoneList(
      zoneId: 12,
      name: "Sức khỏe",
      childZone: [
        ZoneList(zoneId: 200008, name: 'Dinh dưỡng'),
        ZoneList(zoneId: 197, name: 'Mẹ & Bé'),
        ZoneList(zoneId: 241, name: 'Giới tính'),
        ZoneList(zoneId: 231, name: 'Phòng mạch'),
        ZoneList(zoneId: 1465, name: 'Biết để khỏe'),
      ],
    ),
    ZoneList(
      zoneId: 200015,
      name: "Giả - Thật",
      childZone: [],
    ),
    ZoneList(
      zoneId: 118,
      name: "Bạn đọc làm báo",
      childZone: [
        ZoneList(zoneId: 626, name: 'Phản hồi'),
        ZoneList(zoneId: 937, name: 'Đường dây nóng'),
        ZoneList(zoneId: 1360, name: 'Tiêu điểm'),
        ZoneList(zoneId: 940, name: 'Chia sẻ'),
        ZoneList(zoneId: 1582, name: 'Đọc báo cùng bạn'),
      ],
    ),
    ZoneList(
      zoneId: 334,
      name: "Cần biết",
      childZone: [
        ZoneList(zoneId: 735, name: 'Thị trường 247', slug: 'thi-truong-247'),
        ZoneList(
          zoneId: 736,
          name: 'Giáo dục - Hướng nghiệp',
          slug: 'hoc-hanh',
        ),
        ZoneList(zoneId: 738, name: 'Địa ốc', slug: 'dia-oc'),
        ZoneList(zoneId: 737, name: 'Giải trí', slug: 'giai-tri-cb'),
        ZoneList(zoneId: 740, name: 'Đời sống', slug: 'doi-song'),
        ZoneList(zoneId: 741, name: 'Sản phẩm', slug: 'san-pham'),
      ],
    ),
    ZoneList(
      zoneId: 204,
      name: "Nhà đất",
      childZone: [
        ZoneList(zoneId: 1594, name: 'Hỏi đáp'),
        ZoneList(zoneId: 547, name: 'Thị trường'),
        ZoneList(zoneId: 1360, name: 'Chính sách'),
        ZoneList(zoneId: 940, name: 'Dự án'),
        ZoneList(zoneId: 2, name: 'Thế giới'),
        ZoneList(zoneId: 2, name: 'Smarthome'),
      ],
    ),
    ZoneList(zoneId: -19, name: "Thời tiết", childZone: []),
    ZoneList(zoneId: -20, name: "Trải nghệm & Đánh giá", childZone: []),
    ZoneList(zoneId: -21, name: "Rao vặt", childZone: []),
    ZoneList(zoneId: -22, name: "Tuoitrenews", childZone: []),

    ZoneList(zoneId: -23, name: "Tuổi Trẻ Cuối Tuần", childZone: []),
    ZoneList(zoneId: -24, name: "Podcast Tuổi Trẻ", childZone: []),
    ZoneList(zoneId: -25, name: "Tuổi Trẻ Shop", childZone: []),

    ZoneList(zoneId: -26, name: "Quảng cáo", childZone: []),
    ZoneList(zoneId: -27, name: "Đặt báo", childZone: []),
  ];

  @override
  Widget build(BuildContext context) {
    printDebug('------------- Build side menu -------------');

    final _themeData = Theme.of(context).textTheme;
    TextStyle _textStyle = _themeData.subtitle1.copyWith(
      fontFamily: KfontConstant.SFProDisplayBold,
    );
    final textThemeSubtitle = _themeData.subtitle1.copyWith(
      fontWeight: FontWeight.normal,
    );

    return ListView(
      children: <Widget>[
        // Logo tto
        globals.isTTStar ? LogoSSOWidget() : LogoTTOWidget(),

        // Version app
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: paddingNewsTitle),
            child: Text(
              KString.strCheckVersion + ' : ' + AppLocalConfig.strAppVersion,
              style: textThemeSubtitle.copyWith(
                fontSize: 12,
                color: tabBarTextLabelColor,
              ),
            ),
          ),
        ),

        // Divider
        Divider(height: 1, color: Colors.grey),

        // Tìm kiếm
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
            onSubmitted: (value) {
              if (value.trim().isEmpty) return;

              // Đóng SideMenu trước
              Navigator.of(context).pop();

              // Mở SearchPage với keyword
              Future.delayed(Duration(milliseconds: 300), () {
                if (!mounted) return;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SearchPage(initialKeyword: value.trim()),
                  ),
                );
              });
            },

          ),
        ),



        // Chữ "Chuyên mục"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Chuyên mục',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),

        // List cate
        Column(
          children: _cates.map((itemGroup) {
            return ExpandableGroup(
              header: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('${itemGroup.name}', style: _textStyle),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onClickHeader.call(_cates.lastIndexOf(itemGroup));
                  }),
              items: itemGroup.childZone
                  .map(
                    (item) => ListTile(
                        contentPadding: const EdgeInsets.only(left: 32),
                        title: Text(
                          item.name,
                          style: _textStyle.copyWith(
                              color: _textStyle.color.withOpacity(0.8),
                              fontFamily: KfontConstant.SFDisplayRegular),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          _moveToSubCategoryPage(context, item, itemGroup.name);
                        }),
                  )
                  .toList(),
            );
          }).toList(),
        ),

        // Orther
        if (globals.isShowFullFunction) ...[
          Padding(
            padding: const EdgeInsets.all(paddingNews),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //    padding: const EdgeInsets.only(bottom: 8.0),
                //    child: Text("Đặt báo", style: _textStyle),
                // ),
                ImageWithBorder(
                  urlImage: 'assets/images/logo_cuoi.png',
                  onTap: () {
                    PageDetailWebviewCustomTab.launch(
                      url: KString.CUOI_URL,
                    );
                  },
                ),
                ImageWithBorder(
                  urlImage: 'assets/images/logo_cuoi_tuan.png',
                  onTap: () {
                    PageDetailWebviewCustomTab.launch(
                      url: KString.CUOI_TUAN_URL,
                    );
                  },
                ),
                ImageWithBorder(
                  urlImage: 'assets/images/logo_tto_tv.png',
                  onTap: () {
                    PageDetailWebviewCustomTab.launch(
                      url: KString.VIDEO_URL,
                    );
                  },
                ),
                ImageWithBorder(
                  urlImage: 'assets/images/logo_tto_news.png',
                  onTap: () {
                    PageDetailWebviewCustomTab.launch(
                      url: KString.TT_NEWS_URL,
                    );
                  },
                ),
                ImageWithBorder(
                  urlImage: 'assets/images/logo_mt_back.png',
                  onTap: () {
                    PageDetailWebviewCustomTab.launch(
                      url: KString.TT_MUCTIM_URL,
                    );
                  },
                ),
              ],
            ),
          ),
        ],

        //  Box Bottom
        BoxBottomInfoWidget()
      ],
    );
  }

  void _moveToSubCategoryPage(
    BuildContext context,
    ZoneList itemGroup,
    String parentCategory,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubCategoryPage(
          zone: itemGroup,
          parentCategory: parentCategory,
        ),
      ),
    );
  }
}
