import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/Widgets/buttons/accent_button.dart';
import 'package:sportvisio/Widgets/customBnner.dart';
import 'package:sportvisio/Widgets/sportsvisio_form_field.dart';
import 'package:sportvisio/app/app_routes.dart';
import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/app/styles.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';
import 'package:sportvisio/core/helpers/toast_helper.dart';
import 'package:sportvisio/core/helpers/ui_helpers.dart';
import 'package:sportvisio/main.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _navigationService = locator.get<NavigationHelper>();
  final _toast = locator.get<ToastHelper>();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/backgroundwithbanner.png"),
          ),
        ),
        child: Column(
          children: [
            Stack(
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
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: 'Approve Password Reset\n',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text:
                              'Enter your email address. You will receive\nan email with a password reset link.',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                customBnner(navigationService: _navigationService),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      UIHelper.verticalSpaceL,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Verify Email',
                          style: heading3Style,
                        ),
                      ),
                      UIHelper.verticalSpaceMd,
                      SportsVisioFormField(
                        hint: "Email",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      UIHelper.verticalSpaceMd,
                      AccentButton(
                        onPressed: _sendResetCode,
                        label: 'Verify Email',
                        loading: _loading,
                      ),
                      Spacer(),
                      Text(
                        '*** Email link sent to email address. \nEmail Says: Please click on the below link to reset your password.\n<LINK>',
                        style: captionStyle,
                      ),
                      UIHelper.verticalSpaceMd,
                      MaterialButton(
                        splashColor: Colors.transparent,
                        onPressed: () => _navigationService.pop(),
                        child: Text(
                          "Login to your account",
                          style: bodyStyle.copyWith(color: Constants.blueColor),
                        ),
                      ),
                      UIHelper.verticalSpaceMd,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendResetCode({
    bool persistent = true,
    EdgeInsets margin = const EdgeInsets.all(16),
  }) async {
    String error = "Something went wrong";
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      final _email = _emailController.text.trim();
      var data;
      try {
        final cognitoUser = CognitoUser(_email, userPool);
        data = await cognitoUser.forgotPassword();
        _navigationService.navigateTo(AppRoutes.RESET_PASSWORD_CONFIRMATION);
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
      print('Code sent to $data');
    }
  }
}
