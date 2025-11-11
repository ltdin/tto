import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import 'package:news/base/app_theme.dart';

class PageDetailWebviewCustomTab {
  /// Open with custom tab
  static void launch({String url}) {
    final toolbarColor = AppTheme().currentTheme.indicatorColor;

    try {
      custom_tabs.launch(
        url,
        customTabsOption: custom_tabs.CustomTabsOption(
          headers: const {
            'content-type': 'text/plain',
          },
          toolbarColor: toolbarColor,
          showPageTitle: true,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          animation: custom_tabs.CustomTabsSystemAnimation.slideIn(),
          enableInstantApps: true,
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx'
          ],
        ),
        safariVCOption: custom_tabs.SafariViewControllerOption(
          // preferredBarTintColor: toolbarColor,
          preferredControlTintColor: Colors.black,
          barCollapsingEnabled: false,
          entersReaderIfAvailable: false,
          dismissButtonStyle:
              custom_tabs.SafariViewControllerDismissButtonStyle.done,
        ),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
