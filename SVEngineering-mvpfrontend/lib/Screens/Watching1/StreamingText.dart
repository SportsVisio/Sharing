import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StreamingText extends StatelessWidget {
  const StreamingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hawks',
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 0.625,
                    shadows: [
                      Shadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  ' vs ',
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 16,
                    color: Colors.black,
                    height: 0.625,
                    shadows: [
                      Shadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Bullets',
                  style: TextStyle(
                    fontFamily: 'regu',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 0.625,
                    shadows: [
                      Shadow(
                        color: const Color(0x29000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Text(
                    'Score:',
                    style: TextStyle(
                      fontFamily: 'regu',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 0.625,
                      shadows: [
                        Shadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                  ),
                  Text(
                    '15 to 45(Bullets)',
                    style: TextStyle(
                      fontFamily: 'regu',
                      fontSize: 20,
                      height: 0.625,
                      shadows: [
                        Shadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '3rd Quarter 12:45 (X Remaining)',
                style: TextStyle(
                  fontFamily: 'regu',
                  fontSize: 20,
                  height: 0.625,
                  shadows: [
                    Shadow(
                      color: const Color(0x29000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        InkWell(
          child: Text(
            'Live Stream',
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
