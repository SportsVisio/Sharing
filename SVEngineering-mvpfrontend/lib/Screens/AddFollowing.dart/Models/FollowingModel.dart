import 'package:flutter/cupertino.dart';

class FollowingModel extends ChangeNotifier {
  bool isPlayerSelected = true;
  bool isPlayerClick = false;
  bool isAddVsPlayerClick = false;

  void changeWidget({var key}) {
    if (key == "playerSelected") {
      //print('Done');
      isPlayerSelected = true;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
    }
    if (key == "PlayerClicked") {
      //print('Home');
      isPlayerSelected = false;
      isPlayerClick = true;
      isAddVsPlayerClick = false;
    }
    if (key == "back") {
      //print('Home');
      isPlayerSelected = true;
      isPlayerClick = false;
      isAddVsPlayerClick = false;
    }
    /* if (key == "addvsplayerclick") {
      print('Away');
      isPlayerSelected = false;
      isPlayerClick = false;
      isAddVsPlayerClick = true;
    } */

    notifyListeners();
  }
}
