import 'package:flutter/material.dart';

class ExpandedViewModel extends ChangeNotifier {
  bool isFollowExpanded = true;
  bool isStreamingExpand = true;
  bool isFavoritExpand = true;
  bool isAnalyticsEnable = false;
  bool isAchievementExpand = true;

  void changeExpandState(var clickedKey, bool value) {
    print(clickedKey.toString());
    if (clickedKey == 'following') {
      isFollowExpanded = value;
      isStreamingExpand = false;
      isFavoritExpand = false;
      isAnalyticsEnable = false;
      isAchievementExpand = false;
    }
    if (clickedKey == 'streaming') {
      isFollowExpanded = false;
      isStreamingExpand = value;
      isFavoritExpand = false;
      isAnalyticsEnable = false;
      isAchievementExpand = false;
    }
    if (clickedKey == "favorite") {
      isFollowExpanded = false;
      isStreamingExpand = false;
      isFavoritExpand = true;
      isAnalyticsEnable = false;
      isAchievementExpand = false;
    }

    if (clickedKey == "analytic") {
      isFollowExpanded = false;
      isStreamingExpand = false;
      isFavoritExpand = false;
      isAnalyticsEnable = true;
      isAchievementExpand = false;
    }
    if (clickedKey == "aceivement") {
      isFollowExpanded = false;
      isStreamingExpand = false;
      isFavoritExpand = false;
      isAnalyticsEnable = false;
      isAchievementExpand = true;
    }
    notifyListeners();
  }
}
