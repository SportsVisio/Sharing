import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddPlayer/Views/AddPlayerScreen.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/Screens/Following1/FollowingScreen.dart';
import 'package:mvp/core/view_models/ExpandedViewModel.dart';
import 'package:provider/provider.dart';

class playerListView extends StatefulWidget {
  const playerListView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<playerListView> createState() => _playerListViewState();
}

class _playerListViewState extends State<playerListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FollowingViewModel>(
        builder: (context, followingViewModel, child) {
      return Container(
        child: followingViewModel.isLoading
            ? Container(
                height: 40,
                width: 40,
                margin: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              )
            : Container(
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: followingViewModel
                            .listFollowedPlayers[0].teamPlayerAssn.length +
                        1,
                    itemBuilder: (context, index) {
                      return index <
                              followingViewModel
                                  .listFollowedPlayers[0].teamPlayerAssn.length
                          ? InkWell(
                              onTap: () {
                                Provider.of<FollowingViewModel>(context,
                                        listen: false)
                                    .changeWidget(key: "playerClick");
                                Provider.of<ExpandedViewModel>(context,
                                        listen: false)
                                    .changeExpandState("following", true);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FollowingScreen()));
                              },
                              child: Container(
                                width: widget.size.width * 0.3,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              text:
                                                  '${followingViewModel.listFollowedPlayers[0].teamPlayerAssn[index].player.name}',
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
                                      ),
                                      SizedBox(
                                        height: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AddPlayerScreen()));
                              },
                              child: Hero(
                                tag: "addbutton",
                                child: Container(
                                  width: widget.size.width * 0.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blue, width: 5)),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                      size: 80,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }),
              ),
      );
    });
  }
}
