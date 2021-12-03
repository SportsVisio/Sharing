import 'package:flutter/material.dart';

class WatchLive extends StatelessWidget {
  final Size size;
  const WatchLive(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: "addbutto",
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
            'Live videos will be displayed here based on the \nplayers and teams you follow',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          )
        ],
      ),
    );
  }
}
