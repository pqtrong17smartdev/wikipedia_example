import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wikipedia_example/entity/topic.dart';
import 'package:wikipedia_example/navigation/navigation.dart';
import 'package:wikipedia_example/ui/base_state.dart';
import 'package:wikipedia_example/ui/home/contracts/database_local_contract.dart';
import 'package:wikipedia_example/ui/search/services/database_local_services.dart';
import 'package:wikipedia_example/ui/search/views/detail_topic_page.dart';
import 'package:wikipedia_example/ui/search/views/search_delegate_page.dart';
import 'package:wikipedia_example/values/images.dart';
import 'package:wikipedia_example/values/strings.dart';
import 'package:wikipedia_example/widgets/image_customized.dart';
import 'package:wikipedia_example/widgets/initial_widget.dart';
import 'package:wikipedia_example/widgets/text_customized.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> implements DatabaseLocalContract {
  DatabaseLocalServices mDatabaseLocalService;
  static const String DATABASE_NAME = "wikipedia";
  static const String VIEWED_TOPIC_TABLE = 'ViewedTopic';
  static const String CACHE_TOPIC_TABLE = 'CacheTopic';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isConnected;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mDatabaseLocalService = Provider.of<DatabaseLocalServices>(context, listen: false);
    mDatabaseLocalService.contract = this;
    mDatabaseLocalService.onGetDatabasePath(DATABASE_NAME);
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget onBuild() {
    // TODO: implement onBuild
    return InitialWidget(
      backgroundAppBar: Colors.blue,
      titleAppBar: appbar_title,
      endWidgetAppBar: [
        InkWell(
          onTap: () => showSearch(
              context: context, delegate: SearchDelegatePage()),
          child: Container(
            width: kToolbarHeight,
            child: Icon(
              Icons.search_sharp,
              size: 30,
            ),
          ),
        )
      ],
      child: Consumer<DatabaseLocalServices>(
        builder: (context, model, child) {
          return model.mTopics != null
              ? ListView.builder(
                  itemCount: model.mTopics.length,
                  itemBuilder: (context, index) =>
                      itemSuggestion(mDatabaseLocalService.mTopics[index]))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextCustomized(
                        history_of_topic,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextCustomized(
                        click_to_search,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget itemSuggestion(Topic response) {
    return InkWell(
      onTap: () async {
        Navigation.push(
            context,
            DetailTopicPage(
              keyword: response.key,
            ));
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
                    child: isConnected?? false ?? response.thumbnail != null
                        ? ImageCustomized.network(
                            url: "https:" + response.thumbnail,
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

  @override
  void onGetPathError() {
    // TODO: implement onGetPathError
  }

  @override
  void onGetPathSuccess(String path) {
    // TODO: implement onGetPathSuccess
    mDatabaseLocalService.onCreateOrLoadDatabase(path, VIEWED_TOPIC_TABLE);
  }

  @override
  void onGetTopicError() {
    // TODO: implement onGetTopicError
  }

  @override
  void onGetTopicSuccess(List<Topic> response) {
    // TODO: implement onGetTopicSuccess
    mDatabaseLocalService.updatedTopics(response);
  }

  @override
  void onInsertTopicError() {
    // TODO: implement onInsertTopicError
  }

  @override
  void onInsertTopicSuccess() {
    // TODO: implement onInsertTopicSuccess
  }

  @override
  void onOpenOrCreateDatabaseError() {
    // TODO: implement onOpenOrCreateDatabaseError
  }

  @override
  void onOpenOrCreateDatabaseSuccess(Database database) {
    // TODO: implement onOpenOrCreateDatabaseSuccess
    mDatabaseLocalService.onGetTopics(database, VIEWED_TOPIC_TABLE);
  }

  @override
  void onInsertAllSuccess() {
    // TODO: implement onInsertAllSuccess
  }

  @override
  void onInsertAllError() {
    // TODO: implement onInsertAllcError
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
          print("DEFAULT ?????????????????????????????????????");
          isConnected = null;
          break;
      }
    });
  }
}
