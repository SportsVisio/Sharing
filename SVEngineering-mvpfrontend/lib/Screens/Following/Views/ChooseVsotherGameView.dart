import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';

class ChooseVsOtherGameView extends StatefulWidget {
  const ChooseVsOtherGameView({Key? key}) : super(key: key);

  @override
  _ChooseVsOtherGameViewState createState() => _ChooseVsOtherGameViewState();
}

class _ChooseVsOtherGameViewState extends State<ChooseVsOtherGameView>
    with TickerProviderStateMixin {
  bool isTotalClick = true;
  var _chosenValue;
  bool isFirstIsActive = true;
  late AnimationController _animationControllerForSearchButton;
  late Animation<Offset> _animationForSearchButton;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationControllerForSearchButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationForSearchButton = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-3.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationControllerForSearchButton,
      curve: Curves.easeInCubic,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<FollowingViewModel>(
        builder: (context, followingViewModel, child) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIHelper.verticalSpaceSm,
            //  imagesHeader(size, followingViewModel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: <Widget>[
// Group: Group 9
                          Container(
                            height: 105.0,
                            width: size.width * 0.5 - 10,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/jhon.png'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.red,
                              border: Border.all(
                                width: 3.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Positioned(
                            left: 10.0,
                            bottom: 10.0,
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'regu',
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.16),
                                      offset: Offset(0, 3.0),
                                      blurRadius: 6.0,
                                    ),
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
                            ),
                          ),
                          Positioned(
                            left: 10.0,
                            bottom: 28.0,
                            child: Text(
                              'Player:',
                              style: TextStyle(
                                fontFamily: 'regu',
                                fontSize: 10.0,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.16),
                                    offset: Offset(0, 3.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
// Group: Group 9
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isFirstIsActive = true;
                                    _animationForSearchButton = Tween<Offset>(
                                      begin: const Offset(0.0, 0.0),
                                      end: const Offset(3, 0.0),
                                    ).animate(CurvedAnimation(
                                      parent:
                                          _animationControllerForSearchButton,
                                      curve: Curves.easeInCubic,
                                    ));
                                  });
                                },
                                child: Container(
                                  height: 105.0,
                                  width: isFirstIsActive
                                      ? size.width * 0.33 - 5
                                      : size.width * 0.17 - 5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(followingViewModel
                                          .selectedTeamModel!.image),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      width: 3.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                style: TextStyle(
                                                  fontFamily: 'regu',
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.16),
                                                      offset: Offset(0, 3.0),
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: followingViewModel
                                                        .selectedTeamModel!
                                                        .name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              followingViewModel
                                                  .selectedTeamModel!.type,
                                              style: TextStyle(
                                                fontFamily: 'regu',
                                                fontSize: 10.0,
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.16),
                                                    offset: Offset(0, 3.0),
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: !isFirstIsActive
                                            ? Colors.white.withOpacity(0.5)
                                            : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isFirstIsActive = false;
                                    // _animationControllerForSearchButton
                                    //     .reverse();
                                    _animationForSearchButton = Tween<Offset>(
                                      begin: const Offset(2.0, 0.0),
                                      end: const Offset(0.0, 0.0),
                                    ).animate(CurvedAnimation(
                                      parent:
                                          _animationControllerForSearchButton,
                                      curve: Curves.easeInCubic,
                                    ));
                                  });
                                },
                                child: Container(
                                  height: 105.0,
                                  width: isFirstIsActive
                                      ? size.width * 0.17 - 5
                                      : size.width * 0.33 - 5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("images/hawks.png"),
                                      fit: BoxFit.cover,
                                    ),
                                    border: Border.all(
                                      width: 3.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                style: TextStyle(
                                                  fontFamily: 'regu',
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.16),
                                                      offset: Offset(0, 3.0),
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: followingViewModel
                                                        .selectedTeamModel!
                                                        .name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              followingViewModel
                                                  .selectedTeamModel!.type,
                                              style: TextStyle(
                                                fontFamily: 'regu',
                                                fontSize: 10.0,
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black
                                                        .withOpacity(0.16),
                                                    offset: Offset(0, 3.0),
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        color: isFirstIsActive
                                            ? Colors.white.withOpacity(0.5)
                                            : Colors.transparent,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 5),
                      alignment: Alignment.center,
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        border: Border.all(
                          width: 3.0,
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'VS',
                          style: TextStyle(
                            fontFamily: 'regu',
                            fontSize: 18.0,
                            color: const Color(0xFFDB0303),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: size.width * 0.2,
                    child: SlideTransition(
                      position: _animationForSearchButton,
                      child: InkWell(
                        onTap: () {
                          if (followingViewModel.selectedTeamModel!.type ==
                              "Player:") {
                            followingViewModel.changeWidget(
                                key: "specificgamesearchteam");
                          } else {
                            followingViewModel.changeWidget(
                                key: "choosevsgamecalender");
                          }
                        },
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xFFF1F1F1).withOpacity(0.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],
                          ),
                          child: SvgPicture.string(
                            // Icon open-magnifying-glass
                            '<svg viewBox="5.34 5.48 31.19 31.19" ><path transform="translate(5.34, 5.52)" d="M 13.5218563079834 -0.006366134155541658 C 6.065518379211426 -0.006366134155541658 0 6.059152126312256 0 13.51549053192139 C 0 20.97182846069336 6.065518379211426 27.03734588623047 13.5218563079834 27.03734588623047 C 15.80125617980957 27.03734588623047 18.04201889038086 26.49647331237793 19.93507957458496 25.4533576965332 C 20.08671569824219 25.63583755493164 20.25483894348145 25.8039608001709 20.43731880187988 25.95559692382812 L 24.30070686340332 29.81898307800293 C 25.27272796630859 30.91272735595703 26.77075386047363 31.37782096862793 28.19129753112793 31.02690505981445 C 29.61184501647949 30.67598915100098 30.72098731994629 29.56684494018555 31.07190704345703 28.14629936218262 C 31.42282295227051 26.72575187683105 30.95772552490234 25.22772598266602 29.86398696899414 24.25570678710938 L 26.0005989074707 20.39231872558594 C 25.81240272521973 20.20405769348145 25.60525512695312 20.03575134277344 25.3824577331543 19.89008140563965 C 26.42557144165039 17.99701881408691 27.08234786987305 15.79488849639893 27.08234786987305 13.47685718536377 C 27.08234786987305 6.020517826080322 21.0168285369873 -0.04500007629394531 13.56049060821533 -0.04500007629394531 Z M 13.5218563079834 3.857021331787109 C 18.89196586608887 3.857021331787109 23.18032646179199 8.145381927490234 23.18032646179199 13.51549053192139 C 23.18032646179199 16.0653247833252 22.25311279296875 18.42199325561523 20.63049125671387 20.1605167388916 C 20.59185600280762 20.19915008544922 20.55322265625 20.23778343200684 20.51458930969238 20.27641868591309 C 20.33210945129395 20.42805290222168 20.16398429870605 20.59617614746094 20.01234817504883 20.77865600585938 C 18.31245803833008 22.32401275634766 15.99442577362061 23.21259117126465 13.4832239151001 23.21259117126465 C 8.113115310668945 23.21259117126465 3.824755191802979 18.92423248291016 3.824755191802979 13.55412292480469 C 3.824755191802979 8.184013366699219 8.113115310668945 3.89565372467041 13.4832239151001 3.89565372467041 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                            width: 25.19,
                            height: 25.19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceSm,
            Container(
              width: size.width,
              child: Card(
                elevation: 10,
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.string(
                                    // Icon ionic-md-stats
                                    '<svg viewBox="0.0 0.0 19.75 17.06" ><path transform="translate(-7.29, -2.44)" d="M 12.375 4.5 L 16.875 4.5 L 16.875 19.5 L 12.375 19.5 L 12.375 4.5 Z" fill="#ebebeb" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-5.62, -14.44)" d="M 5.625 23.625 L 10.125 23.625 L 10.125 31.5 L 5.625 31.5 L 5.625 23.625 Z" fill="#ebebeb" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-8.96, -14.44)" d="M 19.125 19.125 L 23.625 19.125 L 23.625 31.5 L 19.125 31.5 L 19.125 19.125 Z" fill="#ebebeb" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-10.62, -12.37)" d="M 25.875 12.37499904632568 L 30.375 12.37499904632568 L 30.375 29.43749809265137 L 25.875 29.43749809265137 L 25.875 12.37499904632568 Z" fill="#ebebeb" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                    width: 19.75,
                                    height: 17.06,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Align(
                                    alignment: Alignment(0.0, 0.17),
                                    child: Text(
                                      'Statistics',
                                      style: TextStyle(
                                        fontFamily: 'regu',
                                        fontSize: 16.0,
                                        color: const Color(0xFF585858),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment(0.0, -0.43),
                                    child: SvgPicture.string(
                                      // Icon ionic-md-stats
                                      '<svg viewBox="0.0 0.0 7.16 6.49" ><path transform="translate(-7.28, -4.5)" d="M 12.375 4.5 L 14.4415283203125 4.5 L 14.4415283203125 10.99432468414307 L 12.375 10.99432468414307 L 12.375 4.5 Z" fill="#dfdfdf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-5.62, -22.47)" d="M 5.625 23.625 L 7.4805908203125 23.625 L 7.4805908203125 28.9595947265625 L 5.625 28.9595947265625 L 5.625 23.625 Z" fill="#dfdfdf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-3.2, -21.07)" d="M 5.625 23.625 L 7.7459716796875 23.625 L 7.7459716796875 27.5679931640625 L 5.625 27.5679931640625 L 5.625 23.625 Z" fill="#dfdfdf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                      width: 7.16,
                                      height: 6.49,
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment(0.0, 0.33),
                                    child: isTotalClick
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                isTotalClick = !isTotalClick;
                                              });
                                            },
                                            child: Container(
                                              child: Text(
                                                'Totals',
                                                style: TextStyle(
                                                  fontFamily: 'regu',
                                                  fontSize: 16.0,
                                                  color:
                                                      const Color(0xFF34A1E9),
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          )
                                        : myTagButton(
                                            text: "Totals",
                                            onTap: () {
                                              setState(() {
                                                isTotalClick = !isTotalClick;
                                              });
                                            }),
                                  ),

                                  UIHelper.horizontalSpaceSm,
                                  // Group: Group 32
                                  myTagButton(text: "Rank", onTap: () {}),
                                  myTagButton(text: "Avgs", onTap: () {}),
                                  myTagButton(text: "Other", onTap: () {}),
                                ],
                              ),
                            ),
                          ),
                          isTotalClick
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 73,
                                          height: 45,
                                          child: Stack(
                                            children: [
                                              SvgPicture.string(
                                                // Path 13
                                                '<svg viewBox="0.0 2.3 73.0 44.27" ><path transform="translate(-2894.15, -1212.75)" d="M 2894.145263671875 1215.049072265625 L 2967.145263671875 1215.049072265625 L 2956.716796875 1238.005493164062 L 2967.145263671875 1259.322143554688 L 2894.145263671875 1259.322143554688 L 2894.145263671875 1215.049072265625 Z" fill="#db0303" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                                width: 73.0,
                                                height: 44.27,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                              child: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'Calibri',
                                                fontSize: 20.0,
                                                color: const Color(0xFF707070),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'John ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'vs.',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFFF0000),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' Cougars\n',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      'Lifetime Statistics | ',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '23',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color:
                                                        const Color(0xFFFF0000),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' Games',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              //TODO: onTap Path 14
                                              print('onTap Path 14');
                                            },
                                            child: SvgPicture.string(
                                              // Path 14
                                              '<svg viewBox="341.0 2.3 73.0 44.27" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 3308.15, 1261.62)" d="M 2894.145263671875 1215.049072265625 L 2967.145263671875 1215.049072265625 L 2956.716796875 1238.005493164062 L 2967.145263671875 1259.322143554688 L 2894.145263671875 1259.322143554688 L 2894.145263671875 1215.049072265625 Z" fill="#db0303" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                              width: 73.0,
                                              height: 44.27,
                                            )),
                                      ],
                                    ),
                                    UIHelper.verticalSpaceSm,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        resultDataExpand(
                                            title: "FG\n",
                                            text: "13\n3\n2\n",
                                            result: '17'),
                                        resultDataExpand(
                                            title: "FGA\n",
                                            text: "34\n23\n4\n",
                                            result: '61'),

                                        percentRndExpand(),

                                        customLine(),
                                        // Group: Group 10
                                        Container(
                                          width: 80,
                                          child: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'regu',
                                                fontSize: 16.0,
                                                color: const Color(0xFF161616),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '2PT\n3PT\nFT\n',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Total',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFDB0303),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        customLine(),
                                        resultDataExpand(
                                            title: "FG\n",
                                            text: "13\n3\n2\n",
                                            result: '17'),
                                        resultDataExpand(
                                            title: "FGA\n",
                                            text: "34\n23\n4\n",
                                            result: '61'),

                                        percentRndExpand(),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReboundResult(
                                            title: "Rebounds\n",
                                            text: "12\n12\n",
                                            result: "24\n"),
                                        ReboundResult(
                                            title: "Assists\n",
                                            text: "3\n3\n",
                                            result: "6\n"),
                                        customLine(),
                                        Container(
                                          width: 80,
                                          child: Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                fontFamily: 'regu',
                                                fontSize: 16.0,
                                                color: const Color(0xFF161616),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Offensive\nDefensive\n',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'Total',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFDB0303),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        customLine(),
                                        ReboundResult(
                                            title: "Rebounds\n",
                                            text: "12\n12\n",
                                            result: "24\n"),
                                        ReboundResult(
                                            title: "Assists\n",
                                            text: "3\n3\n",
                                            result: "6\n"),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),

                    //  UIHelper.verticalSpaceMd,
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              SvgPicture.string(
                                // Icon awesome-video
                                '<svg viewBox="6.0 551.0 20.04 15.0" ><path transform="translate(6.0, 546.5)" d="M 11.69940567016602 4.499999523162842 L 1.663389563560486 4.499999523162842 C 0.7446973919868469 4.499999523162842 0 5.335937023162842 0 6.367188930511475 L 0 17.6328125 C 0 18.6640625 0.7446973919868469 19.5 1.663389563560486 19.5 L 11.69940567016602 19.5 C 12.61809825897217 19.5 13.36279392242432 18.6640625 13.36279392242432 17.6328125 L 13.36279392242432 6.367188930511475 C 13.36279392242432 5.335937023162842 12.61809635162354 4.499999523162842 11.69940567016602 4.499999523162842 Z M 18.29032325744629 5.972655773162842 L 14.47636222839355 8.925782203674316 L 14.47636222839355 15.07422065734863 L 18.29032325744629 18.02343559265137 C 19.02806282043457 18.59374809265137 20.044189453125 18.01171493530273 20.044189453125 17.01562309265137 L 20.044189453125 6.980468273162842 C 20.044189453125 5.988280773162842 19.03154373168945 5.402342319488525 18.29032325744629 5.972655773162842 Z" fill="#ebebeb" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                width: 20.04,
                                height: 15.0,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Align(
                                alignment: Alignment(0.0, 0.17),
                                child: Text(
                                  'Highlights',
                                  style: TextStyle(
                                    fontFamily: 'regu',
                                    fontSize: 16.0,
                                    color: const Color(0xFF585858),
                                  ),
                                ),
                              ),
                              //  Spacer(),

                              UIHelper.horizontalSpaceSm,
                              Align(
                                alignment: Alignment(0.0, 0.33),
                                child: !isTotalClick
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            isTotalClick = false;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            'All',
                                            style: TextStyle(
                                              fontFamily: 'regu',
                                              fontSize: 16.0,
                                              color: const Color(0xFF34A1E9),
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      )
                                    : myTagButton(
                                        text: "All",
                                        onTap: () {
                                          setState(() {
                                            isTotalClick = false;
                                          });
                                        }),
                              ),

                              //   myTagButton(text: "All", onTap: () {}),
                              myTagButton(text: "2PT", onTap: () {}),
                              myTagButton(text: "3PT", onTap: () {}),
                              myTagButton(text: "All", onTap: () {}),
                              myTagButton(text: "2PT", onTap: () {}),
                              myTagButton(text: "3PT", onTap: () {}),
                              // Group: Group 32
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Container(
                                width: size.width * 0.4,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                height: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage("images/hawks.png")),
                                  color: Colors.black.withOpacity(1),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: size.width * 0.4,
                                      height: 80,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Hawks",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "bold",
                                                fontSize: 18)),
                                        Text("VS",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "bold",
                                                fontSize: 14)),
                                        Text("Red Bull",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "bold",
                                                fontSize: 18))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    !isTotalClick
                        ? Container(
                            width: size.width,
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("images/team1.png"))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Hawks\n\nBangles',
                                    style: TextStyle(
                                      fontFamily: 'regu',
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      height: 0.63,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.16),
                                          offset: Offset(0, 3.0),
                                          blurRadius: 6.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Padding imagesHeader(
    Size size,
    FollowingViewModel followingViewModel,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Row(
            children: [
              Stack(
                children: <Widget>[
// Group: Group 9
                  Container(
                    height: 105.0,
                    width: size.width * 0.5 - 10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/jhon.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.red,
                      border: Border.all(
                        width: 3.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 16.0,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 6.0,
                            ),
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
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 28.0,
                    child: Text(
                      'Player:',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 10.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: Offset(0, 3.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
// Group: Group 9
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFirstIsActive = true;
                            _animationControllerForSearchButton.reset();
                            _animationControllerForSearchButton.forward();
                          });
                        },
                        child: Container(
                          height: 105.0,
                          width: isFirstIsActive
                              ? size.width * 0.33 - 5
                              : size.width * 0.17 - 5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  followingViewModel.selectedTeamModel!.image),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              width: 3.0,
                              color: Colors.white,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'regu',
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black
                                                  .withOpacity(0.16),
                                              offset: Offset(0, 3.0),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: followingViewModel
                                                .selectedTeamModel!.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      followingViewModel
                                          .selectedTeamModel!.type,
                                      style: TextStyle(
                                        fontFamily: 'regu',
                                        fontSize: 10.0,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.16),
                                            offset: Offset(0, 3.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: !isFirstIsActive
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.transparent,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFirstIsActive = false;
                            _animationControllerForSearchButton.reverse();
                          });
                        },
                        child: Container(
                          height: 105.0,
                          width: isFirstIsActive
                              ? size.width * 0.17 - 5
                              : size.width * 0.33 - 5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/hawks.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              width: 3.0,
                              color: Colors.white,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'regu',
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black
                                                  .withOpacity(0.16),
                                              offset: Offset(0, 3.0),
                                              blurRadius: 6.0,
                                            ),
                                          ],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: followingViewModel
                                                .selectedTeamModel!.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      followingViewModel
                                          .selectedTeamModel!.type,
                                      style: TextStyle(
                                        fontFamily: 'regu',
                                        fontSize: 10.0,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.16),
                                            offset: Offset(0, 3.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: isFirstIsActive
                                    ? Colors.white.withOpacity(0.5)
                                    : Colors.transparent,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 5),
              alignment: Alignment.center,
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border.all(
                  width: 3.0,
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: Text(
                  'VS',
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 18.0,
                    color: const Color(0xFFDB0303),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SlideTransition(
            position: _animationForSearchButton,
            child: InkWell(
              onTap: () {
                if (followingViewModel.selectedTeamModel!.type == "Player:") {
                  followingViewModel.changeWidget(
                      key: "specificgamesearchteam");
                } else {
                  followingViewModel.changeWidget(key: "choosevsgamecalender");
                }
              },
              child: Container(
                width: 40.0,
                height: 40.0,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFF1F1F1).withOpacity(0.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ],
                ),
                child: SvgPicture.string(
                  // Icon open-magnifying-glass
                  '<svg viewBox="5.34 5.48 31.19 31.19" ><path transform="translate(5.34, 5.52)" d="M 13.5218563079834 -0.006366134155541658 C 6.065518379211426 -0.006366134155541658 0 6.059152126312256 0 13.51549053192139 C 0 20.97182846069336 6.065518379211426 27.03734588623047 13.5218563079834 27.03734588623047 C 15.80125617980957 27.03734588623047 18.04201889038086 26.49647331237793 19.93507957458496 25.4533576965332 C 20.08671569824219 25.63583755493164 20.25483894348145 25.8039608001709 20.43731880187988 25.95559692382812 L 24.30070686340332 29.81898307800293 C 25.27272796630859 30.91272735595703 26.77075386047363 31.37782096862793 28.19129753112793 31.02690505981445 C 29.61184501647949 30.67598915100098 30.72098731994629 29.56684494018555 31.07190704345703 28.14629936218262 C 31.42282295227051 26.72575187683105 30.95772552490234 25.22772598266602 29.86398696899414 24.25570678710938 L 26.0005989074707 20.39231872558594 C 25.81240272521973 20.20405769348145 25.60525512695312 20.03575134277344 25.3824577331543 19.89008140563965 C 26.42557144165039 17.99701881408691 27.08234786987305 15.79488849639893 27.08234786987305 13.47685718536377 C 27.08234786987305 6.020517826080322 21.0168285369873 -0.04500007629394531 13.56049060821533 -0.04500007629394531 Z M 13.5218563079834 3.857021331787109 C 18.89196586608887 3.857021331787109 23.18032646179199 8.145381927490234 23.18032646179199 13.51549053192139 C 23.18032646179199 16.0653247833252 22.25311279296875 18.42199325561523 20.63049125671387 20.1605167388916 C 20.59185600280762 20.19915008544922 20.55322265625 20.23778343200684 20.51458930969238 20.27641868591309 C 20.33210945129395 20.42805290222168 20.16398429870605 20.59617614746094 20.01234817504883 20.77865600585938 C 18.31245803833008 22.32401275634766 15.99442577362061 23.21259117126465 13.4832239151001 23.21259117126465 C 8.113115310668945 23.21259117126465 3.824755191802979 18.92423248291016 3.824755191802979 13.55412292480469 C 3.824755191802979 8.184013366699219 8.113115310668945 3.89565372467041 13.4832239151001 3.89565372467041 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 25.19,
                  height: 25.19,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded percentRndExpand() {
    return Expanded(
        child: // Group: Group 24
            SizedBox(
      width: 41.0,
      height: 105.24,
      child: Text.rich(
        TextSpan(
          style: TextStyle(
            fontFamily: 'regu',
            fontSize: 16.0,
            color: const Color(0xFF161616),
          ),
          children: [
            TextSpan(
              text: '% ',
              style: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              text: '(RND)\n',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            TextSpan(
              text: '36%\n13%\n50%\n',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: '28%',
              style: TextStyle(
                color: const Color(0xFFDB0303),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ) // Group: Group 24
        );
  }

  Expanded resultDataExpand({var title, var text, var result}) {
    return Expanded(
        child: Column(
      children: [
        // Group: Group 22
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 16.0,
              color: const Color(0xFF161616),
            ),
            children: [
              TextSpan(
                text: title,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: result,
                style: TextStyle(
                  color: const Color(0xFFDB0303),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }

  Expanded ReboundResult({var title, var text, var result}) {
    return Expanded(
        child: // Group: Group 43
            Text.rich(
      TextSpan(
        style: TextStyle(
          fontFamily: 'regu',
          fontSize: 16.0,
          color: const Color(0xFF161616),
        ),
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: result,
            style: TextStyle(
              color: const Color(0xFFDB2020),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ));
  }

  Widget customLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SvgPicture.string(
        // Line 7
        '<svg viewBox="159.5 76.75 1.0 63.0" ><path transform="translate(159.5, 76.75)" d="M 0 0 L 1 63" fill="none" stroke="#ebebeb" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
        width: 0.3,
        height: 100.0,
      ),
    );
  }

  Widget myTagButton({var text, var onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment(0.24, 0.33),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 28.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xFFF1F1F1),
            border: Border.all(
              width: 1.0,
              color: const Color(0xFF34A1E9),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'regu',
              fontSize: 16.0,
              color: const Color(0xFF34A1E9),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
