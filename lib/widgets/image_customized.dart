import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wikipedia_example/values/dimens.dart';
import 'package:wikipedia_example/values/fonts.dart';
import 'package:wikipedia_example/widgets/text_customized.dart';

class ImageCustomized extends StatelessWidget {
  final int type;
  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final Color color;
  final double radius;
  final Color backgroundColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final String package;
  final File file;

  ImageCustomized(
      {@required this.url,
      this.width,
      this.height,
      this.fit,
      this.color,
      this.backgroundColor,
      this.margin,
      this.padding,
      this.package,
      this.radius})
      : type = 1,
        file = null;

  ImageCustomized.network(
      {@required this.url,
      this.width,
      this.height,
      this.fit,
      this.color,
      this.backgroundColor,
      this.margin,
      this.padding,
      this.package,
      this.radius})
      : type = 2,
        file = null;

  ImageCustomized.file(
      {this.width,
      this.height,
      this.fit,
      this.color,
      this.backgroundColor,
      this.margin,
      this.padding,
      this.package,
      this.radius,
      @required this.file})
      : type = 3,
        url = null;

  @override
  Widget build(BuildContext context) {
    return type == 2
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 0),
                color: backgroundColor ?? Colors.transparent),
            margin: margin ?? EdgeInsets.all(0),
            padding: padding ?? EdgeInsets.all(0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 0),
                child: _buildImageNetwork(context, url, width, height, fit)),
          )
        : type == 1
            ? ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 0),
                child: Image.asset(
                  url,
                  width: width ?? double.infinity,
                  height: height,
                  fit: fit,
                  color: color,
                  package: package ?? null,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 0),
                child: Image.file(
                  file,
                  width: width ?? double.infinity,
                  height: height,
                  fit: fit,
                  color: color,
                ),
              );
  }

  Widget _buildImageNetwork(BuildContext context, String url, double width,
      double height, BoxFit fit) {
    return Container(
      child: FutureBuilder(
        future: cacheImage(url, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.hasError) {
            return Center(
              child: TextCustomized('Link of image is dead!',
                  fontColor: Colors.white,
                  fontSize: d16TextSize,
                  fontFamily: fSFUIText,
                  fontWeight: FontWeightEnum.MEDIUM),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == false) {
            return Center(
              child: TextCustomized('Link of image is dead!',
                  fontColor: Colors.white,
                  fontSize: d16TextSize,
                  fontFamily: fSFUIText,
                  fontWeight: FontWeightEnum.MEDIUM),
            );
          }
          return Image.network(
            url,
            width: width,
            height: height,
            fit: fit,
            color: color,
          );
        },
      ),
    );
  }

  Future<bool> cacheImage(String url, BuildContext context) async {
    bool hasNoError = true;
    var output = Completer<bool>();
    precacheImage(
      NetworkImage(url),
      context,
      onError: (e, stackTrace) => hasNoError = false,
    ).then((_) => output.complete(hasNoError));
    return output.future;
  }
}
