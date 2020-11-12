import 'package:wikipedia_example/entity/topic.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseLocalContract {
  void onGetTopicSuccess(List<Topic> response);

  void onGetTopicError();

  void onInsertTopicSuccess();

  void onInsertTopicError();

  void onInsertAllSuccess();

  void onInsertAllError();

  void onGetPathSuccess(String path);

  void onGetPathError();

  void onOpenOrCreateDatabaseSuccess(Database database);

  void onOpenOrCreateDatabaseError();
}
