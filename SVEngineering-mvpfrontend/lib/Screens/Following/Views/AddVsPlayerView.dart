import 'package:flutter/material.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/Screens/Following/model/PlayerModel.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';

class AddVsPlayerView extends StatefulWidget {
  var animationForVSButton;
  AddVsPlayerView({this.animationForVSButton});
  @override
  _AddVsPlayerViewState createState() => _AddVsPlayerViewState();
}

class _AddVsPlayerViewState extends State<AddVsPlayerView> {
  List<PlayerModel> arrPlayers = [
    PlayerModel(name: "Ben J.", type: "Player:", image: "images/benj.png"),
    PlayerModel(name: "Acme.", type: "Team:", image: "images/hawks.png"),
    PlayerModel(name: "Cougars.", type: "Team", image: "images/myteam.png")
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          UIHelper.verticalSpaceSm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: size.width,
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
                        width: 1,
                      ),
                      Container(
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
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SlideTransition(
                      position: widget.animationForVSButton,
                      // child: Container(
                      //   alignment: Alignment(0.25, 0.25),
                      //   width: 50.0,
                      //   height: 50.0,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withOpacity(1),
                      //     border: Border.all(
                      //       width: 3.0,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      //   child: Text(
                      //     'VS',
                      //     style: TextStyle(
                      //       fontFamily: 'regu',
                      //       fontSize: 26.0,
                      //       color: const Color(0xFFDB0303),
                      //       fontWeight: FontWeight.w700,
                      //       height: 0.38,
                      //     ),
                      //   ),
                      // ),

                      child: Container(
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
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width * 0.5 - 5,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'Calibri',
                          fontSize: 18.0,
                          color: const Color(0xFF565656),
                        ),
                        children: [
                          TextSpan(
                            text: '\n\nVS Mode\n',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text:
                                'VS Mode allows you to quickly see how any player, team, or league stacks up against one another.\n\nType text into the ',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: const Color(0xFFA1A1A1),
                            ),
                          ),
                          TextSpan(
                            text: '+',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: const Color(0xFF34A1E9),
                            ),
                          ),
                          TextSpan(
                            text: ' box to filter your results.',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: const Color(0xFFA1A1A1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: arrPlayers.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  // if (arrPlayers[index].type == "Player:") {
                                  Provider.of<FollowingViewModel>(context,
                                          listen: false)
                                      .changeWidget(
                                          key: "teamlifelongresult",
                                          selectedTeam: arrPlayers[index]);
                                  //}
                                },
                                child: Container(
                                  height: 100,
                                  width: size.width * 0.5 - 5,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage(arrPlayers[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.white,
                                      ),
                                      color: Colors.red),
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
                                        text: arrPlayers[index].name,
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
                                  arrPlayers[index].type,
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
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
