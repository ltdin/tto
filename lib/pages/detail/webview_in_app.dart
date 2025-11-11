// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:share/share.dart';
// import 'package:wpn_app/base/app_config.dart';
// import 'package:wpn_app/routes/ippan_route/ippan_route_bloc.dart';
// import 'package:wpn_app/routes/route_arguments.dart';
// import 'package:wpn_app/ui/widgets/linear_progress_indicator_widget.dart';
// import 'package:wpn_app/v2/webike_plus/widget/font_slider_widget.dart';
// import 'package:wpn_app/v2/webike_plus/widget/icon_text_size_appbar.dart';
// import 'package:wpn_app/v2/webview_in_app/bloc/webview_inapp_bloc.dart';

// class WebViewInApp extends StatefulWidget {
//   const WebViewInApp({Key key}) : super(key: key);

//   @override
//   _WebViewInAppState createState() => _WebViewInAppState();
// }

// class _WebViewInAppState extends State<WebViewInApp>
//     with SingleTickerProviderStateMixin, AfterLayoutMixin<WebViewInApp> {
//   String _url = 'https://wpn-api.webike.net';
//   String _webTitle = 'ウェバイク';
//   bool _canGoBack = false;
//   bool _isHideSilderTextSize = false;
//   bool _runChangeDependencies = true;
//   AnimationController _animationController;
//   Animation<double> _animation;
//   double _fontSizeWebview = AppConfig.storage.sizeDetailWebviewSetting;
//   InAppWebViewController _webViewController;
//   final blocWebView = WebViewInAppBloc();

//   @override
//   void initState() {
//     AppConfig.debug('InitState WebViewInApp');

//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//     _animation =
//         CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     AppConfig.debug('didChangeDependencies WebViewInApp');

//     if (_runChangeDependencies) {
//       final args = ModalRoute.of(context).settings.arguments as RouteArguments;

//       if (args?.data?.containsKey('url') ?? false) {
//         _url = args.data['url'] as String;
//       }

//       if (args?.data?.containsKey('title') ?? false) {
//         _webTitle = args.data['title'] as String;
//       }

//       _runChangeDependencies = false;
//     }

//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);

//     return BlocProvider<WebViewInAppBloc>(
//       create: (context) => blocWebView,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           centerTitle: true,
//           leading: Builder(
//             builder: (BuildContext context) {
//               return IconButton(
//                 iconSize: 32,
//                 icon: const Icon(Icons.clear),
//                 onPressed: () => _closeScreen(context),
//               );
//             },
//           ),
//           title: BlocSelector<WebViewInAppBloc, WebViewInAppState, bool>(
//             selector: (state) {
//               return state is WebViewLoadedSuccess;
//             },
//             builder: (context, visibled) {
//               return Row(
//                 children: [
//                   // Icon page back
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back_ios),
//                     onPressed: _canGoBack ? () => _handleBackWebView() : null,
//                   ),

//                   // Title + link
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             _webTitle,
//                             style: _theme.textTheme.titleMedium,
//                             maxLines: 1,
//                           ),
//                           Text(
//                             _url,
//                             style: _theme.textTheme.bodySmall,
//                             maxLines: 1,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//           actions: [
//             if (Platform.isAndroid)
//               IconTextSizeAppbar(
//                 onClickIcon: () {
//                   if (_isHideSilderTextSize == true) {
//                     _animationController.reverse();
//                     setState(() {
//                       _isHideSilderTextSize = false;
//                     });
//                   } else {
//                     _animationController.forward();
//                     setState(() {
//                       _isHideSilderTextSize = true;
//                     });
//                   }
//                 },
//               ),

//             // Icon share
//             BlocSelector<WebViewInAppBloc, WebViewInAppState, bool>(
//               selector: (state) {
//                 return state is WebViewLoadedSuccess;
//               },
//               builder: (context, visibled) => IconButton(
//                 icon: Platform.isIOS
//                     ? const Icon(Icons.ios_share)
//                     : const Icon(Icons.share),
//                 onPressed: checkCanShareUrl
//                     ? () {
//                         Share.share(_url, subject: _webTitle);
//                       }
//                     : null,
//               ),
//             )
//           ],
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               // Content webview
//               Column(
//                 children: [
//                   // Progress indicator
//                   BlocSelector<WebViewInAppBloc, WebViewInAppState, bool>(
//                     selector: (state) {
//                       return state is WebViewLoading;
//                     },
//                     builder: (context, visibled) => visibled
//                         ? const LinearProgressIndicatorWidget()
//                         : const Offstage(),
//                   ),

