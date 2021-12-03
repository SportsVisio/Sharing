import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Screens/Auth/LoginScreen.dart';
import 'package:mvp/Screens/Dashboard/DashboardScreen.dart';
import 'package:mvp/Widgets/sportsvisio_form_field.dart';
import 'package:mvp/app/locator.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/navigation_helper.dart';
import 'package:mvp/core/helpers/toast_helper.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';

import '../../main.dart';

class EmailVerificationScreen extends StatefulWidget {
  EmailVerificationScreen();

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toastService = locator.get<ToastHelper>();
  TextEditingController codeController = new TextEditingController();
  bool isLoginButtonDisable = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  // UserServiceViewModel _userService = UserServiceViewModel();
  // User _user = User();
  bool _isAuthenticated = false;
  bool _loading = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future _submit(BuildContext context) async {
    _formKey.currentState?.save();
    // var accountConfirmed = false;
    // String message;
    // setState(() {
    //   _loading = true;
    // });
    // try {
    //   if (widget.user.email != null) {
    //     final cognitoUser = CognitoUser(widget.user.name, userPool);

    //     accountConfirmed = false;

    //     accountConfirmed =
    //         await cognitoUser.confirmRegistration(codeController.text.trim());

    //     print(accountConfirmed);

    //     message = 'Account successfully confirmed!';
    //     setState(() {
    //       _loading = false;
    //     });
    //     _navigationService.navigateTo(AppRoutes.LOGIN);
    //   } else {
    //     message = 'Unknown client error occurred';
    //     setState(() {
    //       _loading = false;
    //     });
    //   }
    // } on CognitoClientException catch (e) {
    //   if (e.code == 'InvalidParameterException' ||
    //       e.code == 'CodeMismatchException' ||
    //       e.code == 'NotAuthorizedException' ||
    //       e.code == 'UserNotFoundException' ||
    //       e.code == 'ResourceNotFoundException') {
    //     message = e.message ?? e.code ?? e.toString();
    //     setState(() {
    //       _loading = false;
    //     });
    //   } else {
    //     message = e.message.toString();
    //     setState(() {
    //       _loading = false;
    //     });
    //   }
    // } catch (e) {
    //   message = 'Unknown error occurred' + e.toString();
    //   setState(() {
    //     _loading = false;
    //   });
    // }
    // _toastService.showToast(context, message);
  }

  Future _resendConfirmation(BuildContext context) async {
    // _formKey.currentState?.save();
    // var message;
    // setState(() {
    //   _loading = true;
    // });

    // final cognitoUser = CognitoUser(widget.user.name, userPool);
    // try {
    //   message = await cognitoUser.resendConfirmationCode();
    //   print(message);
    // } catch (e) {}
    // setState(() {
    //   _loading = false;
    // });
    // _toastService.showToast(
    //     context,
    //     "Code sent to " +
    //         message['CodeDeliveryDetails']['Destination'].toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MyColors.authBackColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
            // image: DecorationImage(
            //     fit: BoxFit.cover,
            //     image: AssetImage("images/backgroundwithbanner.png"))

            ),
        child: Column(
          children: [
            UIHelper.verticalSpaceL,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Verify Email',
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 24.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SportsVisioFormField(
                      hint: "code",
                      controller: codeController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 50),

                    MaterialButton(
                        disabledColor:
                            MyColors.darkOrangeColor.withOpacity(0.35),
                        color: MyColors.darkRedColor,
                        minWidth: size.width,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        onPressed: _loading
                            ? null
                            : () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DashboardScreen()));
                                //_submit(context);
                                //    viewModel.performLogin();
                                // _navigationService.navigateTo(AppRoutes.MAIN_MENU);
                              },
                        child: Container(
                          alignment: Alignment(0.05, 0.13),
                          child: _loading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Verify Email',
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
                                  'Verify Email',
                                  style: TextStyle(
                                    fontFamily: 'bold',
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    height: 1.0,
                                  ),
                                ),
                        )),

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
                    //     'Verify Email',
                    //     style: TextStyle(
                    //       fontFamily: 'regu',
                    //       fontSize: 20.0,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w700,
                    //       height: 1.0,
                    //     ),
                    //   ),
                    // ),

                    // Spacer(),
                    UIHelper.verticalSpaceMd,
                    Text(
                      '',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'You will receive an email \nwith a password reset link.',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 20.0,
                        color: const Color(0xFF333333),
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                      '*** Email link sent to email address. \nEmail Says: Please click on the below link to reset your password.\n<LINK>',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 18,
                        color: const Color(0xff3e3e3e),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    UIHelper.verticalSpaceMd,
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen())),
                        child: Text(
                          'Login to your account',
                          style: TextStyle(
                              fontFamily: 'regu',
                              color: const Color(0xff0055ff),
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        )),
                    UIHelper.verticalSpaceL,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> confirmAccount(String email, String confirmationCode) async {
    CognitoUser _cognitoUser = CognitoUser(
        email,
        CognitoUserPool(
          'us-east-1_66HUKi0kQ',
          '3ufu0d3dvoi8ri4gva0mpgvprg',
        ));

    bool isConfirm = await _cognitoUser.confirmRegistration(confirmationCode);
    print(isConfirm);

    return isConfirm;
  }
}
