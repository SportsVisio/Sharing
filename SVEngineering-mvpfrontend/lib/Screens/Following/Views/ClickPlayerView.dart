import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';

class ClickPlayerView extends StatefulWidget {
  var animationForAddButton;
  ClickPlayerView({this.animationForAddButton});

  @override
  _ClickPlayerViewState createState() => _ClickPlayerViewState();
}

class _ClickPlayerViewState extends State<ClickPlayerView> {
  List<String> _dropdownItems = [
    "2017-2018",
    "2018-2019",
    "2019-2020",
    "2020-2021"
  ];
  bool isTotalClick = true;
  var _chosenValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          UIHelper.verticalSpaceSm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: // Group: Group 13

                            Stack(
                      children: <Widget>[
// Group: Group 9
                        Container(
                          height: 105.0,
                          width: size.width * 0.5 - 5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/jhon.png'),
                              fit: BoxFit.cover,
                            ),
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
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    SizeTransition(
                      sizeFactor: widget.animationForAddButton,
                      axis: Axis.horizontal,
                      child: InkWell(
                        onTap: () {
                          Provider.of<FollowingViewModel>(context,
                                  listen: false)
                              .changeWidget(key: "addvsplayerclick");
                        },
                        child: Container(
                          height: 100,
                          width: size.width * 0.5 - 5,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(241, 241, 241, 1),
                              border: Border.all(color: Colors.blue, width: 5)),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.blue,
                              size: 80,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 25,
                  right: 10,
                  child: Container(
                    alignment: Alignment(0.25, 0.25),
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      border: Border.all(
                        width: 3.0,
                        color: Colors.white,
                      ),
                    ),
                    child: Text(
                      'VS',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 26.0,
                        color: const Color(0xFFDB0303),
                        fontWeight: FontWeight.w700,
                        height: 0.38,
                      ),
                    ),
                  ),
                )
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
                                                color: const Color(0xFF34A1E9),
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
                                        width: 110,
                                        height: 45,
                                        child: Stack(
                                          children: [
                                            SvgPicture.string(
                                              // Path 13
                                              '<svg viewBox="0.0 2.3 110.0 44.27" ><path transform="translate(-2834.15, -1212.75)" d="M 2834.145263671875 1215.049072265625 L 2944.145263671875 1215.049072265625 L 2937.10791015625 1238.005493164062 L 2944.145263671875 1259.322143554688 L 2834.145263671875 1259.322143554688 L 2834.145263671875 1215.049072265625 Z" fill="#db0303" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                              width: 110.0,
                                              height: 44.27,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Lifetime',
                                                style: TextStyle(
                                                  fontFamily: 'regu',
                                                  fontSize: 18.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        child: Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'regu',
                                              fontSize: 20.0,
                                              color: const Color(0xFF707070),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'John T\n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: 'Statistics | ',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '30',
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
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          //TODO: onTap Path 14
                                          print('onTap Path 14');
                                        },
                                        child: Container(
                                          width: 110,
                                          child: Stack(
                                            children: [
                                              SvgPicture.string(
                                                // Path 1
                                                '<svg viewBox="306.0 2.3 110.0 44.27" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 416.0, 46.57)" d="M 0 0 L 110 0 L 102.9623794555664 22.9564208984375 L 110 44.2730712890625 L 0 44.2730712890625 L 0 0 Z" fill="#db0303" fill-opacity="0.5" stroke="none" stroke-width="1" stroke-opacity="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                                                width: 110.0,
                                                height: 44.27,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: DropdownButton<String>(
                                                  focusColor: Colors.white,
                                                  value: _chosenValue,
                                                  alignment: Alignment.center,
                                                  dropdownColor:
                                                      MyColors.redColor,
                                                  iconSize: 0,

                                                  //elevation: 5,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  //  iconEnabledColor: Colors.transparent,
                                                  items: _dropdownItems.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Container(
                                                        width: 110,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          value,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  icon: Container(),

                                                  hint: Text(
                                                    'Season',
                                                    style: TextStyle(
                                                      fontFamily: 'regu',
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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

                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: 100,
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              'Additional\nStatistics in\nFinal MVP',
                                              style: TextStyle(
                                                fontFamily: 'regu',
                                                fontSize: 18.0,
                                                color: const Color(0xFFDB0303),
                                                fontWeight: FontWeight.w700,
                                                height: 1.22,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
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
                                              text: 'Rebounds\n',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '12\n12\n',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '24\n',
                                              style: TextStyle(
                                                color: const Color(0xFFDB2020),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                      Expanded(
                                          child: SizedBox(
                                        width: 76.0,
                                        height: 78.98,
                                        child: Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'regu',
                                              fontSize: 16.0,
                                              color: const Color(0xFF161616),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Assists\n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '3\n3\n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '6\n',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFFDB2020),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
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
                                                text: 'Offensive\nDefensive\n',
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
                                      Expanded(child: Container()),
                                      Expanded(child: Container())
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
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

                  // UIHelper.verticalSpaceSm,

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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
