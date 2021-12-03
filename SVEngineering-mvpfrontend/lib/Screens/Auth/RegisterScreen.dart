import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Screens/Auth/AuthButton.dart';
import 'package:mvp/Screens/Auth/LoginScreen.dart';
import 'package:mvp/Widgets/FlipLoadinBar.dart';
import 'package:mvp/Widgets/sportsvisio_form_field.dart';
import 'package:mvp/app/app_routes.dart';
import 'package:mvp/app/locator.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/User.dart';
import 'package:mvp/core/helpers/auth_helper.dart';
import 'package:mvp/core/helpers/navigation_helper.dart';
import 'package:mvp/core/helpers/toast_helper.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  bool isLoginButtonDisable = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController repasswordController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  UserServiceViewModel _userService = UserServiceViewModel();
  bool _loading = false;
  var currentFocus;

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      print('Not Valid');
      return;
    }
    _formKey.currentState!.save();
    var s = emailController.text;
    var usernameFromEmail = s.substring(0, s.indexOf('@'));
    print(usernameFromEmail);
    String message = '';
    setState(() {
      _loading = true;
    });
    try {
      var payload =
          'email=${emailController.text}&password=${passwordController.text}&firstName=hello&lastName=$usernameFromEmail';
      await _userService.userRegisterSwag(payload).then((value) async {
        setState(() {
          _loading = false;
        });
        var jsonData = json.decode(value.body);
        print(jsonData);
        //  print(value.statusCode.toString() + "," + jsonData);

        if (value.statusCode != 500) {
          message = 'Sign up Successfully. Now Login';
          print(jsonData['id'].toString());
        } else {
          message = jsonData['message'];
        }
      });
    } catch (e) {
      message = 'Unknown error occurred';
    }
    setState(() {
      _loading = false;
    });
    _toastService.showToast(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Color text = HexColor('#135bf1');
    return Consumer<UserServiceViewModel>(builder: (context, viewModel, child) {
      _userService = viewModel;
      return Scaffold(
        backgroundColor: MyColors.authColor,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            child: Padding(
              padding: EdgeInsets.only(left: 45, right: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'regu',
                            fontSize: 24,
                            color: const Color(0xff3e3e3e),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SportsVisioFormField(hint: 'Username'),
                        SizedBox(
                          height: 5,
                        ),
                        SportsVisioFormField(
                          hint: 'Email',
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SportsVisioFormField(
                            hint: 'Nickname (name others see)'),
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        SportsVisioFormField(
                          hint: 'Password',
                          controller: passwordController,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SportsVisioFormField(
                          controller: repasswordController,
                          hint: "Re-Enter Password",
                          isObscure: true,
                          validator: (text) {
                            if (text != null && text.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (text != passwordController.text.trim()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FlipLoadingBar(),
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        _loading
                            ? FlipLoadingBar()
                            : AuthButton(
                                text: 'Register',
                                action: () {
                                  submit(context);
                                },
                              )
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen())),
                        child: Text(
                          'Login to your account',
                          style: TextStyle(
                              fontFamily: 'regu',
                              color: text,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
