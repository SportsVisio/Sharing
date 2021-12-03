// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify.dart';
// import 'package:box_ui/box_ui.dart';
// import 'package:flutter/material.dart';
// import 'package:sports_visio/navigation_service.dart';
// import 'package:sports_visio/screens/user_details_screen.dart';
// import 'package:flutter/services.dart';
//
// class SignInScreen extends StatefulWidget {
//   static const TAG = "SIGN_IN";
//
//   const SignInScreen({Key key}) : super(key: key);
//
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//
//   static const platformMethodChannel =
//   const MethodChannel('sports/stream');
//   String _idToken;
//   String _accessToken;
//   Future<Null> _sendTokenToNative() async {
//     String batteryLevel;
//     try {
//       final String result =
//       await platformMethodChannel.invokeMethod('sendToken', {"idToken": "_idToken","accessToken":"_accessToken"});
//       //  batteryLevel = 'Battery level at $result % .';
//     } on PlatformException catch (e) {
//       //  batteryLevel = "Failed to get battery level: '${e.message}'.";
//     }
//
//     setState(() {});
//   }
//
//   final usernameController = TextEditingController(text: 'iamuser2');
//   final passwordController = TextEditingController(text:'Test@123');
//   final signInFormKey = GlobalKey<FormState>();
//
//   bool isSignedIn = false;
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Form(
//           key: signInFormKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               BoxInputField(
//                 controller: usernameController,
//                 placeholder: "Username",
//               ),
//               BoxInputField(
//                 controller: passwordController,
//                 placeholder: "Password",
//                 password: true,
//               ),
//               BoxButton(
//                 title: 'Register',
//                 busy: isLoading,
//                 onTap: performSignIn,
//               ),
//               BoxButton(
//                   title: 'Open iOS App',
//                   onTap: openNativeApp
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   toggleLoading() => setState(() => isLoading = !isLoading);
//
//   void openNativeApp() async{
//       print("Opening iOS App");
//       _sendTokenToNative();
//   }
//
//   void performSignIn() async {
//     toggleLoading();
//     try {
//       SignInResult res = await Amplify.Auth.signIn(
//         username: usernameController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       setState(() {
//         isSignedIn = res.isSignedIn;
//       });
//       NavigationService.replace(UserDetailsScreen.TAG);
//     } on AuthException catch (e) {
//       Amplify.Auth.signOut().then((value) => performSignIn());
//       print(e.message);
//     }finally{
//       toggleLoading();
//     }
//   }
// }
