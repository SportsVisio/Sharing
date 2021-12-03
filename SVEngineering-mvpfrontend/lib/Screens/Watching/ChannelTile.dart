import 'package:flutter/material.dart';
import 'package:mvp/core/constants/Colors.dart';

class ChannelTile extends StatelessWidget {
  const ChannelTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 8,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ImageIcon(
                  AssetImage(
                    'images/view.png',
                  ),
                  color: Colors.black38,
                  size: 30,
                )),
            SizedBox(
              width: 5,
            ),
            Text(
              'Channel',
              style: TextStyle(
                fontFamily: 'regu',
                fontSize: 18,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(
                  top: 3.0, bottom: 3.0, right: 8, left: 15),
              height: 55,
              child: Card(
                elevation: 1,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      border: InputBorder.none,
                      // border: OutlineInputBorder(
                      //     borderSide: new BorderSide(
                      //         color: Colors.black38, style: BorderStyle.none)),
                      hintText: 'Sort by Team, League, or Player'),
                ),
              ),
            ))
          ],
        ));
  }
}
