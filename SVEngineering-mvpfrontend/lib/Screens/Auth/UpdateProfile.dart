import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Screens/Auth/AuthButton.dart';
import 'package:mvp/Widgets/sportsvisio_form_field.dart';
import 'package:mvp/core/constants/Colors.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

//k
class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Color text = HexColor('#135bf1');
    return Scaffold(
      backgroundColor: MyColors.authColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * .1,
            ),
            Text(
              '<Nickname\'s> Profile',
              style: TextStyle(
                  fontFamily: 'regu',
                  fontSize: 35,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            SportsVisioFormField(
              hint: 'Nickname',
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                    child: Container(
                  height: size.height * .2,
                  width: size.width * .6,
                  child: Icon(Icons.account_circle_sharp),
                )),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.camera_front, size: 40))
              ],
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Text(
              'Team Profile',
              style: TextStyle(
                  fontFamily: 'regu',
                  fontSize: 30,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold),
            ),
            SportsVisioFormField(
              hint: 'Team Name',
            ),
            SizedBox(height: 20),
            SportsVisioFormField(
              hint: 'League Name',
            ),
            SizedBox(height: 20),
            AuthButton(
              text: 'Update',
              action: () {},
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                          fontFamily: 'regu',
                          color: text,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    )),
                Text(
                  '|',
                  style: TextStyle(
                      fontFamily: 'regu',
                      color: Colors.blueAccent[700],
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change Email',
                      style: TextStyle(
                          fontFamily: 'regu',
                          color: text,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
