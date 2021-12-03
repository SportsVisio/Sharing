import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Screens/Auth/AuthButton.dart';
import 'package:mvp/Screens/Auth/Icon.dart';
import 'package:mvp/Screens/Auth/RegisterScreen.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/ForgotPassword/ForgotPassword.dart';
import 'package:mvp/Screens/ResetPassword/ResetPasswordConfirmScreen.dart';
import 'package:mvp/Widgets/FlipLoadinBar.dart';
import 'package:mvp/Widgets/sportsvisio_form_field.dart';
import 'package:mvp/app/app_routes.dart';
import 'package:mvp/app/locator.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/constants/PreferencesManager.dart';
import 'package:mvp/core/helpers/User.dart';
import 'package:mvp/core/helpers/auth_helper.dart';
import 'package:mvp/core/helpers/navigation_helper.dart';
import 'package:mvp/core/helpers/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController =
      new TextEditingController(text: "scott@sportsvisio.com");
  // text: "scott@sportsvisio.com"
  TextEditingController passwordController =
      new TextEditingController(text: "welcome12345");
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _loading = false;
  UserServiceViewModel _userService = UserServiceViewModel();

  submit(BuildContext context) async {
    print('Done');
    if (_formKey.currentState!.validate()) {
      bool emailValid = emailRegExp.hasMatch(nameController.text);
      if (emailValid) {
        _formKey.currentState!.save();
        String message = '';
        setState(() {
          _loading = true;
        });
        try {
          var payload =
              'username=${nameController.text}&password=${passwordController.text}';
          print(payload.toString());
          await _userService.userLogin(payload).then((value) async {
            setState(() {
              _loading = false;
            });

            var jsonData = json.decode(value.body);
            print(value.statusCode.toString());

            if (value.statusCode == 200 || value.statusCode == 201) {
              List<String> authInformation = [
                jsonData['token'],
                jsonData['userId']
              ];

              PreferencesManager.setPreferences(authInformation);

              var pref = await SharedPreferences.getInstance();
              pref.setString("token", jsonData['token']!);
              pref.setString("name", jsonData['firstName']);
              pref.setString("password", passwordController.text);
              pref.setString("id", jsonData['userId']);
              message = 'Login Successfully';

              pref.setBool("islogin", true);
              _navigationService.navigateTo(AppRoutes.DASHBOARD);

              print(jsonData['token'].toString());
            } else {
              message = jsonData['exception']['message'];
            }
          });
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
        print("Invalid ");

        _toastService.showToast(context, "Invalid Email");
      }

      //  _navigationService.navigateTo(AppRoutes.DASHBOARD);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Color text = HexColor('#135bf1');
    return Scaffold(
      backgroundColor: MyColors.authColor,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimateIcon(
                isFromDashBoard: true,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontFamily: 'regu',
                            fontSize: 40,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SportsVisioFormField(
                        hint: 'Username',
                        controller: nameController,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SportsVisioFormField(
                        hint: 'Password',
                        controller: passwordController,
                        isObscure: true,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ResetPasswordConfirmScreen()));
                              },
                              child: Text(
                                'Reset Password',
                                style: TextStyle(
                                    fontFamily: 'regu',
                                    color: text,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )),
                          Text(
                            '|',
                            style: TextStyle(
                                fontFamily: 'regu',
                                color: Colors.blueAccent[700],
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ForgotPassword()));
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    fontFamily: 'regu',
                                    color: text,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      _loading
                          ? FlipLoadingBar()
                          : AuthButton(
                              text: 'Login',
                              action: () {
                                submit(context);
                              },
                              /* () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DashboardScreen()));
                        }, */
                            )
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: TextButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                RegisterScreen())),
                    child: Text(
                      'Register for a new account',
                      style: TextStyle(
                          fontFamily: 'regu',
                          color: text,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