//                   // Webview
//                   Expanded(
//                     child: InAppWebView(
//                       initialUrlRequest: URLRequest(
//                         url: Uri.tryParse(_url),
//                         headers: {
//                           'User-Agent': AppConfig.userAgent
//                               .replaceAll(RegExp(r'[^\u0001-\u007F]'), '_'),
//                           'X-App-Bundle': AppConfig.packageInfo?.packageName,
//                           'X-App-Version': AppConfig.version,
//                         },
//                       ),
//                       initialOptions: getGroupOptions,
//                       onWebViewCreated: (InAppWebViewController controller) {
//                         _webViewController = controller;
//                       },
//                       onLoadStart:
//                           (InAppWebViewController controller, Uri url) async {
//                         // Update url
//                         _url = url.toString().trimLeft();

//                         // Call show loading when begin load Uri
//                         blocWebView.add(const ShowLoadingInWebViewEvent());
//                       },
//                       androidOnPermissionRequest:
//                           (controller, origin, resources) async {
//                         return PermissionRequestResponse(
//                           resources: resources,
//                           action: PermissionRequestResponseAction.GRANT,
//                         );
//                       },
//                       onLoadStop:
//                           (InAppWebViewController controller, Uri url) async {
//                         // Update url and method canGoBack
//                         _canGoBack = await controller.canGoBack();
//                         _webTitle = (await controller.getTitle()).trimLeft();
//                         _url = url.toString().trimLeft();

//                         // Call bloc update url + loading bar
//                         blocWebView.add(const LoadWebViewSuccessEvent());
//                         AppConfig.debug('WebViewLoadedSuccess : $_url');
//                       },

//                       // Handle open new tab
//                       onCreateWindow: (InAppWebViewController controller,
//                           CreateWindowAction createWindowRequest) async {
//                         AppConfig.debug('\nonCreateWindow');

//                         // Open popup : for Android
//                         if (Platform.isAndroid) {
//                           _openPopupForAndroid(createWindowRequest);
//                         }

//                         // Open popup : for Ios
//                         if (Platform.isIOS) {
//                           _openPopupForIos(createWindowRequest);
//                         }

