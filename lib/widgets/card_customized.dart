import 'package:flutter/material.dart';

class CardCustomized extends StatelessWidget {
  final double borderRadius;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;

  CardCustomized(
      {this.borderRadius,
      this.elevation,
      this.margin,
      this.padding,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: elevation,
      child: Container(
        margin: margin,
        padding: padding,
        child: child,
      ),
    );
  }
}
