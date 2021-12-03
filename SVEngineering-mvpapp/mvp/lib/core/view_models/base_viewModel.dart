import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:mvp/core/enums/status_enum.dart';
import 'package:mvp/network/api_exception.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isDisposed = false;
  StatusEnum _status = StatusEnum.IDLE;
  String? _error;

  StatusEnum get status => _status;
  // get error => _error;

  get loading => _status == StatusEnum.LOADING;

  setLoading() {
    _status = StatusEnum.LOADING;
    // SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light);
    // SVProgressHUD.show(status: "");
    if (!_isDisposed) notifyListeners();
  }

  setCompleted() {
    _status = StatusEnum.COMPLETED;
    SVProgressHUD.dismiss();
    if (!_isDisposed) notifyListeners();
  }

  setError(error) {
    if (error is ApiException) {
      _error = error.toJson()['Message'] ?? error.toJson()['message'];
    } else {
      _error = error.toString();
    }
    _status = StatusEnum.ERROR;
    SVProgressHUD.dismiss();

    if (!_isDisposed) notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

/*setError(error) {
    if (error is AppException) {
      _error = error.toJson()['Message'] ?? error.toJson()['message'];
    } else {
      _error = error.toString();
    }
    status = Status.ERROR;
    if (!_isDisposed) {
      notifyListeners();
      Fluttertoast.showToast(
          msg: _error,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  showToast(message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showError(message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }*/
}