//                         return true;
//                       },
//                       onLoadError: (
//                         InAppWebViewController controller,
//                         Uri url,
//                         int code,
//                         String message,
//                       ) =>
//                           _onReloadWebView(
//                         errorTitle: 'onLoadError',
//                         errorMessage: message,
//                       ),
//                       onLoadHttpError: (
//                         InAppWebViewController controller,
//                         Uri url,
//                         int code,
//                         String message,
//                       ) =>
//                           _onReloadWebView(
//                         errorTitle: 'onLoadHttpError',
//                         errorMessage: message,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // Layer overide for Android
//               if (Platform.isAndroid) ...[
//                 Visibility(
//                   visible: _isHideSilderTextSize,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           child: Container(
//                             constraints: const BoxConstraints.expand(),
//                             color: Colors.black26,
//                           ),
//                           onTapDown: (details) {
//                             setState(() {
//                               _isHideSilderTextSize = false;
//                               _animationController.reverse();
//                             });
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizeTransition(
//                   axisAlignment: 1.0,
//                   sizeFactor: _animation,
//                   child: FontSilderWidget(
//                     value: _fontSizeWebview,
//                     textStyle: Theme.of(context).textTheme.bodyText1,
//                     onChanged: (double newValue) {
//                       // Update value foe sizeDetailWebviewSetting
//                       AppConfig.storage.sizeDetailWebviewSetting = newValue;

//                       setState(() {
//                         _fontSizeWebview = newValue;
//                       });

//                       // Set textZoom for webview
//                       _webViewController.setOptions(options: getGroupOptions);
//                     },
//                   ),
//                 ),
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Function
//   void _onReloadWebView({String errorTitle, String errorMessage}) {
//     AppConfig.debug('$errorTitle : $errorMessage');

//     // Call reload webview
//     _webViewController.reload();
//   }

//   int getTextZoom(double fontSize) {
//     return (_fontSizeWebview * 10 + 120).abs().toInt();
//   }

//   void _handleBackWebView() {
//     if (_canGoBack) {
//       _webViewController.goBack();
//     }
//   }

//   void _closeScreen(context) {
//     if (Navigator.of(context).canPop()) {
//       Navigator.of(context).pop();
//     }
//   }

//   void _openPopupForAndroid(CreateWindowAction createWindowRequest) {
//     _openPopupWithWindowId(createWindowRequest);
//   }

//   void _openPopupForIos(CreateWindowAction createWindowRequest) {
//     final _urlRequest = '${createWindowRequest.request.url}';

//     // Check url request is special
//     final isSpecialForm = isContactusSpecialForm(url: _urlRequest);

//     // Check submit special form
//     if (isSpecialForm) {
//       final _referer = createWindowRequest.request.headers['Referer'];
//       final _sysCode =
//           _referer.replaceAll('/', ' ').trimRight().split(' ').last;

//       BlocProvider.of<IppanRouteBloc>(context).add(
//         ToIppanPopupInAppWebView(
//           url: _urlRequest,
//           request: URLRequest(
//             headers: createWindowRequest.request.headers,
//             url: Uri.tryParse(_urlRequest),
//             body: Uint8List.fromList(utf8.encode('form.sysCode=$_sysCode')),
//             method: createWindowRequest.request.method,
//             iosHttpShouldHandleCookies: true,
//             iosHttpShouldUsePipelining: false,
//             iosAllowsCellularAccess: true,
//             iosAllowsConstrainedNetworkAccess: true,
//             iosAllowsExpensiveNetworkAccess: true,
//             iosCachePolicy: IOSURLRequestCachePolicy.USE_PROTOCOL_CACHE_POLICY,
//             iosNetworkServiceType: IOSURLRequestNetworkServiceType.DEFAULT,
//             iosMainDocumentURL: Uri.tryParse(_urlRequest),
//           ),
//         ),
//       );
//     } else {
//       _openPopupWithWindowId(createWindowRequest);
//     }
//   }

//   void _openPopupWithWindowId(CreateWindowAction createWindowRequest) {
//     BlocProvider.of<IppanRouteBloc>(context).add(
//       ToIppanPopupInAppWebView(
//         windowId: createWindowRequest.windowId,
//         url: '${createWindowRequest.request.url ?? ''}',
//       ),
//     );
//   }

//   bool isContactusSpecialForm({String url}) {
//     return url.contains('/wbs/contactus-syouhin-detail.html') ||
//         url.contains('/wbs/contactus-fitmodel.html') ||
//         url.contains('/wbs/delivery-estimate.html');
//   }

//   /// Get + set
//   bool get checkCanShareUrl => !_url.contains('monoris9');

//   InAppWebViewGroupOptions get getGroupOptions => InAppWebViewGroupOptions(
//         crossPlatform: InAppWebViewOptions(
//           // Set this to true if you are using window.open to open a new window with JavaScript
//           javaScriptCanOpenWindowsAutomatically: true,

//           // Clear cache
//           clearCache: true,
//           javaScriptEnabled: true,
//           useOnDownloadStart: true,
//           useOnLoadResource: true,
//           preferredContentMode: UserPreferredContentMode.MOBILE,
//           mediaPlaybackRequiresUserGesture: true,
//           allowFileAccessFromFileURLs: true,
//           allowUniversalAccessFromFileURLs: true,
//         ),
//         android: AndroidInAppWebViewOptions(
//           textZoom: getTextZoom(_fontSizeWebview),
//           useHybridComposition: true,

//           // On Android you need to set supportMultipleWindows to true, otherwise the onCreateWindow event won't be called
//           supportMultipleWindows: true,
//           thirdPartyCookiesEnabled: true,
//         ),
//         ios: IOSInAppWebViewOptions(
//           allowsInlineMediaPlayback: true,
//           applePayAPIEnabled: true,
//           sharedCookiesEnabled: true,
//           allowsAirPlayForMediaPlayback: true,
//           suppressesIncrementalRendering: true,
//           ignoresViewportScaleLimits: true,
//           selectionGranularity: IOSWKSelectionGranularity.DYNAMIC,
//           enableViewportScale: true,
//           automaticallyAdjustsScrollIndicatorInsets: true,
//           useOnNavigationResponse: true,
//         ),
//       );

//   @override
//   void dispose() {
//     AppConfig.debug('dispose');
//     _animationController.dispose();
//     _webViewController.stopLoading();
//     super.dispose();
//   }

//   @override
//   Future<void> afterFirstLayout(BuildContext context) async {
//     if (Platform.isAndroid) {
//       await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

//       final swAvailable = await AndroidWebViewFeature.isFeatureSupported(
//           AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
//       final swInterceptAvailable =
//           await AndroidWebViewFeature.isFeatureSupported(
//               AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

//       if (swAvailable && swInterceptAvailable) {
//         final AndroidServiceWorkerController serviceWorkerController =
//             AndroidServiceWorkerController.instance();

//         await serviceWorkerController
//             .setServiceWorkerClient(AndroidServiceWorkerClient(
//           shouldInterceptRequest: (request) async {
//             print(request);
//             return null;
//           },
//         ));
//       }

//       // Permission : Fix problem choose image on some divices
//       await Permission.camera.request();
//       await Permission.photos.request();
//       await Permission.mediaLibrary.request();
//     }
//   }
// }
