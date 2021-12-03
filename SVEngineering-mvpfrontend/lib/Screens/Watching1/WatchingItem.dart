import 'package:flutter/material.dart';
import 'package:mvp/Screens/Watching/WatchingViewModel.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:provider/provider.dart';

class WatchingItem extends StatelessWidget {
  final String imageUrl;
  final List<String> teams;
  const WatchingItem(this.imageUrl, this.teams, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<WatchingViewModel>(
        builder: (context, watchingViewModel, child) {
      return InkWell(
        /* onTap: () {
          Provider.of<WatchingViewModel>(context, listen: false)
              .changeWidget(key: "PlayerClicked");
        }, */
        child: Stack(
          children: [
            Container(
              height: size.height * .1,
              width: size.width * .4,
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
                      teams[0],
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
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      teams[1],
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
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
