// /*
// import 'dart:math';
//
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class UserDetailsScreen extends StatefulWidget {
//   static const TAG = "USER_DETAILS";
//
//
//   @override
//   _UserDetailsScreenState createState() => _UserDetailsScreenState();
// }
//
// class _UserDetailsScreenState extends State<UserDetailsScreen> {
//   static const platformMethodChannel =
//   const MethodChannel('sports/stream');
//   String _idToken;
//   String _accessToken;
//   Future<Null> _sendTokenToNative() async {
//     String batteryLevel;
//     try {
//       final String result =
//       await platformMethodChannel.invokeMethod('sendToken', {"idToken": _idToken,"accessToken":_accessToken});
//     //  batteryLevel = 'Battery level at $result % .';
//     } on PlatformException catch (e) {
//     //  batteryLevel = "Failed to get battery level: '${e.message}'.";
//     }
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder(
//               future: Amplify.Auth.fetchUserAttributes(),
//               builder:
//                   (context, AsyncSnapshot<List<AuthUserAttribute>> snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       AuthUserAttribute authUserAttribute = snapshot.data[index];
//                       return ListTile(
//                         title: Text(authUserAttribute.userAttributeKey),
//                         subtitle: Text(authUserAttribute.value.toString()),
//                       );
//                     },
//                     itemCount: snapshot.data.length,
//                   );
//                   print('hasData');
//                 } else if (snapshot.hasError) {
//                   print('hasError');
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 return Container();
//               },
//             ),
//             FutureBuilder(
//               future: Amplify.Auth.fetchAuthSession(
//                   options: CognitoSessionOptions(getAWSCredentials: true)),
//               builder: (context, AsyncSnapshot<AuthSession> snapshot) {
//                 if (snapshot.hasData) {
//                   CognitoAuthSession data = snapshot.data as CognitoAuthSession;
//                   _idToken = data.userPoolTokens.idToken;
//                   _accessToken =data.userPoolTokens.accessToken;
//                   return Column(
//                     children: [
//                       ListTile(
//                         title: Text('Id token'),
//                         subtitle: Text(_idToken),
//                       ),
//                       ListTile(
//                         title: Text('Access token'),
//                         subtitle: Text(_accessToken),
//                       ),
//                       MaterialButton(
//
//                         color:Colors.green,
//                         onPressed: _sendTokenToNative,child: Text("send token",style:TextStyle(color:Colors.white)),)
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   print('hasError');
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 return Container();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// */
