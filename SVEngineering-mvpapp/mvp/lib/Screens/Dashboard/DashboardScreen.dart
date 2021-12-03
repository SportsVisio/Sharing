import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';
import 'package:mvp/utils/ItemModel.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerView(),
              FollowingExpandWidget(size),
              watchliveExpanWidget(size),
              FavoriteExpandWidget(size),
              AnalyticsExpandWidget(size),
              AchievementsExpandWidget(size)
            ],
          ),
        ),
      )),
    );
  }

  ListTileTheme watchliveExpanWidget(var size) {
    return ListTileTheme(
      minVerticalPadding: 0,
      tileColor: Colors.red,
      selectedColor: Colors.white,
      textColor: Colors.white,
      child: ExpansionTile(
        initiallyExpanded: isStreamingExpand,
        maintainState: isStreamingExpand,
        key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch + 1}"),
        leading: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Watch Live',
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 16,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        title: Container(),
        trailing: // Adobe XD layer: 'Icon awesome-expand…' (shape)
            expandedTrailling(),
        onExpansionChanged: (value) {
          // changeExpands(isStreamingExpand);
          print(value.toString());
          // changeExpands(isFollowExpanded);
          setState(() {
            isStreamingExpand = value;
            isFollowExpanded = false;
            isFavoritExpand = false;
            isAchievementExpand = false;
          });
        },
        children: [
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Container(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return index < 2
                        ? Container(
                            width: size.width * 0.3,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/hawks.png"))),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              color: Colors.black26,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hawks',
                                    style: TextStyle(
                                      fontFamily: 'regu',
                                      fontSize: 16,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                      height: 0.625,
                                      shadows: [
                                        Shadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    'vs',
                                    style: TextStyle(
                                      fontFamily: 'regu',
                                      fontSize: 12,
                                      color: const Color(0xffffffff),
                                      fontStyle: FontStyle.italic,
                                      height: 1,
                                      shadows: [
                                        Shadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    'Bullets',
                                    style: TextStyle(
                                      fontFamily: 'regu',
                                      fontSize: 16,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w700,
                                      height: 0.625,
                                      shadows: [
                                        Shadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 5)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                          );
                  }),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  ListTileTheme FollowingExpandWidget(Size size) {
    return ListTileTheme(
      minVerticalPadding: 0,
      tileColor: Colors.red,
      selectedColor: Colors.white,
      textColor: Colors.white,
      child: ExpansionTile(
        initiallyExpanded: isFollowExpanded,
        maintainState: isFollowExpanded,
        key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
        leading: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Following',
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 16,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        title: Container(),
        trailing: expandedTrailling(),
        onExpansionChanged: (value) {
          print(value.toString());
          // changeExpands(isFollowExpanded);
          setState(() {
            isFollowExpanded = value;
            isStreamingExpand = false;
            isFavoritExpand = false;
            isAchievementExpand = false;
          });
        },
        children: [
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Container(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return index < 2
                        ? Container(
                            width: size.width * 0.3,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/jhon.png"))),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              color: Colors.black26,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Player:',
                                    style: TextStyle(
                                      fontFamily: 'regu',
                                      fontSize: 12,
                                      color: const Color(0xffffffff),
                                      fontStyle: FontStyle.italic,
                                      shadows: [
                                        Shadow(
                                          color: const Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'regu',
                                        fontSize: 16,
                                        color: const Color(0xffffffff),
                                        shadows: [
                                          Shadow(
                                            color: const Color(0x29000000),
                                            offset: Offset(0, 3),
                                            blurRadius: 6,
                                          )
                                        ],
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'John T.',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 5)),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 80,
                              ),
                            ),
                          );
                  }),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget FavoriteExpandWidget(Size size) {
    return ListTileTheme(
      minVerticalPadding: 0,
      tileColor: Colors.red,
      selectedColor: Colors.white,
      textColor: Colors.white,
      child: ExpansionTile(
        initiallyExpanded: isFavoritExpand,
        maintainState: isFavoritExpand,
        key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
        leading: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Favorites',
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 16,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        title: Container(),
        trailing: expandedTrailling(),
        onExpansionChanged: (value) {
          print(value.toString());
          // changeExpands(isFollowExpanded);
          setState(() {
            isFavoritExpand = value;
            isFollowExpanded = false;
            isStreamingExpand = false;
            isAchievementExpand = false;
          });
        },
        children: [
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Container(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: size.width * 0.3,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("images/hawks.png"))),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.black26,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                "images/star.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Hawks',
                              style: TextStyle(
                                fontFamily: 'regu',
                                fontSize: 16,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 0.625,
                                shadows: [
                                  Shadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'vs',
                              style: TextStyle(
                                fontFamily: 'regu',
                                fontSize: 12,
                                color: const Color(0xffffffff),
                                fontStyle: FontStyle.italic,
                                height: 1,
                                shadows: [
                                  Shadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              'Bullets',
                              style: TextStyle(
                                fontFamily: 'regu',
                                fontSize: 16,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                height: 0.625,
                                shadows: [
                                  Shadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget AnalyticsExpandWidget(Size size) {
    return IgnorePointer(
      ignoring: !isAnalyticsEnable,
      child: ListTileTheme(
        minVerticalPadding: 0,
        tileColor: !isAnalyticsEnable ? Colors.pink[100] : Colors.red,
        selectedColor: Colors.white,
        textColor: Colors.white,
        child: ExpansionTile(
          initiallyExpanded: false,
          maintainState: isFavoritExpand,
          key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Analytics (Coaches Profile Only)',
              style: TextStyle(
                fontFamily: 'regu',
                fontSize: 16,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          title: Container(),
          trailing: expandedTrailling(),
          onExpansionChanged: (value) {
            print(value.toString());
            // changeExpands(isFollowExpanded);
            setState(() {
              isFavoritExpand = value;
              isFollowExpanded = false;
              isStreamingExpand = false;
            });
          },
          children: [
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Container(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width * 0.3,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/hawks.png"))),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          color: Colors.black26,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  "images/star.png",
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Hawks',
                                style: TextStyle(
                                  fontFamily: 'regu',
                                  fontSize: 16,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 0.625,
                                  shadows: [
                                    Shadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'vs',
                                style: TextStyle(
                                  fontFamily: 'regu',
                                  fontSize: 12,
                                  color: const Color(0xffffffff),
                                  fontStyle: FontStyle.italic,
                                  height: 1,
                                  shadows: [
                                    Shadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Bullets',
                                style: TextStyle(
                                  fontFamily: 'regu',
                                  fontSize: 16,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  height: 0.625,
                                  shadows: [
                                    Shadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget AchievementsExpandWidget(Size size) {
    return ListTileTheme(
      minVerticalPadding: 0,
      tileColor: Colors.red,
      selectedColor: Colors.white,
      textColor: Colors.white,
      child: ExpansionTile(
        initiallyExpanded: isAchievementExpand,
        maintainState: isAchievementExpand,
        key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
        leading: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Achievements',
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 16,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        title: Container(),
        trailing: expandedTrailling(),
        onExpansionChanged: (value) {
          print(value.toString());
          // changeExpands(isFollowExpanded);
          setState(() {
            isFavoritExpand = false;
            isFollowExpanded = false;
            isStreamingExpand = false;
            isAchievementExpand = value;
          });
        },
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [achievementicon(timerIcon())],
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Container achievementicon(icon) {
    return Container(
      width: 55,
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 3, color: Colors.blue)),
      child: Center(
          child: // Adobe XD layer: 'Icon awesome-stopwa…' (shape)
              icon),
    );
  }

  SvgPicture timerIcon() {
    return SvgPicture.string(
      '<svg viewBox="11.5 8.0 29.3 36.0" ><path transform="translate(10.38, 8.0)" d="M 30.375 21.375 C 30.375 29.45390701293945 23.82890701293945 36 15.75 36 C 7.671092987060547 36 1.125 29.45390701293945 1.125 21.375 C 1.125 14.0625 6.489843845367432 8.001562118530273 13.5 6.92578125 L 13.5 4.5 L 11.53125 4.5 C 11.06718730926514 4.5 10.6875 4.120312690734863 10.6875 3.65625 L 10.6875 0.84375 C 10.6875 0.379687488079071 11.06718730926514 0 11.53125 0 L 19.96875 0 C 20.43281173706055 0 20.8125 0.379687488079071 20.8125 0.84375 L 20.8125 3.65625 C 20.8125 4.120312690734863 20.43281173706055 4.5 19.96875 4.5 L 18 4.5 L 18 6.92578125 C 20.63671875 7.333593845367432 23.04140663146973 8.444531440734863 25.01015663146973 10.06171894073486 L 26.94375038146973 8.128125190734863 C 27.27421951293945 7.797656536102295 27.80859375 7.797656536102295 28.13906288146973 8.128125190734863 L 30.12890625 10.11796855926514 C 30.45937538146973 10.44843769073486 30.45937538146973 10.98281192779541 30.12890625 11.31328105926514 L 28.06171798706055 13.38046836853027 L 28.01953125 13.42265605926514 C 29.51015663146973 15.70078086853027 30.375 18.43593788146973 30.375 21.375 Z M 18 23.90625 L 18 13.25390625 C 18 12.78984355926514 17.62031173706055 12.41015625 17.15625 12.41015625 L 14.34375 12.41015625 C 13.87968730926514 12.41015625 13.5 12.78984355926514 13.5 13.25390625 L 13.5 23.90625 C 13.5 24.37031173706055 13.87968730926514 24.75 14.34375 24.75 L 17.15625 24.75 C 17.62031173706055 24.75 18 24.37031173706055 18 23.90625 Z" fill="#95cef3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
      allowDrawingOutsideViewBox: true,
      fit: BoxFit.fill,
    );
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

  Container headerView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Brian\'s Dashboard',
                style: TextStyle(
                  fontFamily: 'regu',
                  fontSize: 20,
                  color: const Color(0xffdb0303),
                  fontWeight: FontWeight.w700,
                  shadows: [
                    Shadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              UIHelper.verticalSpaceSm,
              Text(
                'Menu Items here once items added?',
                style: TextStyle(
                  fontFamily: 'Calibri',
                  fontSize: 14,
                  color: const Color(0xffa1a1a1),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.settings,
            color: Colors.grey,
          ),
          Container(
              height: 80,
              margin: EdgeInsets.only(bottom: 20, left: 10),
              width: 80,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Hero(
                tag: "logomove",
                createRectTween: (begin, end) {
                  return MaterialRectArcTween(begin: begin, end: end);
                },
                child: Image.asset(
                  "images/logoredwhitevertical.png",
                ),
              ))
        ],
      ),
    );
  }
}
