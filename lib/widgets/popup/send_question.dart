import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/enum.dart';
import 'package:news/constant/length.dart';
import 'package:news/widgets/button_elevated_custom.dart';
import 'package:news/widgets/button_outlined_custom.dart';

class SendQuestion extends StatefulWidget {
  const SendQuestion({Key key, this.topic, this.assetTopic, this.typeQuestion})
      : super(key: key);

  final String topic;
  final String assetTopic;
  final TypeQuestion typeQuestion;

  @override
  State<SendQuestion> createState() => _SendQuestionState();
}

class _SendQuestionState extends State<SendQuestion> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _captchaController = TextEditingController();

  final _titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  int numberA = 0;
  int numberB = 0;

  @override
  void initState() {
    numberA = _getNumberRandom();
    numberB = _getNumberRandom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardNewsBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: voteBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(paddingNewsTitle),
          child: SvgPicture.asset(widget.assetTopic, width: 20, height: 20),
        ),
        title: Text(
          widget.topic,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.clear),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(paddingNews),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question
                Text('Câu hỏi cho chuyên gia', style: _titleStyle),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
                  child: Container(
                    color: Colors.white,
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _questionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập câu hỏi',
                        hintStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),

                // Name
                Text('Họ và tên', style: _titleStyle),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 0, 15),
                      child: TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nhập họ và tên của bạn',
                            hintStyle: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ),
                ),

                // Email
                Text('Email', style: _titleStyle),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 15),
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 15, 0, 15),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nhập email của bạn',
                            hintStyle: TextStyle(fontSize: 13)),
                      ),
                    ),
                  ),
                ),

                // Captcha
                Text('Mã captcha', style: _titleStyle),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Input
                    Container(
                      color: Colors.white,
                      height: 30,
                      width: 90,
                      child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        controller: _captchaController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mã Captcha',
                          hintStyle:
                              TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                    ),

                    // Question
                    Container(
                      color: Colors.purple[100],
                      width: 90,
                      margin: EdgeInsets.only(left: paddingNews32),
                      padding: const EdgeInsets.symmetric(
                        vertical: paddingNewsTitle,
                      ),
                      child: Text(
                        '$numberA + $numberB = ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),

                    // Icon refesh
                    IconButton(
                      onPressed: () => _refeshCaptcha(),
                      icon: Icon(Icons.refresh, color: Colors.grey),
                    ),
                  ],
                ),

                // Send
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ButtonOutlinedCustom(
                          padding: EdgeInsets.only(right: paddingNews),
                          content: Text(
                            'Hủy bỏ',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onClick: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: ButtonElevatedCustom(
                          text: 'Gửi câu hỏi',
                          onTap: () => _sendTheQuestion(
                            _questionController.text,
                            _nameController.text,
                            _emailController.text,
                            _captchaController.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendTheQuestion(
    String question,
    String name,
    String email,
    String captcha,
  ) async {
    if ((question?.isNotEmpty ?? false) &&
        (name?.isNotEmpty ?? false) &&
        (email?.isNotEmpty ?? false) &&
        (captcha?.isNotEmpty ?? false)) {
      if (int.tryParse(captcha) != (numberA + numberB)) {
        AppHelpers.showToast(
          text: 'Xác nhận captcha sai',
          isError: false,
        );
        return;
      }

      // Call api
      final result = await bloc.sendTheQuestion(
        name,
        email,
        question,
        widget.typeQuestion,
      );

      //
      final strResult =
          result ? 'Đã gửi câu hỏi cho chuyên gia' : 'Gửi thất bại';
      AppHelpers.showToast(text: strResult, isError: !result);

      // Pop screen
      Navigator.pop(context);
    } else {
      AppHelpers.showToast(text: 'Vui lòng nhập đầy đủ thông tin');
    }
  }

  int _getNumberRandom() {
    var rng = Random();
    return rng.nextInt(10);
  }

  void _refeshCaptcha() {
    setState(() {
      numberA = _getNumberRandom();
      numberB = _getNumberRandom();
    });
  }
}
