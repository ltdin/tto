import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/user_model.dart';
import 'package:news/pages/detail/page_detail_webview_custom_tab.dart';
import 'package:news/widgets/button_elevated_custom.dart';

class ExtendStar extends StatefulWidget {
  const ExtendStar({Key key, this.userInfo}) : super(key: key);

  final UserModel userInfo;

  @override
  State<ExtendStar> createState() => _ExtendStarState();
}

class _ExtendStarState extends State<ExtendStar> {
  int numberStar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tuổi Trẻ Sao'),
        backgroundColor: popupBuyStarColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.clear, color: CL_WHITE),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(paddingNews),
                width: MediaQuery.of(context).size.width,
                color: cardNewsBorderColor,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Thông tin tài khoản ngày',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Tài khoản được sử dụng đến ngày ${widget.userInfo.getExpire.toString()}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Bạn đạng có ${widget.userInfo?.getStar.toString()} ',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Image.asset('assets/icons/icon_star.png'),
                          Text(' trong tài khoản')
                        ],
                      ),
                    ]),
              ),

              // Radio
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 25, 16, 25),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          Color.fromARGB(255, 159, 161, 163).withOpacity(0.5),
                    ),
                    color: cardNewsBackgroundColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio(
                        value: null,
                        groupValue: null,
                        onChanged: (value) {},
                      ),
                      Text(
                        'Gói đọc báo 6 tháng',
                        style: TextStyle(fontSize: 15),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '180.000đ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Input star
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 220,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập số sao cần mua',
                          hintStyle: TextStyle(fontSize: 20),
                        ),
                        onChanged: (value) {
                          if (value?.isNotEmpty ?? false) {
                            setState(() {
                              numberStar = int.tryParse(value);
                            });
                          } else {
                            setState(() {
                              numberStar = 0;
                            });
                          }
                        },
                      ),
                    ),
                    Image.asset('assets/icons/icon_star.png'),
                  ],
                ),
              ),

              Divider(
                height: 3.0,
                color: Color.fromARGB(255, 74, 73, 73).withOpacity(0.1),
              ),

              // Info star
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  child: Text(
                    '1 sao = 1000đ. Mua thêm sao để tham gia hoạt động và tương tác trên Tuổi Trẻ như:Đổi quà lưu niệm,tặng sao cho tác giả,shopping.',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tổng số tiền thanh toán:',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(' ${180000 + (numberStar * 1000)} đ',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 113, 111, 111)))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Số sao có thêm :'),
                  Text(' ${numberStar} '),
                  Image.asset('assets/icons/icon_star.png'),
                ],
              ),

              // Money Payment
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Button payment
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: paddingNews,
                        vertical: paddingNews32,
                      ),
                      child: ButtonElevatedCustom(
                        width: double.maxFinite,
                        height: 50,
                        text: 'Thanh toán',
                        color: popupBuyStarColor,
                        onTap: () => PageDetailWebviewCustomTab.launch(
                          url: 'https://stag-mediahub.tuoitre.vn/tuoitresao',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
