import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Widgets/ExpandedTrailling.dart';
import 'package:mvp/core/view_models/ExpandedViewModel.dart';
import 'package:provider/provider.dart';

class watchliveExpan extends StatefulWidget {
  const watchliveExpan({Key? key}) : super(key: key);

  @override
  _watchliveExpanState createState() => _watchliveExpanState();
}

class _watchliveExpanState extends State<watchliveExpan> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ExpandedViewModel>(builder: (context, viewModel, child) {
      return ListTileTheme(
        minVerticalPadding: 0,
        tileColor: HexColor("#DB0303"),
        selectedColor: Colors.white,
        textColor: Colors.white,
        child: ExpansionTile(
          initiallyExpanded: viewModel.isStreamingExpand,
          maintainState: viewModel.isStreamingExpand,
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
          // trailing: // Adobe XD layer: 'Icon awesome-expand…' (shape)
          //     expandedTrailling(),
          onExpansionChanged: (value) {
            // changeExpands(isStreamingExpand);
            print(value.toString());
            // changeExpands(isFollowExpanded);
            viewModel.changeExpandState('streaming', value);
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
    });
  }
}
