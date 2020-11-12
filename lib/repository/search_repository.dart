import 'package:wikipedia_example/response/search_response.dart';

abstract class SearchRepository {
  Future<List<SearchResponse>> onSearchTopic(String keyword);
}