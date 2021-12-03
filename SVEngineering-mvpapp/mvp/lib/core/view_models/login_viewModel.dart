import 'package:mvp/app/locator.dart';
import 'package:mvp/core/helpers/User.dart';
import 'package:mvp/core/helpers/api_helper.dart';

import 'base_viewModel.dart';

class LoginViewModel extends BaseViewModel {
  ApiHelper _apiService = locator.get<ApiHelper>();

  void performLogin() async {
    setLoading();
    try {
      var response = await _apiService.get("/users/id");
    } catch (e) {
      setError(e);
    } finally {
      setCompleted();
    }
  }
}
