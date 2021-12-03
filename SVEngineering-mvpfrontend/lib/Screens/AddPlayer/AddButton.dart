import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final Size size;
  const AddButton(this.size, {Key? key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "addbutton",
                child: Container(
                  width: widget.size.width * 0.25,
                  height: widget.size.width * 0.25,
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
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: widget.size.width * 0.45,
                    height: widget.size.height * 0.035,
                    decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.black12)),
                    child: Text(
                      'Add Player',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: widget.size.width * 0.45,
                    height: widget.size.height * 0.035,
                    decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.black12)),
                    child: Text(
                      'Add Team',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(width: 10),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 4, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Icon(
                  Icons.arrow_upward_rounded,
                  size: 30,
                  color: Colors.blue[100],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(width: 4, color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Icon(
                  Icons.arrow_upward_rounded,
                  size: 30,
                  color: Colors.blue[100],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
