import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/constant/color.dart';
import 'package:news/constant/font.dart';
import 'package:news/constant/string.dart';
import 'package:news/pages/search/bloc/search_list_bloc.dart';
import 'package:news/pages/search/search_page.dart';

class BarSearchWidget extends StatelessWidget {
  const BarSearchWidget({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              Container(
                  child: TextButton.icon(
                icon: Icon(Icons.search, size: 14.0),
                label: Text(KString.searchBarTextBoxHome,
                    style: KfontConstant.searchBarTextBoxHome),
                onPressed: () {},
              )),
            ],
          ),
          decoration: new BoxDecoration(
            color: searchBarTextBoxBgColorHome,
            borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          )),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider<SearchListBloc>(
                create: (context) => SearchListBloc(),
                child: SearchPage(),
              );
            },
          ),
        );
      },
    );
  }
}
