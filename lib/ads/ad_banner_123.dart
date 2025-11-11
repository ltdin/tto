import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news/base/app_helpers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/number.dart';
import 'ad_url_builder.dart';

class AdBanner extends StatefulWidget {
  final String zone;
  final String channel;
  final double rate;

  const AdBanner({key,  @required this.zone, @required this.channel, @required this.rate});

  @override
  AdBannerState createState() => AdBannerState();
}

class AdBannerState extends State<AdBanner> {
  InAppWebViewController webViewController;
  bool isLoading = true;
  bool isVisible = true; // Điều khiển hiển thị quảng cáo
 double maxWidth = 300;  // Giá trị mặc định
  double maxHeight = 250; // Giá trị mặc định

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Khi quay lại app, reload lại InAppWebView để fix trắng
      webViewController?.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    final adUrl = /*'https://flutter.dev';*/AdUrlBuilder.buildUrl(zone: widget.zone, channel: widget.channel);
    debugPrint("🔹 Quảng cáo hiển thị với URL: $adUrl");

    return Visibility(
      visible: isVisible,
      child: LayoutBuilder(
        builder: (context, constraints) {
           maxWidth = constraints.maxWidth;
          maxHeight = maxWidth * widget.rate; // Tỷ lệ 300x250 mặc định

          return SizedBox(
             width: maxWidth,
            height: maxHeight,
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(adUrl)),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                       verticalScrollBarEnabled: false, // Ẩn thanh cuộn dọc
  horizontalScrollBarEnabled: false, // Ẩn thanh cuộn ngang
                        transparentBackground: true,
                      javaScriptEnabled: true,
                      javaScriptCanOpenWindowsAutomatically: true,
                      useShouldOverrideUrlLoading: true,
                    ),
                    // android: AndroidInAppWebViewOptions(useWideViewPort: true),
                    android: AndroidInAppWebViewOptions(
                      useWideViewPort: true,
                      useHybridComposition: true, // fix trắng screen khi resume
                    ),
                    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                    setState(() {
                      webViewController.reload();
                    });
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    final url = navigationAction.request.url.toString();
                    debugPrint("🔹 Người dùng nhấn vào: $url");

                    if (_handleAdEvent(url)) {
                      return NavigationActionPolicy.CANCEL;
                    }

                    if (url != adUrl) {
                      openFullScreenAd(url);
                      return NavigationActionPolicy.CANCEL;
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) {
                    if (mounted && isLoading) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
                // if (isLoading)
                //   Positioned.fill(
                //     child: Image.asset(
                //       'assets/images/ads_bk_300x250.jpg',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
              ],
            ),
          );
        },
      ),
    );
  }

