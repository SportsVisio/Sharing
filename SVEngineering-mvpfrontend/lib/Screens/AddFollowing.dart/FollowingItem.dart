import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/Dialog.dart';
import 'package:mvp/Screens/AddFollowing.dart/Models/FollowingModel.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:provider/provider.dart';

class FollowingItem extends StatefulWidget {
  final String imageUrl;
  final String playerName;
  const FollowingItem(this.imageUrl, this.playerName, {Key? key})
      : super(key: key);

  @override
  State<FollowingItem> createState() => _FollowingItemState();
}

class _FollowingItemState extends State<FollowingItem>
    with TickerProviderStateMixin {
  bool isShowPlayerList = true;
  late AnimationController _animationControllerForAddButton;
  late AnimationController _animationControllerForVsButton;

  var _animationForAddButton;
  Animation<Offset>? _animationForVSButton;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _animationControllerForAddButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationControllerForVsButton =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animationForAddButton = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationControllerForAddButton, curve: Curves.linear));
    _animationForVSButton = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(-4.5, -0.3),
    ).animate(CurvedAnimation(
      parent: _animationControllerForVsButton,
      curve: Curves.easeInCubic,
    ));
    return Consumer<FollowingModel>(
        builder: (context, followingViewModel, child) {
      if (followingViewModel.isPlayerClick == true) {
        _animationControllerForAddButton.reset();
        _animationControllerForAddButton.forward();
      }
      if (followingViewModel.isAddVsPlayerClick == true) {
        _animationControllerForVsButton.reset();
        _animationControllerForVsButton.forward();
      }

      //@override
      //Widget build(BuildContext context) {
      /* return Consumer<WatchingViewModel>(
        builder: (context, watchingViewModel, child) {
      return  */
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.imageUrl), fit: BoxFit.cover)),
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 6),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Player:',
                    style: TextStyle(
                      fontFamily: 'regu',
                      fontSize: 14,
                      color: const Color(0xffffffff),
                      //fontWeight: FontWeight.w700,
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
                    height: 4,
                  ),
                  Text(
                    widget.playerName,
                    style: TextStyle(
                      fontFamily: 'regu',
                      fontSize: 20,
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    print('done');
                    showDialog(
                        context: context,
                        //put the animation here
                        builder: (BuildContext context) => ConfirmDialog(
                            widget.playerName,
                            _animationControllerForVsButton));
                  },
                  child: ImageIcon(
                    AssetImage(
                      'images/remove.png',
                    ),
                    color: Colors.white,
                    size: 30,
                  ),
                )),
          )
        ],
      );
    });
  }
}
