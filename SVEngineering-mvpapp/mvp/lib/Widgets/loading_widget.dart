import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 90,
        width: 90,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
        ),
      ),
    );
  }
}
