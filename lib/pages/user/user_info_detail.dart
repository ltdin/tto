import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/base/app_setting.dart';
import 'package:news/constant/length.dart';
import 'package:news/models/user_model.dart';
import 'package:news/pages/user/default_bottom.dart';
import 'package:news/widgets/divider_widget.dart';
import 'package:news/widgets/logo_tto_widget.dart';

class UserInfoDetail extends StatefulWidget {
  const UserInfoDetail({Key key, this.userInfo}) : super(key: key);

  final UserModel userInfo;

  @override
  State<UserInfoDetail> createState() => _UserInfoDetailState();
}

class _UserInfoDetailState extends State<UserInfoDetail> {
  final TextEditingController _textIdnewsController = TextEditingController();
  List<String> listSex = <String>['Chọn giới tính', 'Nam', 'Nữ', 'Khác'];
  String selsectValue;
  DateTime dateTime;
  final colorBackground = Color(0xFFdfdfdf);
  final colorButton = Color(0xFF0d6efd);

  @override
  void initState() {
    dateTime = DateTime.now();
    selsectValue = listSex.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: LogoTTOWidget(),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingNews),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: paddingNews32),
                  child: Text(
                    'Thông tin cá nhân',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                DividerWidget(isSolid: true),

                // Name
                Text(
                  'Họ và tên:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: paddingNewsTitle),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    filled: true,
                    fillColor: colorBackground,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: widget.userInfo.getUserName,
                  ),
                ),

                // Birthday
                Padding(
                  padding: const EdgeInsets.only(
                    top: paddingNews,
                    bottom: paddingNewsTitle,
                  ),
                  child: Text(
                    'Ngày sinh:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Container(
                  color: colorBackground,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(widget.userInfo.getBirthTimestamp),
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.date_range),
                        onPressed: () => _showCupertinoModalPopup(),
                      )
                    ],
                  ),
                ),

                // Sex
                Padding(
                  padding: const EdgeInsets.only(
                    top: paddingNews,
                    bottom: paddingNewsTitle,
                  ),
                  child: Text(
                    'Giới tính:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: colorBackground,
                  padding: EdgeInsets.symmetric(horizontal: paddingNews),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selsectValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    onChanged: (String value) => setState(() {
                      selsectValue = value;
                    }),
                    items:
                        listSex.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                // Website
                Padding(
                  padding: const EdgeInsets.only(
                    top: paddingNews,
                    bottom: paddingNewsTitle,
                  ),
                  child: Text(
                    'Website:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    filled: true,
                    fillColor: colorBackground,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: paddingNewsTitle),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green,
                          side: BorderSide(color: Colors.green),
                        ),
                        child: Text(
                          'Lưu thay đổi',
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),

                // Security
                Text(
                  'Bảo mật:',
                  style: TextStyle(fontSize: 20),
                ),
                DividerWidget(isSolid: true),

                // Curent pass
                Padding(
                  padding: const EdgeInsets.only(
                    top: paddingNews,
                    bottom: paddingNewsTitle,
                  ),
                  child: Text(
                    'Mật khẩu hiện tại',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: '********',
                    contentPadding: EdgeInsets.all(12),
                    filled: true,
                    fillColor: colorBackground,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: paddingNewsTitle),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorButton,
                          side: BorderSide(color: colorButton),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),

                // Email & phone
                Text(
                  '\nCập nhật email và số điện thoại',
                  style: TextStyle(fontSize: 20),
                ),
                DividerWidget(isSolid: true),

                // The email
                Padding(
                  padding: const EdgeInsets.only(
                    top: paddingNews,
                    bottom: paddingNewsTitle,
                  ),
                  child: Text(
                    'Email',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextField(
                  obscureText: true,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: widget.userInfo.getEmail,
                    prefixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.all(12),
                    filled: true,
                    fillColor: colorBackground,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: paddingNewsTitle),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorButton,
                          side: BorderSide(color: colorButton),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(fontSize: 12, color: colorButton),
                        ),
                      ),
                    ),
                  ],
                ),

                // Phone
                Padding(
                  padding: const EdgeInsets.only(
                    top: paddingNews,
                    bottom: paddingNewsTitle,
                  ),
                  child: Text(
                    'Số điện thoại:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                TextField(
                  obscureText: true,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: widget.userInfo.getPhone,
                    contentPadding: EdgeInsets.all(12),
                    filled: true,
                    fillColor: colorBackground,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: paddingNewsTitle),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorButton,
                          side: BorderSide(color: colorButton),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Cập nhật',
                          style: TextStyle(fontSize: 12, color: colorButton),
                        ),
                      ),
                    ),
                  ],
                ),

                // Admin
                if (widget.userInfo.getEmail == "khanhpro027@gmail.com") ...[
                  Padding(
                    padding: const EdgeInsets.only(top: paddingNews32),
                    child: Text(
                      'Admin',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  DividerWidget(isSolid: true),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: paddingNews,
                      bottom: paddingNewsTitle,
                    ),
                    child: Text(
                      'Id news open Webview :',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  TextField(
                    controller: _textIdnewsController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      filled: true,
                      fillColor: colorBackground,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: paddingNewsTitle),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green,
                            side: BorderSide(color: Colors.green),
                          ),
                          child: Text(
                            'Lưu thay đổi',
                            style: TextStyle(fontSize: 12, color: Colors.green),
                          ),
                          onPressed: () => _updateIdnewsOpenWebview(
                            _textIdnewsController.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                // Bottom
                Padding(
                  padding: const EdgeInsets.only(top: paddingNews32),
                  child: DefaultBottom(),
                )
              ],
            ),
          ),
        ));
  }

  void _showCupertinoModalPopup() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Colors.white,
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Xong')),
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: dateTime,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (date) {
                        setState(() {
                          dateTime = date;
                        });
                      },
                    ),
                  ),
                ],
              ));
        });
  }

  void _updateIdnewsOpenWebview(String idNews) {
    _textIdnewsController.text = "";
    AppSetting().updateSetting(idNews);
  }
}
