import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Widgets/CustomTextField.dart';
import 'package:sportvisio/Widgets/FlipLoadinBar.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/User.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/helpers/user_service.dart';
import 'package:sportvisio/core/view_models/Cognito_viewModel.dart';

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
  User _user = User();
  bool _isAuthenticated = false;
  bool _loading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var currentFocus;

  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void submit(BuildContext context) async {
    _formKey.currentState!.save();
    var s = emailController.text;
    var usernameFromEmail = s.substring(0, s.indexOf('@'));
    print(usernameFromEmail);

    String message = '';
    bool signUpSuccess = false;
    setState(() {
      _loading = true;
    });
    try {
      var payload =
          'email=${emailController.text}&password=${passwordController.text}&firstName=hello&lastName=$usernameFromEmail';
      ;
      await _userService.userRegisterSwag(payload).then((value) async {
        setState(() {
          _loading = false;
        });

        var jsonData = json.decode(value.body);
        print(jsonData);
        //  print(value.statusCode.toString() + "," + jsonData);

        if (value.statusCode != 500) {
          var pref = await SharedPreferences.getInstance();
          // pref.setString("token", jsonData['token']!);
          pref.setString("name", jsonData['firstName']);
          pref.setString("password", passwordController.text);
          pref.setString("id", jsonData['id']);
          message = 'Sign up Successfully';

          //   pref.setBool("islogin", true);

          print(jsonData['id'].toString());
        } else {
          message = jsonData['message'];
        }
      });

      //   _user = await _userService.signUp(
      //       emailController.text, passwordController.text, usernameFromEmail);
      //   signUpSuccess = true;
      //   message = 'User sign up successful!';
      //   _navigationService.navigateTo(AppRoutes.EMAIL_VERIFICATION,
      //       arguments: _user);
      // } on CognitoClientException catch (e) {
      //   if (e.code == 'UsernameExistsException' ||
      //       e.code == 'InvalidParameterException' ||
      //       e.code == 'InvalidPasswordException' ||
      //       e.code == 'ResourceNotFoundException') {
      //     message = e.message!;
      //     print(message);
      //   } else {
      //     message = 'Unknown client error occurred';
      //  }
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
            padding: EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/backgroundwithbanner.png"))),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: 90.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.0),
                    ),
                    color: HexColor("#3E3E3E"),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(0, 3.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        left: 20,
                        bottom: 10,
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'regu',
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: 'New Registration\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'Enter your information below.',
                              ),
                            ],
                          ),
                        ),
                      ),
                      customBnner(navigationService: _navigationService),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontFamily: 'regu',
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // SportsVisioFormField(
                        //   controller: nameController,
                        //   hint: "Username",
                        // ),
                        SportsVisioFormField(
                          controller: emailController,
                          hint: "Email",
                        ),
                        SizedBox(height: 30),
                        SportsVisioFormField(
                          controller: passwordController,
                          hint: "Password",
                          isObscure: true,
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
                        SizedBox(height: 20),
                        FlipLoadingBar(),
                        SizedBox(height: 20),
                        MaterialButton(
                          color: Constants.darkOrangeColor,
                          disabledColor:
                              Constants.darkOrangeColor.withOpacity(0.25),
                          minWidth: size.width,
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: _loading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    //  unfocus();
                                    submit(context);
                                  }
                                },
                          child: Container(
                            alignment: Alignment(0.05, 0.13),
                            child: _loading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Register',
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
                                      )
                                    ],
                                  )
                                : Text(
                                    'Register',
                                    style: TextStyle(
                                      fontFamily: 'regu',
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      height: 1.0,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                        //     'Register',
                        //     style: TextStyle(
                        //       fontFamily: 'regu',
                        //       fontSize: 20.0,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w700,
                        //       height: 1.0,
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: MaterialButton(
                            splashColor: Colors.transparent,
                            onPressed: () {
                              _navigationService.navigateTo(AppRoutes.LOGIN);
                            },
                            child: Text(
                              "Login to your account",
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
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
