import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mvp/Widgets/ExpandedTrailling.dart';
import 'package:mvp/core/view_models/ExpandedViewModel.dart';
import 'package:provider/provider.dart';

class AchievementExpandWidget extends StatefulWidget {
  const AchievementExpandWidget({Key? key}) : super(key: key);

  @override
  _AchievementExpandWidgetState createState() =>
      _AchievementExpandWidgetState();
}

class _AchievementExpandWidgetState extends State<AchievementExpandWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ExpandedViewModel>(builder: (context, viewmodel, child) {
      return ListTileTheme(
        minVerticalPadding: 0,
        //     tileColor: Colors.red,
        tileColor: HexColor("#DB0303"),

        selectedColor: Colors.white,
        textColor: Colors.white,
        child: ExpansionTile(
          initiallyExpanded: viewmodel.isAchievementExpand,
          maintainState: viewmodel.isAchievementExpand,
          key: PageStorageKey("${DateTime.now().millisecondsSinceEpoch}"),
          leading: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Achievements',
              style: TextStyle(
                fontFamily: 'regu',
                fontSize: 16,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          title: Container(),
          // trailing: expandedTrailling(),
          onExpansionChanged: (value) {
            print(value.toString());
            viewmodel.changeExpandState("aceivement", value);
          },
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [achievementicon(timerIcon())],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    });
  }

  Container achievementicon(icon) {
    return Container(
      width: 55,
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 3, color: Colors.blue)),
      child: Center(
          child: // Adobe XD layer: 'Icon awesome-stopwa…' (shape)
              icon),
    );
  }

  SvgPicture timerIcon() {
    return SvgPicture.string(
      '<svg viewBox="11.5 8.0 29.3 36.0" ><path transform="translate(10.38, 8.0)" d="M 30.375 21.375 C 30.375 29.45390701293945 23.82890701293945 36 15.75 36 C 7.671092987060547 36 1.125 29.45390701293945 1.125 21.375 C 1.125 14.0625 6.489843845367432 8.001562118530273 13.5 6.92578125 L 13.5 4.5 L 11.53125 4.5 C 11.06718730926514 4.5 10.6875 4.120312690734863 10.6875 3.65625 L 10.6875 0.84375 C 10.6875 0.379687488079071 11.06718730926514 0 11.53125 0 L 19.96875 0 C 20.43281173706055 0 20.8125 0.379687488079071 20.8125 0.84375 L 20.8125 3.65625 C 20.8125 4.120312690734863 20.43281173706055 4.5 19.96875 4.5 L 18 4.5 L 18 6.92578125 C 20.63671875 7.333593845367432 23.04140663146973 8.444531440734863 25.01015663146973 10.06171894073486 L 26.94375038146973 8.128125190734863 C 27.27421951293945 7.797656536102295 27.80859375 7.797656536102295 28.13906288146973 8.128125190734863 L 30.12890625 10.11796855926514 C 30.45937538146973 10.44843769073486 30.45937538146973 10.98281192779541 30.12890625 11.31328105926514 L 28.06171798706055 13.38046836853027 L 28.01953125 13.42265605926514 C 29.51015663146973 15.70078086853027 30.375 18.43593788146973 30.375 21.375 Z M 18 23.90625 L 18 13.25390625 C 18 12.78984355926514 17.62031173706055 12.41015625 17.15625 12.41015625 L 14.34375 12.41015625 C 13.87968730926514 12.41015625 13.5 12.78984355926514 13.5 13.25390625 L 13.5 23.90625 C 13.5 24.37031173706055 13.87968730926514 24.75 14.34375 24.75 L 17.15625 24.75 C 17.62031173706055 24.75 18 24.37031173706055 18 23.90625 Z" fill="#95cef3" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
      allowDrawingOutsideViewBox: true,
      fit: BoxFit.fill,
    );
  }
}
