import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/Screens/Following/model/SpecificGameSearchModel.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';

class SpecificGameSearchView extends StatefulWidget {
  const SpecificGameSearchView({Key? key}) : super(key: key);

  @override
  _SpecificGameSearchViewState createState() => _SpecificGameSearchViewState();
}

class _SpecificGameSearchViewState extends State<SpecificGameSearchView> {
  List<SpecificGameSearchModel> arrGames = [
    SpecificGameSearchModel(title: "Summer League", arrGames: [
      TeamAndDate(teams: "Cougars vs Bulls", date: "June 23 @ 4pm"),
      TeamAndDate(teams: "Cougars vs Bulls", date: "July 23 @ 2pm")
    ]),
    SpecificGameSearchModel(title: "Spring League", arrGames: [
      TeamAndDate(teams: "Cougars vs Bulls", date: "May 23 @ 2pm"),
    ]),
  ];
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
            imagesHeader(size, followingViewModel),
            UIHelper.verticalSpaceSm,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 18.0,
                        color: const Color(0xFF565656),
                      ),
                      children: [
                        TextSpan(
                          text: 'Text Space\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'We can give instructions, show graphics, etc in this space.',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: const Color(0xFFA1A1A1),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: arrGames.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    index != 0
                                        ? UIHelper.verticalSpaceL
                                        : Container(),
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'regu',
                                          fontSize: 14.0,
                                          color: const Color(0xFFB1B1B1),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: arrGames[index].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' | Date to Date',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            arrGames[index].arrGames!.length,
                                        itemBuilder: (context, ind) {
                                          return InkWell(
                                            onTap: () {
                                              //TODO: onTap Component 14 – 1
                                              print('onTap Component 14 – 1');
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              alignment: Alignment(-0.77, 0.27),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: const Color(0xFFF6F6F6),
                                                border: Border.all(
                                                  width: 1.0,
                                                  color:
                                                      const Color(0xFFF3F3F3),
                                                ),
                                              ),
                                              child: Text.rich(
                                                TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'Calibri',
                                                    fontSize: 16.0,
                                                    color:
                                                        const Color(0xFF484848),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Cougars ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'vs',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' Bulls \n',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: 'June 23',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' @',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: const Color(
                                                            0xFFDA0202),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' 4pm',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                );
                              })))
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Padding imagesHeader(Size size, FollowingViewModel followingViewModel) {
    return Padding(
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
                    width: size.width * 0.5 - 1,
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
              )),
              Expanded(
                  child: // Group: Group 13

                      Stack(
                children: <Widget>[
// Group: Group 9
                  Container(
                    height: 105.0,
                    width: size.width * 0.5 - 1,
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
                            text: followingViewModel.selectedTeamModel!.name,
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
                      followingViewModel.selectedTeamModel!.type,
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
        ],
      ),
    );
  }
}
