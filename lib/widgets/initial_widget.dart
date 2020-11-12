import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wikipedia_example/values/colors.dart';
import 'package:wikipedia_example/values/dimens.dart';
import 'package:wikipedia_example/values/fonts.dart';
import 'package:wikipedia_example/values/images.dart';
import 'package:wikipedia_example/widgets/image_customized.dart';
import 'package:wikipedia_example/widgets/text_customized.dart';

enum TypeInitialWidget { NORMAL, SCROLL, EXPAND }
enum TextColorStatusBar { BLACK, WHITE }

class InitialWidget extends StatefulWidget {
  final Widget child;
  final String titleAppBar;
  final TypeInitialWidget type;
  final List<Widget> endWidgetAppBar;
  final bool isShowBack;
  final bool isCenterTitle;
  final Color backgroundColor;
  final Widget floatingActionButton;
  final Color backgroundAppBar;
  final Function onWillPop;
  final bool isEnableSafeArea;
  final Brightness statusBarIconBrightness;
  final GlobalKey<ScaffoldState> keyScaffold;
  final Widget centerWidgetAppBar;
  final Color statusBarColor;
  final double titleSpacing;
  final EdgeInsets padding;

  InitialWidget(
      {@required this.child,
      this.floatingActionButton,
      this.titleAppBar,
      this.endWidgetAppBar,
      this.isShowBack,
      this.isCenterTitle,
      this.backgroundColor,
      this.backgroundAppBar,
      this.onWillPop,
      this.isEnableSafeArea,
      this.statusBarIconBrightness,
      this.keyScaffold,
      this.centerWidgetAppBar,
      this.statusBarColor,
      this.titleSpacing,
      this.padding,
      this.type = TypeInitialWidget.NORMAL});

  InitialWidget.scroll(
      {@required this.child,
      this.floatingActionButton,
      this.titleAppBar,
      this.endWidgetAppBar,
      this.isCenterTitle,
      this.isShowBack,
      this.backgroundColor,
      this.backgroundAppBar,
      this.onWillPop,
      this.isEnableSafeArea,
      this.statusBarIconBrightness,
      this.keyScaffold,
      this.statusBarColor,
      this.centerWidgetAppBar,
      this.titleSpacing,
      this.padding,
      this.type = TypeInitialWidget.SCROLL});

  InitialWidget.expand(
      {@required this.child,
      this.floatingActionButton,
      this.titleAppBar,
      this.endWidgetAppBar,
      this.isCenterTitle,
      this.isShowBack,
      this.backgroundColor,
      this.backgroundAppBar,
      this.onWillPop,
      this.isEnableSafeArea,
      this.statusBarIconBrightness,
      this.keyScaffold,
      this.centerWidgetAppBar,
      this.statusBarColor,
      this.titleSpacing,
      this.padding,
      this.type = TypeInitialWidget.EXPAND});

  @override
  _InitialWidgetState createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  double _luminance;
  bool _isDark = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.backgroundAppBar != null) {
      _luminance = widget.backgroundAppBar.computeLuminance();
    } else if (widget.statusBarColor != null) {
      _luminance = widget.statusBarColor.computeLuminance();
    } else {
      _luminance = 0.6;
    }
    setState(() {
      if (_luminance > 0.5) {
        _isDark = false;
      } else {
        _isDark = true;
      }
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: widget.statusBarColor ?? Colors.transparent,
          statusBarIconBrightness: widget.statusBarIconBrightness !=
                  null // If no appbar, this is active.
              ? widget.statusBarIconBrightness
              : _isDark
                  ? Brightness.light
                  : Brightness.dark),
      child: Scaffold(
        key: widget.keyScaffold ?? null,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        floatingActionButton: widget.floatingActionButton,
        backgroundColor: widget.backgroundColor ?? white,
        appBar: widget.titleAppBar != null ||
                widget.centerWidgetAppBar != null ||
                (widget.isShowBack != null && widget.isShowBack)
            ? _buildAppBar()
            : null,
        body: Padding(
          padding: widget.padding ?? EdgeInsets.all(0),
          child: WillPopScope(
            onWillPop: () async {
              if (widget.onWillPop != null) {
                widget.onWillPop();
                return false;
              }
              return true;
            },
            child: SafeArea(
                top: (widget.isEnableSafeArea != null &&
                            !widget.isEnableSafeArea) ||
                        widget.statusBarColor != null
                    ? false
                    : true,
                child: Column(
                  children: [
                    Expanded(
                      child: widget.type == TypeInitialWidget.NORMAL
                          ? widget.child
                          : widget.type == TypeInitialWidget.SCROLL
                              ? SingleChildScrollView(
                                  child: Container(
                                    child: widget.child,
                                  ),
                                )
                              : LayoutBuilder(builder: (context, constraints) {
                                  return SingleChildScrollView(
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minWidth: constraints.maxWidth,
                                              minHeight: constraints.maxHeight),
                                          child: IntrinsicHeight(
                                            child: widget.child,
                                          )));
                                }),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(kToolbarHeight),
      child: AppBar(
        brightness: widget.statusBarIconBrightness != null
            ? widget.statusBarIconBrightness
            : _isDark
                ? Brightness.dark
                : Brightness.light,
        centerTitle: widget.isCenterTitle ?? true,
        backgroundColor: widget.backgroundAppBar ?? white,
        leading: widget.isShowBack != null && widget.isShowBack
            ? InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: ImageCustomized(
                    url: ic_back,
                    width: 16,
                    height: 12,
                  ),
                ),
              )
            : Container(),
        title: widget.centerWidgetAppBar ??
            FittedBox(
              child: TextCustomized(
                widget.titleAppBar ?? "",
                fontSize: d19TextSize,
                fontColor: _isDark ? white : blackText21,
                fontFamily: fSFUIText,
                fontWeight: FontWeightEnum.SEMI_BOLD,
              ),
            ),
        actions: widget.endWidgetAppBar,
        titleSpacing: widget.titleSpacing ?? 0,
      ),
    );
  }
}
