import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Screens/Auth/AuthButton.dart';
import 'package:mvp/Screens/Auth/Icon.dart';
import 'package:mvp/Screens/Auth/LoginScreen.dart';
import 'package:mvp/Screens/Auth/RegisterScreen.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Screens/ResetPassword/ResetPasswordConfirmScreen.dart';
import 'package:mvp/Widgets/FlipLoadinBar.dart';
import 'package:mvp/Widgets/sportsvisio_form_field.dart';
import 'package:mvp/app/app_routes.dart';
import 'package:mvp/app/locator.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/auth_helper.dart';
import 'package:mvp/core/helpers/navigation_helper.dart';
import 'package:mvp/core/helpers/toast_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      new TextEditingController(text: "scott@sportsvisio.com");
  TextEditingController passwordController = new TextEditingController();
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _loading = false;
  UserServiceViewModel _userService = UserServiceViewModel();

  submit(BuildContext context) async {
    print('Done');
    if (_formKey.currentState!.validate()) {
      bool emailValid = emailRegExp.hasMatch(emailController.text);
      if (emailValid) {
        _formKey.currentState!.save();
        String message = '';
        setState(() {
          _loading = true;
        });
        try {
          var payload = 'email=${emailController.text}';
          await _userService.forgotPassword(payload).then((value) async {
            setState(() {
              _loading = false;
            });
            var jsonData = json.decode(value.body);
            print(value.statusCode.toString());
            if (value.statusCode == 200 || value.statusCode == 201) {
              _navigationService.navigateTo(AppRoutes.LOGIN);
              print(jsonData.toString());
            } else {
              message = jsonData['message'];
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
          // _toastService.showToast(context, message);
        }
      } else {
        _toastService.showToast(context, "Invalid Email");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Color text = HexColor('#135bf1');
    return Scaffold(
      backgroundColor: MyColors.authColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                    'Forgot Password',
                    style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 23,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SportsVisioFormField(
                    hint: 'Email',
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  //  FlipLoadingBar(),
                  SizedBox(
                    height: 30,
                  ),
                  _loading
                      ? FlipLoadingBar()
                      : AuthButton(
                          text: 'Forgot Password',
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
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen())),
                child: Text(
                  'Login to your account',
                  style: TextStyle(
                      fontFamily: 'regu',
                      color: text,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                )),
          )
        ],
      ),
    );
  }
}
