import 'package:flutter/material.dart';

class AddFollowingItem extends StatelessWidget {
  final String imageUrl;
  final String playerName;
  const AddFollowingItem(this.imageUrl, this.playerName, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageUrl), fit: BoxFit.cover)),
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
                  playerName,
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
      ],
    );
    //});
  }
}
