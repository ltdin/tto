import 'package:flutter/material.dart';
import 'package:news/constant/color.dart';
import 'package:news/models/list_newspaper.dart';
import 'package:pagination_flutter/pagination.dart';

class BoxPagination extends StatefulWidget {
  const BoxPagination({Key key, this.onPageChanged, this.pagination})
      : super(key: key);

  final ValueChanged<int> onPageChanged;
  final PaginationModel pagination;

  @override
  State<BoxPagination> createState() => _BoxPaginationState();
}

class _BoxPaginationState extends State<BoxPagination> {
  int _selectedPage = 1;

  @override
  void initState() {
    _selectedPage = widget.pagination.getIntCurrentPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double sizedIcon = 32;

    return Pagination(
      numOfPages: widget.pagination.getTotalPage,
      selectedPage: _selectedPage,
      pagesVisible: 3,
      spacing: 4,
      onPageChanged: (page) {
        setState(() {
          _selectedPage = page;
        });

        if (widget.onPageChanged != null) {
          widget.onPageChanged.call(_selectedPage);
        }
      },
      nextIcon: Icon(
        Icons.chevron_right_rounded,
        color: PRIMARY_COLOR,
        size: sizedIcon,
      ),
      previousIcon: Icon(
        Icons.chevron_left_rounded,
        color: PRIMARY_COLOR,
        size: sizedIcon,
      ),
      activeTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      activeBtnStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR),
        shape: MaterialStateProperty.all(
          CircleBorder(
            side: BorderSide(
              color: PRIMARY_COLOR,
              width: 1,
            ),
          ),
        ),
      ),
      inactiveBtnStyle: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(const CircleBorder(
          side: BorderSide(
            color: PRIMARY_COLOR,
            width: 1,
          ),
        )),
      ),
      inactiveTextStyle: const TextStyle(
        fontSize: 14,
        color: PRIMARY_COLOR,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
