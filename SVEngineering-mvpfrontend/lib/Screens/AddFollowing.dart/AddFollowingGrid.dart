import 'package:flutter/material.dart';
import 'package:mvp/Screens/AddFollowing.dart/AddFollowingItem.dart';

class AddFollowingGrid extends StatelessWidget {
  const AddFollowingGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 12,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 8),
      itemBuilder: (BuildContext context, index) {
        return AddFollowingItem('images/hawks.png', 'John T.');
      },
    );
  }
}
