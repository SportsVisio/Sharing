import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Widgets/buttons/accent_button.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/main.dart';

class ResetPasswordConfirmScreen extends StatefulWidget {
  const ResetPasswordConfirmScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordConfirmScreenState createState() =>
      _ResetPasswordConfirmScreenState();
}

class _ResetPasswordConfirmScreenState
    extends State<ResetPasswordConfirmScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toast = locator.get<ToastHelper>();
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _resetCodeController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/backgroundwithbanner.png"),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 95.0,
              padding: const EdgeInsets.only(top: 32, left: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10.0),
                ),
                color: HexColor("#3E3E3E"),
                boxShadow: [boxShadow],
              ),
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Password Reset\n',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: 'Enter your new password below.',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UIHelper.verticalSpaceL,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Password Reset', style: heading3Style),
                        ),
                        UIHelper.verticalSpaceSm,
                        SportsVisioFormField(
                          hint: "Reset Code",
                          controller: _resetCodeController,
                          keyboardType: TextInputType.number,
                        ),
                        UIHelper.verticalSpaceSm,
                        SportsVisioFormField(
                          hint: "Enter New Password",
                          controller: _passwordController,
                          isObscure: true,
                          validator: (text) {
                            if (text != null && text.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (text !=
                                _passwordConfirmController.text.trim()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        UIHelper.verticalSpaceSm,
                        SportsVisioFormField(
                          hint: "Verify New Password",
                          controller: _passwordConfirmController,
                          isObscure: true,
                          validator: (text) {
                            if (text != null && text.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (text != _passwordController.text.trim()) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        UIHelper.verticalSpaceL,
                        AccentButton(
                          onPressed: _handleResetPassword,
                          label: 'Reset Password',
                          loading: _loading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              splashColor: Colors.transparent,
              onPressed: () => _navigationService.pop(count: 2),
              child: Text(
                "Login to your account",
                style: bodyStyle.copyWith(color: Constants.blueColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleResetPassword() async {
    String error = "Something went wrong";
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      bool passwordConfirmed = false;
      final cognitoUser = CognitoUser('sikshya3@yopmail.com', userPool);
      try {
        passwordConfirmed = await cognitoUser.confirmPassword(
          _resetCodeController.text.trim(),
          _passwordController.text.trim(),
        );
        _navigationService.pop(count: 2);
      } on ArgumentError catch (e) {
        error = e.message;
        _toast.showToast(context, error);
      } on CognitoClientException catch (e) {
        if (e.message != null) error = e.message!;
        _toast.showToast(context, error);
      } catch (e) {
        print(e);
      } finally {
        setState(() => _loading = false);
      }
      print(passwordConfirmed);
    }
  }
}
