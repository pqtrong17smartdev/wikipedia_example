import 'package:flutter/material.dart';
import 'package:wikipedia_example/values/strings.dart';
import 'package:wikipedia_example/widgets/initial_widget.dart';
import 'package:wikipedia_example/widgets/web_view.dart';

class DetailTopicPage extends StatefulWidget {
  final String keyword;


  DetailTopicPage({this.keyword});

  @override
  _DetailTopicPageState createState() => _DetailTopicPageState();
}

class _DetailTopicPageState extends State<DetailTopicPage> {
  @override
  Widget build(BuildContext context) {
    return WebView(
        title: detail_result,
        url: "https://en.m.wikipedia.org/wiki/${widget.keyword}");
  }
}
