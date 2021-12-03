import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class CognitoViewModel {
  final userPool = CognitoUserPool(
    'us-east-1_OerODjULn',
    '7onajo1d4fqd7e9orejqr4nbbd',
  );

  Future registerUser(Map<String, dynamic> param) async {
    final userAttributes = [
      AttributeArg(name: 'email', value: param['email']),
    ];

    CognitoUserPoolData data;
    try {
      data = await userPool.signUp(
        param['username'],
        param['password'],
        userAttributes: userAttributes,
      );
      print(data.userSub);
    } on CognitoUserException catch (e) {
      print(e.message.toString() + ">>>>");
    }
  }

  Future<CognitoUserSession> createSession(Map<String, dynamic> payload) async {
    CognitoUserSession session;

    final cognitoUser = CognitoUser("test@gmail.com", userPool);
    final authDetails = AuthenticationDetails(
      username: 'test@gmail.com',
      password: '12345678',
    );
    session = (await cognitoUser.authenticateUser(authDetails))!;

    try {
      session = (await cognitoUser.authenticateUser(authDetails))!;
    } on CognitoUserNewPasswordRequiredException catch (e) {
      // handle New Password challenge
    } on CognitoUserMfaRequiredException catch (e) {
      // handle SMS_MFA challenge
    } on CognitoUserSelectMfaTypeException catch (e) {
      // handle SELECT_MFA_TYPE challenge
    } on CognitoUserMfaSetupException catch (e) {
      // handle MFA_SETUP challenge
    } on CognitoUserTotpRequiredException catch (e) {
      // handle SOFTWARE_TOKEN_MFA challenge
    } on CognitoUserCustomChallengeException catch (e) {
      // handle CUSTOM_CHALLENGE challenge
    } on CognitoUserConfirmationNecessaryException catch (e) {
      // handle User Confirmation Necessary
    } on CognitoClientException catch (e) {
      // handle Wrong Username and Password and Cognito Client
    } catch (e) {
      print(e);
    }
    //print(session.getAccessToken().getJwtToken());
    return session;
  }
}
