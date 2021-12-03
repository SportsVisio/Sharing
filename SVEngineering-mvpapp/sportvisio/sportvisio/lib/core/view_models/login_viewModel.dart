import 'package:sportvisio/app/locator.dart';
import 'package:sportvisio/core/helpers/api_helper.dart';
import 'package:sportvisio/core/view_models/base_viewModel.dart';
import 'package:sportvisio/network/data_models/user.dart';

class LoginViewModel extends BaseViewModel {
  ApiHelper _apiService = locator.get<ApiHelper>();

  void performLogin() async {
    setLoading();
    try {
      var response = await _apiService.get("/users/id");
      User user = User.fromJson(response.data);
    } catch (e) {
      setError(e);
    } finally {
      setCompleted();
    }
  }
}
