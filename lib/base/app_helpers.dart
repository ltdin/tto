import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news/widgets/app_loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news/constant/color.dart';
import 'package:intl/intl.dart';

R lookup<R>(Map map, Iterable keys) {
  dynamic current = map;

  for (final key in keys) {
    if (current is Map) {
      current = current[key];
    } else if (key is int && current is Iterable && current.length > key) {
      current = current.elementAt(key);
    } else {
      return null;
    }
  }

  try {
    if (current is! R) {
      switch (R) {
        case DateTime:
          current = DateTime.tryParse(current?.toString() ?? '')?.toLocal();
          break;
        case num:
          current = num.tryParse(current?.toString() ?? '');
          break;
        case String:
          current = current?.toString();
          break;
      }
    }

    return current as R;
  } on dynamic catch (e) {
    printDebug('message: ${e.toString()}');
  }

  // return null as default
  return null;
}

void printDebug(String text) {
  if (kDebugMode) debugPrint(text);
}

class AppHelpers {
  static String safeString(String s) => s ?? "";

  static int parseInt(dynamic o) {
    if (o == null) return 0;
    return o is int ? o : (int.tryParse(o) ?? 0);
  }

  static String parseString(dynamic o) {
    return o is String ? o : o.toString();
  }

  static String parseArticleIdFromUrl(String url) {
    var _url = Uri.parse(url);
    if (_url.path.isNotEmpty && _url.path.toString().contains('.htm')) {
      return _url.path.split('.').first.split('-').last;
    }
    return null;
  }

  static onOpenLink({String url}) async {
    await launch(url);
  }

  static launchMail(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    onOpenLink(url: url);
  }

  static callPhone({String phone = '+84918033133'}) async {
    await FlutterPhoneDirectCaller.callNumber(phone);
  }

  static void showToast({String text = 'Messege', bool isError = true}) {
    Fluttertoast.showToast(
      msg: '$text',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? PRIMARY_COLOR : SUCCESS_COLOR,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Future<void> showProcessDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AppLoadingIndicator();
      },
    );
  }

  static Future<void> showDialogForWidget(
    BuildContext context, {
    bool barrierDismissible = false,
    Widget widget,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return widget;
      },
    );
  }

  static void onLoading(BuildContext context, bool flag) {
    if (flag) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AppLoadingIndicator();
        },
      );
    } else {
      Navigator.pop(context);
    }
  }

  static String splitACharacters(String text, String characters) {
    return text.split('$characters').toList().join('');
  }

  static void hideKeyboard(dynamic focusNode) {
    if (focusNode is FocusScopeNode) {
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    } else {
      if (focusNode is FocusNode) {
        if (focusNode.hasFocus) {
          focusNode.unfocus();
        }
      }
    }
  }

  static void closeContext(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// Time ago
  String timeAgoSinceDate(DateTime theDate, {DateFormat formatter}) {
    final difference = DateTime.now().difference(theDate);

    if (difference.inDays >= 1) {
      return (formatter ?? DateFormat('MM/dd')).format(theDate);
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} giây trước';
    } else {
      return 'Vừa xong';
    }
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static String getStrDayFromMiliSeconds(int expire) {
    if (expire == null) {
      return 'Đã hết hạn';
    }

    // expire # null
    final dt = DateTime.fromMillisecondsSinceEpoch(expire * 1000);
    final date = DateFormat('dd/MM/yyyy').format(dt);

    return date;
  }

  static String getNowFullDate() {
    DateTime dateTime = DateTime.now();
    String dayOfWeek = DateFormat('EEEE', 'vi_VN').format(dateTime);
    String dayOfMonth = DateFormat('d', 'vi_VN').format(dateTime);
    String month = DateFormat('M').format(dateTime);
    String year = DateFormat('y', 'vi_VN').format(dateTime);

    return '$dayOfWeek, ngày $dayOfMonth tháng $month năm $year';
  }

  static DateTime getDateTimeFromMiliSeconds(int expire) {
    if (expire == null) {
      return DateTime.now();
    }

    // Get time from miliSeconds
    final dt = DateTime.fromMillisecondsSinceEpoch(expire * 1000);

    return dt;
  }

  // Get
  static int get getTimestampCurrentDay {
    final now = DateTime.now();
    return now.millisecondsSinceEpoch ~/ 1000;
  }
}
