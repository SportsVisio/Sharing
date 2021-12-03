import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/User.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/helpers/user_service.dart';

import '../../main.dart';

class EmailVerificationScreen extends StatefulWidget {
  User user;

  EmailVerificationScreen(this.user);

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

  UserServiceViewModel _userService = UserServiceViewModel();
  User _user = User();
  bool _isAuthenticated = false;
  bool _loading = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future _submit(BuildContext context) async {
    _formKey.currentState?.save();
    var accountConfirmed = false;
    String message;
    setState(() {
      _loading = true;
    });
    try {
      if (widget.user.email != null) {
        final cognitoUser = CognitoUser(widget.user.name, userPool);

        accountConfirmed = false;

        accountConfirmed =
            await cognitoUser.confirmRegistration(codeController.text.trim());

        print(accountConfirmed);

        message = 'Account successfully confirmed!';
        setState(() {
          _loading = false;
        });
        _navigationService.navigateTo(AppRoutes.LOGIN);
      } else {
        message = 'Unknown client error occurred';
        setState(() {
          _loading = false;
        });
      }
    } on CognitoClientException catch (e) {
      if (e.code == 'InvalidParameterException' ||
          e.code == 'CodeMismatchException' ||
          e.code == 'NotAuthorizedException' ||
          e.code == 'UserNotFoundException' ||
          e.code == 'ResourceNotFoundException') {
        message = e.message ?? e.code ?? e.toString();
        setState(() {
          _loading = false;
        });
      } else {
        message = e.message.toString();
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      message = 'Unknown error occurred' + e.toString();
      setState(() {
        _loading = false;
      });
    }
    _toastService.showToast(context, message);
  }

  Future _resendConfirmation(BuildContext context) async {
    _formKey.currentState?.save();
    print(widget.user.email);
    var message;
    setState(() {
      _loading = true;
    });

    final cognitoUser = CognitoUser(widget.user.name, userPool);
    try {
      message = await cognitoUser.resendConfirmationCode();
      print(message);
    } catch (e) {}
    setState(() {
      _loading = false;
    });
    _toastService.showToast(
        context,
        "Code sent to " +
            message['CodeDeliveryDetails']['Destination'].toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
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
              height: 95.0,
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
                      bottom: 5,
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontFamily: 'regu',
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: 'Approve Email \n',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                                text:
                                    'Enter the code. You will receive\nan email with a code to verify your account',
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      )),
                  customBnner(navigationService: _navigationService),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Verify Code',
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
                    // MaterialButton(
                    //   color: Constants.darkOrangeColor,
                    //   minWidth: size.width,
                    //   height: 50,
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10)),
                    //   onPressed: () {
                    //     _submit(context);
                    //   },
                    //   child: Container(
                    //     alignment: Alignment(0.05, 0.13),
                    //     child: _loading
                    //         ? Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 'Verify Email',
                    //                 style: TextStyle(
                    //                   fontFamily: 'bold',
                    //                   fontSize: 20.0,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.w700,
                    //                   height: 1.0,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    //               SizedBox(
                    //                 height: 16,
                    //                 width: 16,
                    //                 child: CircularProgressIndicator(
                    //                   backgroundColor: Colors.white,
                    //                   strokeWidth: 2,
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         : Text(
                    //             'Verify Email',
                    //             style: TextStyle(
                    //               fontFamily: 'regu',
                    //               fontSize: 20.0,
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.w700,
                    //               height: 1.0,
                    //             ),
                    //           ),1
                    //   ),
                    // ),+          

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
                                _submit(context);
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
                    Text(
                      '',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: MaterialButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          // _navigationService.navigateTo(AppRoutes.LOGIN);
                          _resendConfirmation(context);
                        },
                        child: Text(
                          "Resend Code",
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
