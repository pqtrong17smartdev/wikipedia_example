import 'dart:convert';

import 'package:wikipedia_example/network/network_config.dart';
import 'package:wikipedia_example/repository/search_repository.dart';
import 'package:http/http.dart' as http;
import 'package:wikipedia_example/response/search_response.dart';

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<List<SearchResponse>> onSearchTopic(String keyword) async {
    // TODO: implement onSearch
    print('CALL API with keyword is: $keyword');
    final responseJson =
        await http.get(NetworkConfig.URL_SERVER + "?q=$keyword&limit=10");
    final Map<String, dynamic> map = json.decode(responseJson.body);
    if (responseJson.statusCode == 200) {
      return (map['pages'] as List)
          .map((e) => SearchResponse.fromJson(e))
          .toList();
    }
    return null;
  }
}
