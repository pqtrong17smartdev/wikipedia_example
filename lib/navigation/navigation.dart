import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Navigation {
  static Future<void> push(BuildContext context, Widget page) async {
    var result = await Navigator.push(context,
        PageTransition(type: PageTransitionType.leftToRight, child: page));
    return result;
  }

  static void pushWithAnimation(BuildContext context, Widget page) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.leftToRight, child: page));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void popData(BuildContext context, data) {
    Navigator.pop(context, data);
  }

  static void popRoot(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushReplacementWithAnimation(BuildContext context, Widget page) {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.leftToRight, child: page));
  }

  static void pushAndRemove(BuildContext context, Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
            (Route<dynamic> route) => false);
  }
}
