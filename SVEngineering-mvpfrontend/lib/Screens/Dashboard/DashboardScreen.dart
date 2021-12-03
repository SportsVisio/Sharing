import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp/Screens/Achievements/AchievementsExpandScreen.dart';
import 'package:mvp/Screens/Analytics/AnalyticsExpandScreen.dart';
import 'package:mvp/Screens/Favorite/FavoriteExpand.dart';
import 'package:mvp/Screens/Following/FollowingExpandedScreen.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/Screens/WatchLive/watchliveExpan.dart';
import 'package:mvp/Widgets/Headerview.dart';
import 'package:mvp/Widgets/MyCustomNav.dart';
import 'package:mvp/core/helpers/auth_helper.dart';
import 'package:mvp/core/view_models/ExpandedViewModel.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isFollowExpanded = true;
  bool isStreamingExpand = true;
  bool isFavoritExpand = true;
  bool isAnalyticsEnable = false;
  bool isAchievementExpand = true;

  UserServiceViewModel _userService = UserServiceViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => context.read<FollowingViewModel>().getFollowedProfiles());
  }

  @override
  Widget build(BuildContext context) {
    _userService.getUser().then((value) {
      var jsonData = json.decode(value.body);
      print(value.statusCode.toString());
      print(jsonData.toString() + "PPPP");
    });
    Size size = MediaQuery.of(context).size;
    return Consumer<ExpandedViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        bottomNavigationBar: MyCustomeNav1(0),
        body: SingleChildScrollView(
            child: Container(
          width: size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeaderView(
                  isFromDashBoard: true,
                ),
                FollowingExpanded(),
                watchliveExpan(),
                FavoriteExpandWidget(),
                AnalyticExpandWidget(),
                AchievementExpandWidget()
                // FavoriteExpandWidget(size),
                // AnalyticsExpandWidget(size),
                // AchievementsExpandWidget(size)
              ],
            ),
          ),
        )),
      );
    });
  }

  SvgPicture expandedTrailling() {
    return SvgPicture.string(
      '<svg viewBox="377.0 7.0 16.0 16.0" ><path transform="translate(377.0, 4.75)" d="M 15.99999237060547 13.39285087585449 L 15.99999237060547 17.39284896850586 C 16.00056457519531 17.62035179138184 15.91044044494629 17.83870124816895 15.74957180023193 17.99957084655762 C 15.58870220184326 18.16044235229492 15.37035179138184 18.25056266784668 15.14284896850586 18.2499942779541 L 11.14284992218018 18.24999237060547 C 10.37892150878906 18.24999237060547 9.996779441833496 17.32499122619629 10.53570747375488 16.78570556640625 L 11.82856464385986 15.49284934997559 L 7.999994277954102 11.66427898406982 L 4.170353412628174 15.49642086029053 L 5.464281558990479 16.78570556640625 C 6.003210067749023 17.32499122619629 5.621067047119141 18.24999237060547 4.857138633728027 18.24999237060547 L 0.8571398854255676 18.24999237060547 C 0.6296370029449463 18.25056266784668 0.4112876057624817 18.16044044494629 0.2504182457923889 17.99957084655762 C 0.08954889327287674 17.83870124816895 -0.000573545228689909 17.62035179138184 -2.612424850667594e-06 17.39285087585449 L -2.612424850667594e-06 13.39285087585449 C -2.612424850667594e-06 12.62856388092041 0.9246398210525513 12.24642276763916 1.464282393455505 12.78570747375488 L 2.756782054901123 14.07856369018555 L 6.587852478027344 10.2499942779541 L 2.756424903869629 6.417853355407715 L 1.464282393455505 7.714281558990479 C 0.9249970316886902 8.253566741943359 -2.612424850667594e-06 7.871424198150635 -2.612424850667594e-06 7.107138633728027 L -2.612424850667594e-06 3.107140302658081 C -0.000573545228689909 2.879637241363525 0.08954889327287674 2.661287546157837 0.2504181861877441 2.500418424606323 C 0.4112876057624817 2.33954906463623 0.6296369433403015 2.249426603317261 0.8571398258209229 2.249997615814209 L 4.857138633728027 2.249997615814209 C 5.621067047119141 2.249997615814209 6.003210067749023 3.174997091293335 5.464281558990479 3.714282751083374 L 4.171424865722656 5.007139205932617 L 7.999994277954102 8.835708618164062 L 11.82963562011719 5.003567695617676 L 10.53570747375488 3.714282751083374 C 9.996779441833496 3.174997091293335 10.37892150878906 2.249997615814209 11.14284992218018 2.249997615814209 L 15.14284896850586 2.249997615814209 C 15.37035179138184 2.249426364898682 15.58870220184326 2.33954906463623 15.74957180023193 2.500417947769165 C 15.91044044494629 2.661287546157837 16.00056457519531 2.879637002944946 15.99999237060547 3.107140302658081 L 15.99999237060547 7.107138633728027 C 15.99999237060547 7.871424198150635 15.07534885406494 8.253566741943359 14.53570556640625 7.714281558990479 L 13.24320602416992 6.421424865722656 L 9.412137031555176 10.2499942779541 L 13.24356365203857 14.0821361541748 L 14.53570556640625 12.78927803039551 C 15.07499122619629 12.24642181396484 15.99999237060547 12.62856388092041 15.99999237060547 13.39285087585449 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
      allowDrawingOutsideViewBox: true,
      fit: BoxFit.fill,
    );
  }

  void changeExpands(bool value) {
    if (value == isFollowExpanded) {
      setState(() {
        isStreamingExpand = false;
      });
    }
    if (value == isStreamingExpand) {
      setState(() {
        isFollowExpanded = false;
      });
    }
  }
}
