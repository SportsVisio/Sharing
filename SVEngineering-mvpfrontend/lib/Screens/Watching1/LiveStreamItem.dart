import 'package:flutter/material.dart';

class LiveStreamItem extends StatelessWidget {
  const LiveStreamItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height * .45,
          width: size.width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/hawks.png'), fit: BoxFit.cover)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15),
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.notifications,
              size: 65,
              color: Colors.yellow,
            ),
          ),
        )
      ],
    );
  }
}
