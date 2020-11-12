import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class NetworkConfig{
  static const String URL_SERVER = "https://en.wikipedia.org/w/rest.php/v1/search/page";

  static Future<Map<String, String>> buildHeaderApi() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String accessToken = preferences.getString('accessToken');
    Map<String, String> _header = {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
      HttpHeaders.authorizationHeader: "Bearer $accessToken"
    };
    return _header;
  }

}