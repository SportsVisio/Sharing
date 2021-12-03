import 'package:flutter/cupertino.dart';

class WatchingViewModel extends ChangeNotifier {
  bool isPlayerSelected = true;
  bool isPlayerClick = false;
  bool isAddVsPlayerClick = false;

  void changeWidget({var key}) {
    if (key == "playerSelected") {
      print('Done');
      isPlayerSelected = true;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
    }
    if (key == "PlayerClicked") {
      isPlayerSelected = false;
      isPlayerClick = true;
      isAddVsPlayerClick = false;
    }
    if (key == "addvsplayerclick") {
      isPlayerSelected = false;
      isPlayerClick = false;
      isAddVsPlayerClick = true;
    }
    if (key == "back") {
      isPlayerSelected = true;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
    }

    notifyListeners();
  }
}
