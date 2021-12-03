import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/core/constants/Colors.dart';

class HeaderTile extends StatelessWidget {
  final String name;
  const HeaderTile(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: ListTileTheme(
          minVerticalPadding: 0,
          tileColor: HexColor("#DB0303"),
          selectedColor: Colors.white,
          textColor: Colors.white,
          child: ListTile(
            // initiallyExpanded: viewModel.isFollowExpanded,
            // maintainState: viewModel.isFollowExpanded,
            key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
            leading: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'regu',
                  fontSize: 20,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            title: Container(),
          )),
    );
  }
}
