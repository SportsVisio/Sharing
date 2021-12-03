import 'package:flutter/material.dart';

class AchievementWidget extends StatelessWidget {
  final Size size;
  const AchievementWidget(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: "but",
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 5)),
              child: Center(
                child: Icon(
                  Icons.lock_clock,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Hero(
            tag: "butt",
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 5)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Hero(
            tag: "buta",
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 5)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Text(
            'Earn Achievements by \nimproving and tracking your \nreal world skills with \nSportsVisio',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
        ],
      ),
    );
  }
}
