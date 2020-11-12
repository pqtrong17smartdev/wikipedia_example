import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wikipedia_example/entity/topic.dart';
import 'package:wikipedia_example/navigation/navigation.dart';
import 'package:wikipedia_example/repository/injector.dart';
import 'package:wikipedia_example/repository/search_repository.dart';
import 'package:wikipedia_example/response/search_response.dart';
import 'package:wikipedia_example/ui/home/contracts/database_local_contract.dart';
import 'package:wikipedia_example/ui/search/contract/search_contract.dart';
import 'package:wikipedia_example/ui/search/services/database_local_services.dart';
import 'package:wikipedia_example/ui/search/services/search_services.dart';
import 'package:wikipedia_example/values/images.dart';
import 'package:wikipedia_example/values/strings.dart';
import 'package:wikipedia_example/widgets/image_customized.dart';
import 'package:wikipedia_example/widgets/text_customized.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'detail_topic_page.dart';
import 'package:connectivity/connectivity.dart';

class SuggestionListView extends StatefulWidget {
  final String query;

  SuggestionListView({this.query});

  @override
  _SuggestionListViewState createState() => _SuggestionListViewState();
}

class _SuggestionListViewState extends State<SuggestionListView>
    implements DatabaseLocalContract, SearchContract {
  SearchRepository repository = Injector().getInstanceSearch;
  List<SearchResponse> response;
  static const String DATABASE_NAME = 'wikipedia';
  static const String VIEWED_TOPIC_TABLE = 'ViewedTopic';
  static const String CACHE_TOPIC_TABLE = 'CacheTopic';
  DatabaseLocalServices mDatabaseLocalService;
  SearchServices mSearchService;
  Topic topicRequest;
  Timer debounce;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isConnected;
  bool isInsertSingle;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(debounce != null){
      debounce.cancel();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mDatabaseLocalService = Provider.of<DatabaseLocalServices>(context, listen: false);
    mSearchService = Provider.of<SearchServices>(context, listen: false);
    mDatabaseLocalService.contract = this;
    mSearchService.contract = this;
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    if (debounce?.isActive ?? false) {
      debounce.cancel();
    }
    debounce = Timer(Duration(milliseconds: 1000), () {
      print('CALLED onSEARCH-----------------------');
      mSearchService.onSearch(widget.query);
    });
    // return FutureBuilder(
    //   future: repository.onSearchTopic(widget.query),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       print('----------------- HAS DATA!!!!!!!!!!!!!!');
    //       response = snapshot.data;
    //     }
    //     return snapshot.hasData
    //         ? ListView.builder(
    //             itemCount: response.length,
    //             itemBuilder: (context, index) =>
    //                 itemSuggestion(response[index]),
    //           )
    //         : Center(
    //             child: CircularProgressIndicator(),
    //           );
    //   },
    // );
    return Consumer<SearchServices>(
      builder: (context, model, child) => model.mSearchResponse != null
          ? ListView.builder(
              itemCount: model.mSearchResponse.length,
              itemBuilder: (context, index) => itemSuggestion(model.mSearchResponse[index]),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget itemSuggestion(SearchResponse response) {
    return InkWell(
      onTap: () async {
        setState(() {
          isInsertSingle = true;
        });
        topicRequest = Topic(
            id: response.id,
            key: response.key,
            title: response.title,
            description: response.description,
            thumbnail: response.thumbnailResponse != null ? response.thumbnailResponse.url : null);
        mDatabaseLocalService.onGetDatabasePath(DATABASE_NAME);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    child: response.thumbnailResponse != null
                        ? ImageCustomized.network(
                            url: "https:" + response.thumbnailResponse.url,
                            fit: BoxFit.fill,
                            width: 50,
                            height: 50,
                            radius: 12,
                          )
                        : ImageCustomized(
                            url: ic_no_camera,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            radius: 12,
                          ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: TextCustomized(
                            "${response.title}",
                            fontWeight: FontWeightEnum.SEMI_BOLD,
                            maxLine: 2,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Container(
                            child: TextCustomized(
                              "${response.description ?? "($no_description)"}",
                              fontColor: Colors.black38,
                              maxLine: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
            isConnected = true;
          break;
        case ConnectivityResult.mobile:
          isConnected = true;
          break;
        case ConnectivityResult.none:
          isConnected = false;
          break;
        default:
          isConnected = null;
          break;
      }
    });
  }

  @override
  void onGetPathError() {
    // TODO: implement onGetPathError
  }

  @override
  void onGetPathSuccess(String path) {
    // TODO: implement onGetPathSuccess
    print('GET PATH SUCCESS: $path --- Single: $isInsertSingle');
    if (isInsertSingle != null && isInsertSingle) {
      mDatabaseLocalService.onCreateOrLoadDatabase(path, VIEWED_TOPIC_TABLE);
    }else{
      mDatabaseLocalService.onCreateOrLoadDatabase(path, CACHE_TOPIC_TABLE);
    }
  }

  @override
  void onGetTopicError() {
    // TODO: implement onGetTopicError
  }

  @override
  void onGetTopicSuccess(List<Topic> response) {
    // TODO: implement onGetTopicSuccess
  }

  @override
  void onInsertTopicError() {
    // TODO: implement onInsertTopicError
  }

  @override
  void onInsertTopicSuccess() {
    // TODO: implement onInsertTopicSuccess
    // setState(() {
    //   isInsertSingle = false;
    // });
    isInsertSingle = false;
    Navigation.push(context, DetailTopicPage(keyword: topicRequest.key));
  }

  @override
  void onOpenOrCreateDatabaseError() {
    // TODO: implement onOpenOrCreateDatabaseError
  }

  @override
  void onOpenOrCreateDatabaseSuccess(Database database) {
    // TODO: implement onOpenOrCreateDatabaseSuccess
    print("CREATE DATABASE SUCCESS: ${database.path}");
    if(isInsertSingle != null && isInsertSingle){
      mDatabaseLocalService.onInsertTopic(database, VIEWED_TOPIC_TABLE, topicRequest);
    }else{
      mDatabaseLocalService.onInsertListTopics(database, CACHE_TOPIC_TABLE, mSearchService.mTopics);
    }
  }

  @override
  void onSearchError() {
    // TODO: implement onSearchError
  }

  @override
  void onSearchSuccess(List<SearchResponse> response) {
    // TODO: implement onSearchSuccess
    mSearchService.onUpdatedSearchResults(response);
    final List<Topic> _topics = List<Topic>();
    for(SearchResponse item in response){
      _topics.add(Topic(
        id: item.id,
        title: item.title,
        key: item.key,
        description: item.description,
        thumbnail: item.thumbnailResponse != null ? item.thumbnailResponse.url : null
      ));
    }
    mSearchService.onUpdatedTopics(_topics);
    mDatabaseLocalService.onGetDatabasePath(DATABASE_NAME);
  }

  @override
  void onInsertAllSuccess() {
    // TODO: implement onInsertAllSuccess
    print('SUCCESS INSERT ALLLLLLLLLLLLLL');
  }

  @override
  void onInsertAllError() {
    // TODO: implement onInsertAllError
    print('ERROR INSERT ALLLLLLLLLLLLLL');
  }
}
