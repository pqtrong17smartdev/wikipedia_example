import 'package:flutter/material.dart';

abstract class IBaseState {
  void showLoadingDialog();

  void showAlertDialog(BuildContext context,
      {String title,
      Widget content,
      Function onAcceptPress,
      bool isShowCancel,
      bool isTapOnOutBoxDismiss,
      TextStyle titleStyle,
      String labelAccept,
      String labelCancel});

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
      TextStyle cancelStyle});

  void showToast(String message,
      {double fontSize,
      Color backgroundColor,
      PositionToast position,
      Color textColor});

  void dismiss();

  void showSnackBar(
      {@required GlobalKey<ScaffoldState> key,
      String message,
      String label,
      Function onPressed,
      int seconds});
}

enum PositionToast { CENTER, TOP, BOTTOM }
