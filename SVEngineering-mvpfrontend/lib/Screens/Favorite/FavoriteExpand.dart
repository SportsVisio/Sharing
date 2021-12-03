import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Widgets/ExpandedTrailling.dart';
import 'package:mvp/core/view_models/ExpandedViewModel.dart';
import 'package:provider/provider.dart';

class FavoriteExpandWidget extends StatefulWidget {
  const FavoriteExpandWidget({Key? key}) : super(key: key);

  @override
  _FavoriteExpandWidgetState createState() => _FavoriteExpandWidgetState();
}

class _FavoriteExpandWidgetState extends State<FavoriteExpandWidget> {
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
          initiallyExpanded: viewModel.isFavoritExpand,
          maintainState: viewModel.isFavoritExpand,
          key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Favorites',
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
          // trailing: expandedTrailling(),
          onExpansionChanged: (value) {
            print(value.toString());
            // changeExpands(isFollowExpanded);
            viewModel.changeExpandState("favorite", value);
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
                      return Container(
                        width: size.width * 0.3,
                        margin: EdgeInsets.symmetric(horizontal: 5),
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
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Image.asset(
                                  "images/star.png",
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                              Spacer(),
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