bool _handleAdEvent(String url) {
  printDebug('da vào');
  Uri uri = Uri.parse(url);
  if (uri == null || !uri.scheme.startsWith("apptuoitre")) return false;

  final fullUrl = uri.toString(); // Lấy full URL để kiểm tra
  final queryParams = uri.queryParameters;
  final zoneId = queryParams["zone_id"] ?? "";

  debugPrint("🔹 Nhận sự kiện từ WebView: $fullUrl");
  debugPrint("📌 Full Path: ${uri.path}, Zone ID: $zoneId");

  if (fullUrl.contains("ads_response")) {
    debugPrint("✅ Quảng cáo hiển thị thành công (zone: $zoneId)");
    return true;
  } else if (fullUrl.contains("ads_errors") || fullUrl.contains("ads_close")) {
    debugPrint("❌ Quảng cáo lỗi hoặc người dùng đóng (zone: $zoneId)");
    setState(() {
      isVisible = false; // Ẩn WebView
    });
    return true;
  }

  debugPrint("⚠ Không nhận diện được event: $fullUrl");
  return false;
}

  /// Xử lý mở quảng cáo toàn màn hình
  Future<void> openFullScreenAd(String url) async {
    debugPrint("🔹 Xử lý mở URL: $url");

    if (_isHttpOrHttps(url)) {
      debugPrint("🌍 Mở link HTTP/HTTPS: $url");
      await _launchUrl(url);
      return;
    }

    if (url.startsWith("intent://")) {
      debugPrint("📲 Mở ứng dụng bằng Intent: $url");
      await _openIntentUrl(url);
      return;
    }

    debugPrint("📲 Mở deep link: $url");
    await _launchDeepLink(url);
  }

  /// Mở URL chung (cho HTTP, HTTPS, hoặc Deep Link)
  Future<void> _launchUrl(String url) async {
    if (url.isEmpty || !Uri.tryParse(url).hasAbsolutePath ?? false) {
      debugPrint("❌ URL không hợp lệ: $url");
      return;
    }

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("❌ Không thể mở: $url");
    }
  }

  /// Xử lý mở Intent URL trên Android
  Future<void> _openIntentUrl(String intentUrl) async {
    final scheme = _parseScheme(intentUrl);
    final packageName = _parsePackage(intentUrl);
    final fallbackUrl = _parseFallback(intentUrl);
    final path = _parseIntentPath(intentUrl);

    debugPrint("✅ scheme: $scheme");
    debugPrint("✅ packageName: $packageName");
    debugPrint("✅ fallbackUrl: $fallbackUrl");
    debugPrint("✅ path: $path");

    final deepLink = '$scheme://$path';
    if (scheme.isNotEmpty && await canLaunchUrl(Uri.parse(deepLink))) {
      debugPrint("🚀 Mở app qua deep link: $deepLink");
      await launchUrl(Uri.parse(deepLink), mode: LaunchMode.externalApplication);
      return;
    }

    if (packageName.isNotEmpty) {
      final marketUrl = 'market://details?id=$packageName';
      if (await canLaunchUrl(Uri.parse(marketUrl))) {
        debugPrint("💡 Fallback mở Google Play: $marketUrl");
        await launchUrl(Uri.parse(marketUrl));
        return;
      }
    }

    if (fallbackUrl.isNotEmpty) {
      debugPrint("💡 Fallback mở link web: $fallbackUrl");
      await _launchUrl(fallbackUrl);
    } else {
      debugPrint("❌ Không thể xử lý Intent URL: $intentUrl");
    }
  }

  /// Xử lý mở deep link ngoài app
  Future<void> _launchDeepLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("❌ Không thể mở deep link: $url");
    }
  }

  /// Kiểm tra URL có phải HTTP/HTTPS
  bool _isHttpOrHttps(String url) {
    return url.startsWith("http://") || url.startsWith("https://");
  }

  /// Parse scheme từ intent
  String _parseScheme(String intentUrl) {
    final match = RegExp(r'scheme=([a-zA-Z0-9._]+);').firstMatch(intentUrl);
    return match?.group(1) ?? '';
  }

  /// Parse package từ intent
  String _parsePackage(String intentUrl) {
    final match = RegExp(r'package=([a-zA-Z0-9._]+);').firstMatch(intentUrl);
    return match?.group(1) ?? '';
  }

  /// Parse fallback URL trong intent
  // String _parseFallback(String intentUrl) {
  //   final match = RegExp(r'S\.browser_fallback_url=(.*?);').firstMatch(intentUrl);
  //   return match?.group(1)?.replaceAll(';end', '').trim() ?? '';
  // }
String _parseFallback(String intentUrl) {
  final match = RegExp(r'S\.browser_fallback_url=(.*?);').firstMatch(intentUrl);
  final fallbackUrl = match?.group(1);
  return fallbackUrl != null ? fallbackUrl.replaceAll(';end', '').trim() : '';
}
  /// Lấy path từ intent://
  String _parseIntentPath(String intentUrl) {
    final startIndex = 'intent://'.length;
    final endIndex = intentUrl.indexOf('#Intent;');
    return (endIndex > startIndex) ? intentUrl.substring(startIndex, endIndex) : '';
  }
}