import 'package:flutter/cupertino.dart';
import 'package:wikipedia_example/entity/topic.dart';
import 'package:wikipedia_example/repository/injector.dart';
import 'package:wikipedia_example/repository/search_repository.dart';
import 'package:wikipedia_example/response/search_response.dart';
import 'package:wikipedia_example/ui/search/contract/search_contract.dart';

class SearchServices extends ChangeNotifier{
  SearchContract contract;
  List<SearchResponse> mSearchResponse;
  List<Topic> mTopics;

  void onSearch(String keyword){
    SearchRepository repository = Injector().getInstanceSearch;
    repository.onSearchTopic(keyword).then((value) {
      return contract.onSearchSuccess(value);
    }).catchError((onError){
      return contract.onSearchError();
    });
  }

  void onUpdatedSearchResults(List<SearchResponse> response){
    mSearchResponse = response;
    notifyListeners();
  }

  void onUpdatedTopics(List<Topic> response){
    mTopics = response;
    notifyListeners();
  }
}