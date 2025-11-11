import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/user_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/button_elevated_custom.dart';

class PopupOptionGiftStar extends StatefulWidget {
  const PopupOptionGiftStar({Key key, this.onGiftStar}) : super(key: key);

  final ValueChanged<int> onGiftStar;

  @override
  State<PopupOptionGiftStar> createState() => _PopupOptionGiftStarState();
}

class _PopupOptionGiftStarState extends State<PopupOptionGiftStar> {
  TextEditingController _starController = TextEditingController();
  int _numberStarChoose;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.symmetric(horizontal: paddingNews),
      title: AppBar(
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
      content: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  // 3 Star
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(paddingNews + 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/icon_star.png'),
                              Text(' x1')
                            ],
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: CL_CIRCLE_BORDER),
                          ),
                        ),
                        onTap: () => _onChooseStar(1),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(paddingNews + 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/icon_star.png'),
                              Text(' x10')
                            ],
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: CL_CIRCLE_BORDER),
                          ),
                        ),
                        onTap: () => _onChooseStar(10),
                      ),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.all(paddingNews + 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/icon_star.png'),
                              Text(' x15')
                            ],
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: CL_CIRCLE_BORDER),
                          ),
                        ),
                        onTap: () => _onChooseStar(15),
                      ),
                    ],
                  ),

                  // Input star
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: paddingNews),
                    child: Text(
                      'Hoặc nhập số sao',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 220,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _starController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: _numberStarChoose == null
                                ? 'Nhập số sao bạn muốn tặng'
                                : '',
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Image.asset('assets/icons/icon_star.png'),
                    ],
                  ),

                  // Star info
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: paddingNews),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Bạn đang có ${userBloc.userInfo.getStar} sao',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Send
            ButtonElevatedCustom(
              text: 'Tặng sao',
              onTap: () => _checkGiftStar(),
            )
          ],
        ),
      ),
    );
  }

  void _checkGiftStar() {
    final numberGift = int.tryParse(_starController.text);

    if (numberGift != null && userBloc.userInfo.getStar >= numberGift) {
      widget.onGiftStar != null ? widget.onGiftStar.call(numberGift) : null;
      Navigator.pop(context);
    } else {
      numberGift == null
          ? AppHelpers.showToast(text: 'Nhập số sao không hợp lệ')
          : AppHelpers.showToast(text: 'Số sao không đủ');
    }
  }

  void _onChooseStar(int number) {
    setState(() {
      _numberStarChoose = number;
      _starController.text = _numberStarChoose.toString();
    });
  }
}
