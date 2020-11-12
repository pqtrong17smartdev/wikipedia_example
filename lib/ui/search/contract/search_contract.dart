import 'package:wikipedia_example/response/search_response.dart';

abstract class SearchContract {
  void onSearchSuccess(List<SearchResponse> response);
  void onSearchError();
}