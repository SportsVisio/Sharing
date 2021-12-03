import 'package:flutter/material.dart';
import 'package:mvp/Screens/Watching/WatchingViewModel.dart';
import 'package:mvp/core/constants/Colors.dart';
import 'package:provider/provider.dart';

class GridItem extends StatefulWidget {
  final String imageUrl;
  final List<String> teams;
  int index;
  GridItem(this.imageUrl, this.teams, this.index, {Key? key}) : super(key: key);

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<WatchingViewModel>(context, listen: false)
            .changeWidget(key: "PlayerClicked");
      },
      child: Stack(
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
                    textAlign: TextAlign.center,
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Align(
                alignment: Alignment.topRight,
                child: ImageIcon(
                  AssetImage(
                    widget.index < 2 ? 'images/view.png' : "images/stream.png",
                  ),
                  color: widget.index < 2 ? MyColors.redColor : Colors.blueGrey,
                  size: 30,
                )),
          )
        ],
      ),
    );
    //});
  }
}
