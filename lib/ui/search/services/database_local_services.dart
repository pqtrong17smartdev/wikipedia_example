import 'package:flutter/material.dart';
import 'package:wikipedia_example/entity/topic.dart';
import 'package:wikipedia_example/repository/injector.dart';
import 'package:wikipedia_example/repository/local_database_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wikipedia_example/ui/home/contracts/database_local_contract.dart';

class DatabaseLocalServices extends ChangeNotifier {
  DatabaseLocalContract contract;
  Database mDatabase;
  List<Topic> mTopics;

  void updatedTopics(List<Topic> topics) {
    mTopics = topics;
    notifyListeners();
  }

  void updatedDatabase(Database database) {
    mDatabase = database;
    notifyListeners();
  }

  void onGetDatabasePath(String databaseName) async {
    LocalDatabaseRepository repository = Injector().getInstanceLocalDatabase;
    repository.onGetPathDatabase(databaseName).then((value) {
      return contract.onGetPathSuccess(value);
    }).catchError((onError) {
      return contract.onGetPathError();
    });
  }

  void onCreateOrLoadDatabase(String path, String table) async {
    LocalDatabaseRepository repository = Injector().getInstanceLocalDatabase;
    repository.onOpenOrCreateDatabase(path, table).then((value) {
      return contract.onOpenOrCreateDatabaseSuccess(value);
    }).catchError((onError) {
      return contract.onOpenOrCreateDatabaseError();
    });
  }

  void onInsertTopic(Database database, String table, Topic topic) async {
    LocalDatabaseRepository repository = Injector().getInstanceLocalDatabase;
    repository.onInsertTopic(database, table, topic).then((value) {
      return contract.onInsertTopicSuccess();
    }).catchError((onError) {
      return contract.onInsertTopicError();
    });
  }

  void onInsertListTopics(Database database,String table, List<Topic> topic) async {
    LocalDatabaseRepository repository = Injector().getInstanceLocalDatabase;
    repository.onInsertAllTopics(database, table, topic).then((value) {
      return contract.onInsertTopicSuccess();
    }).catchError((onError) {
      return contract.onInsertTopicError();
    });
  }

  void onGetTopics(Database database, String table) async {
    LocalDatabaseRepository repository = Injector().getInstanceLocalDatabase;
    repository.onGetListTopic(database, table).then((value) {
      return contract.onGetTopicSuccess(value);
    }).catchError((onError) {
      return contract.onGetTopicError();
    });
  }
}
