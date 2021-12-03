import 'dart:async';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:dio/dio.dart';
import 'package:mvp/app/locator.dart';
import 'package:mvp/core/constants/api_endpoints.dart';
import 'package:mvp/core/helpers/api_helper.dart';
import 'package:mvp/core/view_models/base_viewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Storage.dart';
import 'User.dart';

class UserServiceViewModel extends BaseViewModel {
  ApiHelper _apiService = locator.get<ApiHelper>();

  late CognitoUserPool _userPool = CognitoUserPool(
    'us-east-1_66HUKi0kQ',
    '3ufu0d3dvoi8ri4gva0mpgvprg',
  );
  late CognitoUser _cognitoUser;
  late CognitoUserSession _session;
  UserServiceViewModel();
  late CognitoCredentials credentials;

  /// Initiate user session from local storage if present
  Future<bool> init() async {
    final prefs = await SharedPreferences.getInstance();
    final storage = Storage(prefs);
    _userPool.storage = storage;

    _cognitoUser = (await _userPool.getCurrentUser())!;
    if (_cognitoUser == null) {
      return false;
    }
    _session = (await _cognitoUser.getSession())!;
    return _session.isValid();
  }

  /// Get existing user from session with his/her attributes
  Future<User?> getCurrentUser() async {
    if (_cognitoUser == null || _session == null) {
      return null;
    }
    if (!_session.isValid()) {
      return null;
    }
    final attributes = await _cognitoUser.getUserAttributes();
    if (attributes == null) {
      return null;
    }
    final user = User.fromUserAttributes(attributes);
    user.hasAccess = true;
    return user;
  }

  /// Retrieve user credentials -- for use with other AWS services
  Future<CognitoCredentials?> getCredentials() async {
    if (_cognitoUser == null || _session == null) {
      return null;
    }

    credentials = CognitoCredentials("us-east-1_OerODjULn", _userPool);
    await credentials.getAwsCredentials(_session.getIdToken().getJwtToken());
    return credentials;
  }

  /// Login user
  Future<User?> login(String email, String password) async {
    setLoading();
    final cognitoUser = CognitoUser(email, _userPool);
    final authDetails = AuthenticationDetails(
      username: email,
      password: password,
    );
    _cognitoUser = CognitoUser(email, _userPool);

    late bool isConfirmed;
    try {
      _session = (await cognitoUser.authenticateUser(authDetails))!;
      isConfirmed = true;
      setCompleted();
    } on CognitoClientException catch (e) {
      setError(e);

      if (e.code == 'UserNotConfirmedException') {
        isConfirmed = false;
        setError(e);
      } else {
        setError(e);

        rethrow;
      }
    } catch (e) {
      setError(e);
    }

    if (!_session.isValid()) {
      return null;
    }

    final attributes = await cognitoUser.getUserAttributes();
    final user = User.fromUserAttributes(attributes!);
    final token = _session.accessToken.jwtToken;
    user.confirmed = isConfirmed;
    user.hasAccess = true;
    user.token = _session.accessToken.jwtToken;

    print("????" + attributes.toString());

    return user;
  }

  /// Confirm user's account with confirmation code sent to email
  Future<bool> confirmAccount(String email, String confirmationCode) async {
    _cognitoUser = CognitoUser(
        email,
        CognitoUserPool(
          'us-east-1_66HUKi0kQ',
          '3ufu0d3dvoi8ri4gva0mpgvprg',
        ));
    CognitoUser? user = await _userPool.getCurrentUser();

    print(confirmationCode);
    bool isConfirm = await _cognitoUser.confirmRegistration(confirmationCode);
    return isConfirm;
  }

  /// Resend confirmation code to user's email
  Future<void> resendConfirmationCode(String email) async {
    _cognitoUser = CognitoUser(email, _userPool, storage: _userPool.storage);
    setLoading();
    await _cognitoUser.resendConfirmationCode();
    setCompleted();
  }

  /// Check if user's current session is valid
  Future<bool> checkAuthenticated() async {
    if (_cognitoUser == null || _session == null) {
      return false;
    }
    return _session.isValid();
  }

  /// Sign upuser
  Future<User> signUp(String email, String password, String name) async {
    CognitoUserPoolData data;
    setLoading();

    final userAttributes = [
      AttributeArg(name: 'email', value: email),
    ];
    data =
        await _userPool.signUp(name, password, userAttributes: userAttributes);

    final user = User();
    user.email = email;
    user.name = name;
    user.confirmed = data.userConfirmed!;
    setCompleted();
    return user;
  }

  Future<void> signOut() async {
    if (credentials != null) {
      await credentials.resetAwsCredentials();
    }
    if (_cognitoUser != null) {
      return _cognitoUser.signOut();
    }
  }

  void authUser(var token) {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var headersWithToken = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
  }

  Future<http.Response> userLogin(payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    var jsonRespose;
    setLoading();
    try {
      jsonRespose = await http.post(Uri.parse(ApiEndPoints.AUTH_LOGIN),
          body: payload, headers: headers);
      setCompleted();
    } catch (e) {
      print('error login: $e');
      setError(e);
    }
    return jsonRespose;
  }

  Future<http.Response> ExchangeToken(token) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer ' + token
    };
    var jsonRespose;
    setLoading();
    try {
      jsonRespose = await http.get(Uri.parse(ApiEndPoints.AUTH_EXCHANGE),
          headers: headers);
      setCompleted();
    } catch (e) {
      print('error excchange: $e');
      setError(e);
    }
    return jsonRespose;
  }

  Future<http.Response> userRegisterSwag(payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var jsonRespose;
    setLoading();
    try {
      jsonRespose = await http.post(Uri.parse(ApiEndPoints.USER_SIGNUP),
          body: payload, headers: headers);
      setCompleted();
    } catch (e) {
      print('error login: $e');
      setError(e);
    }
    return jsonRespose;
  }

  Future<http.Response> forgotPassword(payload) async {
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var jsonRespose;
    setLoading();
    try {
      jsonRespose = await http.post(Uri.parse(ApiEndPoints.FORGOTPASSWORD),
          body: payload, headers: headers);
    } catch (e) {
      print('error login: $e');
      setError(e);
    }
    return jsonRespose;
  }

  Future<http.Response> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': 'Bearer $token'
    };
    var jsonRespose;
    setLoading();
    try {
      jsonRespose = await http.get(Uri.parse(ApiEndPoints.GETCURRENTUSER),
          headers: headers);
    } catch (e) {
      print('error login: $e');
      setError(e);
    }
    return jsonRespose;
  }
}
