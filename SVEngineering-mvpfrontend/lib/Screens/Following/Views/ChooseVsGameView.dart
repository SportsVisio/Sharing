import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:mvp/Screens/Following/FollowingViewModel.dart';
import 'package:mvp/core/helpers/ui_helpers.dart';
import 'package:provider/provider.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ChooseVsGameView extends StatefulWidget {
  const ChooseVsGameView({Key? key}) : super(key: key);

  @override
  _ChooseVsGameViewState createState() => _ChooseVsGameViewState();
}

class _ChooseVsGameViewState extends State<ChooseVsGameView> {
  SuperTooltip? tooltip;

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2021, 09, 12): [
        new Event(
          date: new DateTime(2021, 09, 12),
          title: 'Event 1',
          icon: Text(DateTime(2021, 09, 12).day.toString()),
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.transparent,
            height: 0,
            width: 0,
          ),
        ),
      ],
    },
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<FollowingViewModel>(
        builder: (context, followingViewModel, child) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIHelper.verticalSpaceSm,
            imagesHeader(size, followingViewModel),
            UIHelper.verticalSpaceSm,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Calibri',
                        fontSize: 18.0,
                        color: const Color(0xFF565656),
                      ),
                      children: [
                        TextSpan(
                          text: 'Text Space\n',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'We can give instructions, show graphics, etc in this space.',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: const Color(0xFFA1A1A1),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Column(
                    children: [
                      myCustomCalender(size),
                      UIHelper.verticalSpaceSm,
                      myCustomCalender(size),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Container myCustomCalender(Size size) {
    return Container(
      width: size.width * 0.6,
      child: Container(
        height: size.width * 0.65,
        color: Colors.grey[100],
        margin: EdgeInsets.symmetric(horizontal: 0.0),
        child: CalendarCarousel<Event>(
          onDayPressed: (DateTime date, List<Event> events) {},
          weekdayTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          headerTextStyle: TextStyle(color: Colors.black),
          // weekDayPadding: EdgeInsets.zero,
          headerMargin: EdgeInsets.zero,

          weekendTextStyle: TextStyle(color: Colors.black),
          thisMonthDayBorderColor: Colors.transparent,
          customGridViewPhysics: NeverScrollableScrollPhysics(),

//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
          customDayBuilder: (
            /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime? day1,
          ) {
            textStyle = TextStyle(color: Colors.red);

            /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
            /// This way you can build custom containers for specific days only, leaving rest as default.
            ///
            ///
            // _markedDateMap.events.map((key, value) {
            //   value.map((e) {
            //     print(e.date.day.toString() +
            //         ">>>>" +
            //         value.length.toString());
            //   }).toList();
            //   return MapEntry(key, value);
            // });
            if (day1!.day == 12) {
              String myday = day1.day.toString();
              return Center(
                // child: GestureDetector(
                //   onTap: (){},
                //   child: Text(
                //     day.day.toString(),
                //     style: TextStyle(color: Colors.red),
                //   ),
                // ),
                child: JustTheTooltip(
                  showWhenUnlinked: true,
                  isModal: true,
                  backgroundColor: Colors.red,
                  curve: Curves.bounceOut,
                  hoverShowDuration: Duration(seconds: 5),
                  child: Material(
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          day1.day.toString(),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  content: InkWell(
                    onTap: () {
                      Provider.of<FollowingViewModel>(context, listen: false)
                          .changeWidget(key: "selectgamefromcalender");
                    },
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Calibri',
                              fontSize: 16.0,
                              color: const Color(0xFF484848),
                            ),
                            children: [
                              TextSpan(
                                text: 'Cougars ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: 'vs',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextSpan(
                                text: ' Bulls ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: '@',
                                style: TextStyle(
                                  color: const Color(0xFFDA0202),
                                ),
                              ),
                              TextSpan(
                                text: ' 4pm\n',
                              ),
                              TextSpan(
                                text: 'Click to Select',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: const Color(0xFF00A2FF),
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return null;
            }
            // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
          },

          weekFormat: false,

          markedDatesMap: _markedDateMap,
          selectedDateTime: DateTime.now(),
          markedDateCustomTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.blue,
          ),
          markedDateCustomShapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(width: 1, color: Colors.red)),

          // markedDateIconMaxShown: 2,

          /// null for not rendering any border, true for circular border, false for rectangular border
        ),
      ),
    );
  }

  Padding imagesHeader(Size size, FollowingViewModel followingViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                  child: // Group: Group 13

                      Stack(
                children: <Widget>[
// Group: Group 9
                  Container(
                    height: 105.0,
                    width: size.width * 0.5 - 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/jhon.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.red,
                      border: Border.all(
                        width: 3.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 16.0,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        children: [
                          TextSpan(
                            text: 'John T.',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 28.0,
                    child: Text(
                      'Player:',
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 10.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: Offset(0, 3.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              Expanded(
                  child: // Group: Group 13

                      Stack(
                children: <Widget>[
// Group: Group 9
                  Container(
                    height: 105.0,
                    width: size.width * 0.5 - 1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            followingViewModel.selectedTeamModel!.image),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        width: 3.0,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'regu',
                          fontSize: 16.0,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 3.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        children: [
                          TextSpan(
                            text: followingViewModel.selectedTeamModel!.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.0,
                    bottom: 28.0,
                    child: Text(
                      followingViewModel.selectedTeamModel!.type,
                      style: TextStyle(
                        fontFamily: 'regu',
                        fontSize: 10.0,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: Offset(0, 3.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 5),
              alignment: Alignment.center,
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                border: Border.all(
                  width: 3.0,
                  color: Colors.white,
                ),
              ),
              child: Center(
                child: Text(
                  'VS',
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 18.0,
                    color: const Color(0xFFDB0303),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
