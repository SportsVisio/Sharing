import 'package:flutter/material.dart';

class HeroText extends StatelessWidget {
  final Size size;
  const HeroText(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Hero(
        tag: "addbutton",
        child: Container(
          width: size.width * 0.3,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blue, width: 5)),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.blue,
              size: 80,
            ),
          ),
        ),
      ),
      Expanded(
          child: Container(
        padding:
            const EdgeInsets.only(top: 3.0, bottom: 3.0, right: 8, left: 15),
        height: 55,
        child: Card(
          elevation: 3,
          child: TextFormField(
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.black38, fontSize: 18),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                border: InputBorder.none,
                // border: OutlineInputBorder(
                //     borderSide: new BorderSide(
                //         color: Colors.black38, style: BorderStyle.none)),
                hintText: 'Search Text'),
          ),
        ),
      ))
    ]);
  }
}
