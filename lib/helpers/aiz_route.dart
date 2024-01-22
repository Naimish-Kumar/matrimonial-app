import 'package:active_matrimonial_flutter_app/middleware/middleware.dart';
import 'package:flutter/material.dart';

class AIZRoute {
  static Future<T?> push<T extends Object?>(BuildContext context, Widget route,
      {Middleware<bool, T>? middleware}) {
    if (middleware != null) {
      if (!middleware.next()) {
        return Future(() => null);
      }
    }
    print("middleware#${middleware != null}");
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => route));
  }
/*
  static Future<T?> slideLeft<T extends Object?>(
      BuildContext context, Widget route) {

    if ( _isMailVerifiedRoute(route)) {
      return Navigator.push(
          context,_leftTransition<T>(otpRoute));
    }

    return Navigator.push(context, _leftTransition<T>(route));
  }

  static Future<T?> slideRight<T extends Object?>(
      BuildContext context, Widget route) {
    if ( _isMailVerifiedRoute(route)) {
      return Navigator.push(
          context,_rightTransition<T>(otpRoute));
    }
    return Navigator.push(context, _rightTransition<T>(route));
  }

  static Route<T> _leftTransition<T extends Object?>(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<T> _rightTransition<T extends Object?>(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  */
}
