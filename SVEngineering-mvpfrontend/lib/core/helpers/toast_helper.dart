import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToastHelper {
  showToast(BuildContext context,String error) {
    showFlash(
      context: context,
      persistent: true,
      builder: (_, controller) {
        return Flash(
          controller: controller,
          margin: const EdgeInsets.all(16),
          behavior: FlashBehavior.fixed,
          position: FlashPosition.bottom,
          borderRadius: BorderRadius.circular(8.0),
          onTap: () => controller.dismiss(),
          forwardAnimationCurve: Curves.easeInCirc,
          reverseAnimationCurve: Curves.bounceIn,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.black),
            child: FlashBar(
              content: Text(error),
              indicatorColor: Colors.red,
              icon: Icon(Icons.info_outline),
              primaryAction: TextButton(
                onPressed: () => controller.dismiss(),
                child: Text('DISMISS'),

              
              ),
            ),
          ),
        );
      },
    );
  }
}
