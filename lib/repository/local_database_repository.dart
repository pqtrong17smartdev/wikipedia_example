import 'package:sqflite/sqflite.dart';
import 'package:wikipedia_example/entity/topic.dart';

abstract class LocalDatabaseRepository {
  Future<List<Topic>> onGetListTopic(Database database, String table);

  Future<void> onInsertTopic(Database database, String table, Topic topic);

  Future<void> onInsertAllTopics(Database database, String table,List<Topic> topics);

  Future<String> onGetPathDatabase(String databaseName);

  Future<Database> onOpenOrCreateDatabase(String path, String table);
}
