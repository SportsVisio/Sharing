import 'package:flutter/material.dart';
import 'package:mvp/Screens/Watching/GridItem.dart';

class WatchItem extends StatelessWidget {
  final animationForAddButton;
  const WatchItem(this.animationForAddButton, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
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
            return GridItem('images/hawks.png', ['Hawks', 'Bullets'], index);
          },
        ),
      ),
    );
  }
}
