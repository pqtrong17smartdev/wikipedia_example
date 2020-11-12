import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wikipedia_example/navigation/navigation.dart';
import 'package:wikipedia_example/values/dimens.dart';
import 'package:wikipedia_example/values/fonts.dart';
import 'package:wikipedia_example/values/images.dart';
import 'package:wikipedia_example/widgets/image_customized.dart';
import 'package:wikipedia_example/widgets/text_customized.dart';

class WebView extends StatefulWidget {
  final String url;
  final String title;

  WebView({@required this.url, this.title});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      displayZoomControls: false,
      appBar: AppBar(
        title: TextCustomized(widget.title ?? '', fontSize: d19TextSize,
          fontColor: Colors.white,
          fontFamily: fSFUIText,
          fontWeight: FontWeightEnum.SEMI_BOLD,),
        leading: InkWell(
          onTap: () => Navigation.pop(context),
          child: Container(
            padding: EdgeInsets.all(20),
            child: ImageCustomized(
              url: ic_back,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width/2,
              child: LinearProgressIndicator()),
        ),
      ),
    );
  }

  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();
}
