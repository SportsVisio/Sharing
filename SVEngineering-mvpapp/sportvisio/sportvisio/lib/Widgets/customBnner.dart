import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:sportvisio/Controller/Constants.dart';
import 'package:sportvisio/core/helpers/navigation_helper.dart';

class customBnner extends StatelessWidget {
  const customBnner({
    Key? key,
    required NavigationHelper navigationService,
  })  : _navigationService = navigationService,
        super(key: key);

  final NavigationHelper _navigationService;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 0,
        top: 0,
        child: Container(
          transform: Matrix4.translationValues(0, 0, 0),
          child: GestureDetector(
            onTap: () {
              _navigationService.pop();
            },
            child: ShapeOfView(
              shape: TriangleShape(
                  percentBottom: 1, percentLeft: 0, percentRight: 0),
              child: Container(
                width: 70,
                height: 70,
                color: Constants.bannerColor,
              ),
            ),
          ),
        ));
  }
}
