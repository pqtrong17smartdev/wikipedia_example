import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wikipedia_example/ui/i_base_state.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    implements IBaseState {
  Widget onBuild();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('Run on build method!!!');
    return this.onBuild();
  }

  @override
  void dismiss() {
    // TODO: implement dismissDialog
    Navigator.pop(context);
  }

  @override
  void showAlertDialog(BuildContext context,
      {String title,
      Widget content,
      Function onAcceptPress,
      bool isShowCancel,
      bool isTapOnOutBoxDismiss,
      TextStyle titleStyle,
      String labelAccept,
      String labelCancel}) {
    showDialog(
        barrierDismissible: isTapOnOutBoxDismiss ?? false,
        context: context,
        builder: (context) => AlertDialog(
              title: Container(
                child: Text(
                  title ?? 'This is a title dialog',
                  style: titleStyle,
                ),
              ),
              content: content ?? null,
              actions: <Widget>[
                FlatButton(
                  child: Text(labelAccept ?? "Accept"),
                  onPressed: () {
                    if (onAcceptPress != null) {
                      onAcceptPress();
                    } else {
                      print('Do nothing!');
                      Navigator.pop(context);
                    }
                  },
                ),
                isShowCancel != null
                    ? FlatButton(
                        child: Text(labelCancel ?? "Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : Container()
              ],
            ));
  }

  @override
  Future<T> showDialogCustomized<T>(BuildContext context,
      {Widget header,
      String title,
      Widget content,
      Function onAcceptPress,
      bool isShowCancel,
      bool isTapOnOutBoxDismiss,
      bool isBlurBackground,
      double width,
      double height,
      EdgeInsetsGeometry padding,
      TextStyle titleStyle,
      TextStyle acceptStyle,
      TextStyle cancelStyle}) {
    return showDialog(
        barrierDismissible: isTapOnOutBoxDismiss ?? false,
        context: context,
        builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: isBlurBackground != null && isBlurBackground ? 10 : 0,
                  sigmaY:
                      isBlurBackground != null && isBlurBackground ? 10 : 0),
              child: Dialog(
                child: Container(
                  height: height ?? null,
                  width: width ?? double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      header != null
                          ? header
                          : title != null
                              ? Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(4)),
                                    color: Colors.blue,
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    title,
                                    style: titleStyle,
                                  ),
                                )
                              : Container(),
                      Flexible(
                        child: SingleChildScrollView(
                            child: Container(
                                padding: padding,
                                child: content ?? Container())),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          onAcceptPress != null
                              ? FlatButton(
                                  child: Text(
                                    "Accept",
                                    style: acceptStyle,
                                  ),
                                  onPressed: () {
                                    if (onAcceptPress != null) {
                                      onAcceptPress();
                                    } else {
                                      print('Do nothing!');
                                      Navigator.pop(context);
                                    }
                                  },
                                )
                              : Container(),
                          isShowCancel != null
                              ? FlatButton(
                                  child: Text(
                                    "Cancel",
                                    style: cancelStyle,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              : Container()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  void showLoadingDialog() {
    // TODO: implement showLoadingDialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  void showSnackBar(
      {GlobalKey<ScaffoldState> key,
      String message,
      String label,
      Function onPressed,
      int seconds}) {
    // TODO: implement showSnackBar
    key.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void showToast(String message,
      {double fontSize,
      Color backgroundColor,
      PositionToast position,
      Color textColor}) {
    // TODO: implement showToast
    var gravity;
    switch (position) {
      case PositionToast.CENTER:
        gravity = ToastGravity.CENTER;
        break;
      case PositionToast.TOP:
        // TODO: Handle this case.
        gravity = ToastGravity.TOP;
        break;
      case PositionToast.BOTTOM:
        // TODO: Handle this case.
        gravity = ToastGravity.BOTTOM;
        break;
    }
    Fluttertoast.showToast(
        msg: message,
        fontSize: fontSize,
        backgroundColor: backgroundColor,
        textColor: textColor,
        gravity: gravity);
  }
}
