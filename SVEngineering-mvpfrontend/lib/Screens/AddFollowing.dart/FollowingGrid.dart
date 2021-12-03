import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/FollowingItem.dart';
import 'package:mvp/Screens/AddFollowing.dart/Models/FollowingModel.dart';
import 'package:provider/provider.dart';

class FollowingGrid extends StatelessWidget {
  final size;
  const FollowingGrid({this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7),
      child: GridView.builder(
        itemCount: 21,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 8),
        itemBuilder: (BuildContext context, index) {
          return index < 1
              ? GestureDetector(
                  onTap: () {
                    Provider.of<FollowingModel>(context, listen: false)
                        .changeWidget(key: "PlayerClicked");
                  },
                  child: Hero(
                    tag: "AddButton",
                    child: Container(
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 5)),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 80,
                        ),
                      ),
                    ),
                  ),
                )
              : FollowingItem(
                  'images/jhon.png',
                  'Aaron J.',
                );
          //GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
        },
      ),
    );
  }
}
