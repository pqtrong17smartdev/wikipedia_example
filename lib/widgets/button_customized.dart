import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCustomized extends StatelessWidget {
  final String text;
  final Widget icon;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Function onClick;
  final double width;
  final double height;

  ButtonCustomized(
      {
        this.text,this.icon,
      this.padding,
      this.borderRadius,
      this.textStyle,
      this.backgroundColor,
        this.width,
        this.height,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick != null ? onClick() : null,
      child: Container(
        width: width,
          height: height,
          padding: padding ?? EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: backgroundColor ?? Colors.blue,
              borderRadius: borderRadius),
          child: text != null
              ? Text(
                  text,
                  style: textStyle,
                  textAlign: TextAlign.center,
                )
              : icon),
    );
  }
}
