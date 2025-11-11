// import 'package:flutter/material.dart';
// import 'package:news/api/http_utility.dart';
// import 'package:news/base/app_helpers.dart';
// import 'package:news/base/app_netcore.dart';
// import 'package:news/blocs/auth_bloc.dart';
// import 'package:news/constant/font.dart';
// import 'package:news/constant/string.dart';
// import 'package:news/widgets/appbar_for_tab.dart';

// class RegisterPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => RegisterPageState();
// }

// class RegisterPageState extends State<RegisterPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passController = TextEditingController();
//   final TextEditingController _repeatPassController = TextEditingController();
//   FocusScopeNode focusNode = FocusScopeNode();

//   @override
//   Widget build(BuildContext context) {
//     printDebug('==================== Build Register Page ====================');
//     focusNode = FocusScope.of(context);

//     return Scaffold(
//         appBar: appBarWidget(title: KString.strRegister),
//         body: Container(
//           constraints: BoxConstraints.expand(),
//           padding: EdgeInsets.only(top: 48, left: 24, right: 24),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 // Input nick name
//                 TextField(
//                   controller: _nameController,
//                   keyboardType: TextInputType.text,
//                   decoration: new InputDecoration(
//                       prefixIcon: Container(
//                         width: 50,
//                         child: Image.asset(
//                           "assets/icons/ic_account_bottombar.png",
//                           scale: 0.9,
//                           color: Colors.red,
//                         ),
//                       ),
//                       hintText: 'Nick name của bạn',
//                       labelText: 'Name',
//                       errorText: authBloc.errorName,
//                       labelStyle: KfontConstant.SFDisplayRegular14),
//                   style: KfontConstant.SFDisplayRegular14,
//                 ),

//                 // Input email
//                 TextField(
//                   controller: _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: new InputDecoration(
//                     prefixIcon: Container(
//                       width: 50,
//                       child:
//                           Image.asset("assets/icons/ic_email.png", scale: 2.5),
//                     ),
//                     hintText: 'Email của bạn',
//                     labelText: 'Email',
//                     errorText: authBloc.errorEmailRegister,
//                     labelStyle: KfontConstant.SFDisplayRegular14,
//                   ),
//                   style: KfontConstant.SFDisplayRegular14,
//                 ),

//                 // Input pass
//                 TextField(
//                   controller: _passController,
//                   obscureText: true, // Use secure text for passwords.
//                   decoration: new InputDecoration(
//                       prefixIcon: Container(
//                         width: 50,
//                         child: Image.asset("assets/icons/ic_key_pass.png",
//                             scale: 2.5),
//                       ),
//                       hintText: 'Mật khẩu',
//                       errorText: authBloc.errorPass,
//                       labelStyle: KfontConstant.SFDisplayRegular14),
//                   style: KfontConstant.SFDisplayRegular14,
//                 ),

//                 // Input repeat pass
//                 TextField(
//                   controller: _repeatPassController,
//                   obscureText: true, // Use secure text for passwords.
//                   decoration: new InputDecoration(
//                       prefixIcon: Container(
//                         width: 50,
//                         child: Image.asset("assets/icons/ic_key_pass.png",
//                             scale: 2.5),
//                       ),
//                       hintText: 'Nhập Lại Mật khẩu',
//                       errorText: authBloc.errorRepeatPass,
//                       labelStyle: KfontConstant.SFDisplayRegular14),
//                   style: KfontConstant.SFDisplayRegular14,
//                 ),

//                 // Action register
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(24, 30, 24, 40),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: ElevatedButton(
//                       onPressed: () => _onRegisterClick(context),
//                       child: Text(
//                         "Đăng Ký",
//                         style: KfontConstant.SFDisplayRegularWhite20,
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.red,
//                         // backgroundColor: Colors.red,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(6)),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }

//   void _onRegisterClick(BuildContext context) {
//     // Create value for register
//     final name = _nameController.text;
//     final email = _emailController.text;
//     final pass = _passController.text;
//     final repeatPass = _repeatPassController.text;

//     // Hide key board
//     AppHelpers.hideKeyboard(focusNode);

//     // Valid value before register
//     if (authBloc.isValidRegister(name, email, pass, repeatPass)) {
//       AppHelpers.onLoading(context, true);

//       // Update profile for Netcore
//       final map = {"name": name, "email": email};
//       AppNetcore().UpdateUserProfile(map: map);

//       // Call register
//       authBloc.registerBloc(name, email, pass).then((data) async {
//         AppHelpers.onLoading(context, false);

//         // Show success when register success
//         if (data.status == StatusRequest.SUCCESS) {
//           AppHelpers.showToast(
//               text: KString.msgRegisterSuccess, isError: false);

//           // Set user Id for Netcore
//           AppNetcore().SetUserIdentity(id: email);

//           // Back to login page
//           await Future.delayed(
//               const Duration(seconds: 1), () => Navigator.pop(context));
//         } else {
//           AppHelpers.showToast(text: KString.msgRegisterFaild, isError: true);
//         }
//       });
//     }
//   }
// }
