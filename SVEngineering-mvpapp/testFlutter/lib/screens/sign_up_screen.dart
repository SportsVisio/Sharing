/*
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:sports_visio/navigation_service.dart';
import 'package:sports_visio/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const TAG = "SIGN_UP";

  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController(text: "iamuser2");
  final emailController = TextEditingController(text: "iamuser2@yopmail.com");
  final phoneController = TextEditingController(text: "+19876543210");
  final passwordController = TextEditingController(text:"Test@123");
  final confirmCodeController = TextEditingController();
  final registrationFormKey = GlobalKey<FormState>();
  final registrationConfirmationFormKey = GlobalKey<FormState>();

  bool isConfirmCodeSent = false;
  bool isSignUpComplete = false;
  bool isLoading = false;
  String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isConfirmCodeSent ? buildConfirmationForm() : buildSignUpForm(),
    );
  }

  SafeArea buildConfirmationForm() {
    return SafeArea(
      child: Form(
        key: registrationConfirmationFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxInputField(
              controller: confirmCodeController,
              placeholder: 'Confirm Code',
            ),
            BoxButton(
              title: 'Confirm',
              onTap: performConfirmRegistration,
              busy: isLoading,
            )
          ],
        ),
      ),
    );
  }

  SafeArea buildSignUpForm() {
    return SafeArea(
      child: Form(
        key: registrationFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxInputField(
              controller: usernameController,
              placeholder: "Username",
            ),
            BoxInputField(
              controller: emailController,
              placeholder: "Email",
            ),
            BoxInputField(
              controller: phoneController,
              placeholder: "Phone",
            ),
            BoxInputField(
              controller: passwordController,
              placeholder: "Password",
              password: true,
            ),
            BoxButton(
              title: 'Register',
              busy: isLoading,
              onTap: performRegister,
            )
          ],
        ),
      ),
    );
  }

  toggleLoading() => setState(() => isLoading = !isLoading);

  performRegister() async {
    if (registrationFormKey.currentState.validate()) {
      username = usernameController.text;
      toggleLoading();
      try {
        Map<String, String> userAttributes = {
          'email': emailController.text,
          'phone_number': phoneController.text,
          // additional attributes as needed
        };
        SignUpResult res = await Amplify.Auth.signUp(
            username: usernameController.text,
            password: passwordController.text,
            options: CognitoSignUpOptions(userAttributes: userAttributes));
        setState(() {
          isConfirmCodeSent = res.isSignUpComplete;
        });
      } on AuthException catch (e) {
        print(e.message);
      } finally {
        toggleLoading();
      }
    }
  }

  performConfirmRegistration() async {
    if (registrationConfirmationFormKey.currentState.validate()) {
      toggleLoading();
      try {
        SignUpResult res = await Amplify.Auth.confirmSignUp(
            username: username, confirmationCode: confirmCodeController.text);
        setState(() => isSignUpComplete = res.isSignUpComplete);
        NavigationService.navigateTo(SignInScreen.TAG);
      } on AuthException catch (e) {
        print(e.message);
      } finally {
        toggleLoading();
      }
    }
  }
}
*/
