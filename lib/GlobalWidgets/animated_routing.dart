import 'package:flutter/material.dart';

enum RouteType { RIGHT_TO_LEFT, BOTTOM_TO_TOP, LEFT_TO_RIGHT, TOP_TO_BOTTOM }

Route animatedRoute(
    Widget nextScreen, RouteType type, Duration? transitionDuration) {
  return PageRouteBuilder(
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin;
      switch (type) {
        case RouteType.RIGHT_TO_LEFT:
          begin = Offset(1.0, 0.0);
          break;
        case RouteType.BOTTOM_TO_TOP:
          begin = Offset(0.0, 1.0);
          break;
        case RouteType.LEFT_TO_RIGHT:
          begin = Offset(-1.0, 0.0);
          break;
        case RouteType.TOP_TO_BOTTOM:
          begin = Offset(0.0, -1.0);
          break;
      }
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(
        curve: curve,
      ));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
