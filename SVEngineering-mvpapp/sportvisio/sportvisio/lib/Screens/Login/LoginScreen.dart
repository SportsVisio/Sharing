import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Widgets/CustomBorderButton.dart';
import 'package:sportvisio/Widgets/CustomTextField.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/User.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/core/helpers/user_service.dart';
import 'package:sportvisio/core/view_models/Cognito_viewModel.dart';
import 'package:sportvisio/core/view_models/login_viewModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  bool isLoginButtonDisable = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController =
      new TextEditingController(text: "keeano@sportsvisio.com");
  TextEditingController passwordController = new TextEditingController();
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _loading = false;
  UserServiceViewModel _userService = UserServiceViewModel();
  User _user = User();
  bool _isAuthenticated = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<UserServiceViewModel> _getValues() async {
    await _userService.init();
    _isAuthenticated = await _userService.checkAuthenticated();
    return _userService;
  }

  submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool emailValid = emailRegExp.hasMatch(nameController.text);
      if (emailValid) {
        _formKey.currentState!.save();
        String message = '';
        setState(() {
          _loading = true;
        });
        try {
          var s = nameController.text;

          var usernameFromEmail = s.substring(0, s.indexOf('@'));
          var payload =
              'username=${nameController.text}&password=${passwordController.text}';
          await _userService.userLogin(payload).then((value) async {
            setState(() {
              _loading = false;
            });

            var jsonData = json.decode(value.body);
            print(value.statusCode.toString());

            if (value.statusCode == 200 || value.statusCode == 201) {
              var pref = await SharedPreferences.getInstance();
              pref.setString("token", jsonData['token']!);
              pref.setString("name", jsonData['firstName']);
              pref.setString("password", passwordController.text);
              pref.setString("id", jsonData['userId']);
              message = 'Login Successfully';

              pref.setBool("islogin", true);

              print(_user.token.toString());
              _navigationService.navigateTo(AppRoutes.MAIN_MENU);

              print(jsonData['token'].toString());
            } else {
              message = jsonData['message'];
            }
          });

          //   _user = (await _userService.login(
          //       usernameFromEmail, passwordController.text))!;
          //   setState(() {
          //     _loading = false;
          //   });

          //   var pref = await SharedPreferences.getInstance();
          //   pref.setString("token", _user.token!);
          //   pref.setString("name", nameController.text);
          //   pref.setString("password", passwordController.text);
          //   pref.setBool("islogin", true);

          //   print(_user.token.toString());
          //   _navigationService.navigateTo(AppRoutes.MAIN_MENU);

          //   message = 'success';
          //   if (!_user.confirmed) {
          //     message = 'Please confirm user account';
          //   }
          // } on CognitoClientException catch (e) {
          //   if (e.code == 'InvalidParameterException' ||
          //       e.code == 'NotAuthorizedException' ||
          //       e.code == 'UserNotFoundException' ||
          //       e.code == 'ResourceNotFoundException') {
          //     message = e.message!;
          //   } else {
          //     message = 'An unknown client error occured';
          //   }
        } catch (e) {
          message = 'An unknown error occurred';
        }
        print(message);
        setState(() {
          _loading = false;
        });
        if (message != 'success') {
          _toastService.showToast(context, message);
        }
      } else {
        _toastService.showToast(context, "Invalid Email");
      }
    }
  }

  @override
  Widget build(BuildContext context1) {
    var size = MediaQuery.of(context).size;
    return Consumer<UserServiceViewModel>(builder: (context, viewModel, child) {
      _userService = viewModel;
      return Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          child: Container(
            width: size.width,
            height: size.height,
            //  padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/backgroundwithbanner.png"))),
            child: Column(
              children: [
                // AppBar(
                //   backgroundColor: Colors.red,
                //   elevation: 0,
                // ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Spacer(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'regu',
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        UIHelper.verticalSpaceMd,
                        SportsVisioFormField(
                          controller: nameController,
                          hint: "Email",
                        ),
                        UIHelper.verticalSpaceSm,
                        SportsVisioFormField(
                          controller: passwordController,
                          hint: "Password",
                          isObscure: true,
                        ),
                        UIHelper.verticalSpaceMd,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              splashColor: Colors.transparent,
                              onPressed: () {
                                _navigationService
                                    .navigateTo(AppRoutes.RESET_PASSWORD);
                              },
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                    color: Constants.blueColor,
                                    fontSize: 18,
                                    fontFamily: "regu"),
                              ),
                            ),
                            // Container(
                            //   width: 2,
                            //   height: 10,
                            //   color: Constants.blueColor,
                            // ),
                            // MaterialButton(
                            //   splashColor: Colors.transparent,
                            //   onPressed: () {},
                            //   child: Text(
                            //     "Forgot Password",
                            //     style: TextStyle(
                            //         color: Color(0xFF0055FF),
                            //         fontSize: 18,
                            //         fontFamily: "regu"),
                            //   ),
                            // ),
                          ],
                        ),
                        MaterialButton(
                            disabledColor:
                                Constants.darkOrangeColor.withOpacity(0.35),
                            color: Constants.darkOrangeColor,
                            minWidth: size.width,
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: _loading
                                ? null
                                : () {
                                    submit(context1);
                                    //    viewModel.performLogin();
                                    // _navigationService.navigateTo(AppRoutes.MAIN_MENU);
                                  },
                            child: Container(
                              alignment: Alignment(0.05, 0.13),
                              child: _loading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Login',
                                          style: TextStyle(
                                            fontFamily: 'bold',
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            height: 1.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Login',
                                      style: TextStyle(
                                        fontFamily: 'bold',
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        height: 1.0,
                                      ),
                                    ),
                            )),

                        SizedBox(height: 10),
                        // Container(
                        //   alignment: Alignment(0.05, 0.13),
                        //   width: size.width,
                        //   height: 50.0,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     color: Constants.darkOrangeColor.withOpacity(0.25),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.black.withOpacity(0.08),
                        //         offset: Offset(0, 3.0),
                        //         blurRadius: 6.0,
                        //       ),
                        //     ],
                        //   ),
                        //   child: Text(
                        //     'Login',
                        //     style: TextStyle(
                        //       fontFamily: 'regu',
                        //       fontSize: 20.0,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w700,
                        //       height: 1.0,
                        //     ),
                        //   ),
                        // ),

                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: MaterialButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              _navigationService.navigateTo(AppRoutes.REGISTER);
                            },
                            child: Text(
                              "Register for a new account",
                              style: TextStyle(
                                  color: Constants.blueColor,
                                  fontSize: 18,
                                  fontFamily: "regu"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// class Component25 extends StatelessWidget {
//   const Component25({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment(0.05, 0.13),
//       width: 261.0,
//       height: 50.0,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: AppColors.color3.withOpacity(0.25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             offset: Offset(0, 3.0),
//             blurRadius: 6.0,
//           ),
//         ],
//       ),
//       child: Text(
//         'Login',
//         style: TextStyle(
//           fontFamily: 'Calibri',
//           fontSize: 20.0,
//           color: AppColors.color2,
//           fontWeight: FontWeight.w700,
//           height: 2.0,
//         ),
//       ),
//     );
//   }
// }
