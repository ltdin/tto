import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/models/article_model.dart';
import 'package:news/pages/detail/page_detail_native.dart';
import 'package:news/util/avatar_util.dart';

class ThumbBigShortDescWidget extends StatelessWidget {
  const ThumbBigShortDescWidget({Key key, this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          child: Stack(
            children: <Widget>[
              new Container(
                alignment: Alignment.topCenter,
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .62,
                    right: 30.0,
                    left: 30.0),
                child: new Container(
                  height: 25.0,
                  width: MediaQuery.of(context).size.width,
                  child: new Card(
                    color: Colors.white,
                    elevation: 10.0,
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.topCenter,
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .60,
                    right: 20.0,
                    left: 20.0),
                child: new Container(
                  height: 30.0,
                  width: MediaQuery.of(context).size.width,
                  child: new Card(
                    color: Colors.white,
                    elevation: 10.0,
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.topCenter,
                padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .58,
                    right: 10.0,
                    left: 10.0),
                child: new Container(
                  height: 35.0,
                  width: MediaQuery.of(context).size.width,
                  child: new Card(
                    color: Colors.white,
                    elevation: 10.0,
                  ),
                ),
              ),
              Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // add this
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                child: Image.network(
                                    AvatarUtil.avatarMedium(
                                        this.article.avatar),
                                    height: 200,
                                    fit: BoxFit.fill),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10, top: 8),
                      child: Text(this.article.zoneName,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontFamily: 'RobotoCondensedBold')),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 5),
                      alignment: Alignment.topLeft,
                      child: Text(this.article.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20.0)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Text(this.article.sapo,
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16.0)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          printDebug("Hello world");
                        },
                        child: Text(
                          'Xem thêm chuỗi sự kiện',
                          style: TextStyle(color: Colors.black, fontSize: 12.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 10, right: 10),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageTtoDetailNative(article: article)),
          );
        });
  }
}
