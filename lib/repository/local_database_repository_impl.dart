import 'package:sqflite_common/sqlite_api.dart';
import 'package:wikipedia_example/entity/topic.dart';
import 'package:wikipedia_example/repository/local_database_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class LocalDatabaseRepositoryImpl implements LocalDatabaseRepository {
  @override
  Future<List<Topic>> onGetListTopic(Database database, String table) async {
    // TODO: implement onGetListPostThread
    final List<Map<String, dynamic>> maps = await database.query(table);
    // return List.generate(maps.length, (index) => PostThread(
    //     id: maps[index]['id'],
    //     title: maps[index]['title'],
    //     description: maps[index]['description'],
    //     thumbnail: maps[index]['thumbnail'],
    //     key: maps[index]['key']
    // ));
    return maps.map((e) => Topic.fromMap(e)).toList();
  }

  @override
  Future<String> onGetPathDatabase(String databaseName) async {
    // TODO: implement onGetPathDatabase
    var databasesPath = await getDatabasesPath();
    String _path = path.join(databasesPath, '$databaseName.db');
    return _path;
  }

  @override
  Future<void> onInsertTopic(
      Database database, String table, Topic topic) async {
    // TODO: implement onInsertPostThread
    await database.insert(table, topic.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<Database> onOpenOrCreateDatabase(String path, String table) async {
    // TODO: implement onOpenOrCreateDatabase
    Database database = await openDatabase(
      path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE IF NOT EXISTS ViewedTopic (id INTEGER PRIMARY KEY, key TEXT, title TEXT, description TEXT, thumbnail TEXT)');

        await db.execute(
            'CREATE TABLE IF NOT EXISTS CacheTopic (id INTEGER PRIMARY KEY, key TEXT, title TEXT, description TEXT, thumbnail TEXT)');
      },
    );
    return database;
  }

  @override
  Future<void> onInsertAllTopics(
      Database database, String table, List<Topic> topics) async {
    // TODO: implement onInsertListTopics
    for (Topic item in topics) {
      await database.insert(table, item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
