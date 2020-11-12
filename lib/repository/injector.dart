import 'dart:core';

import 'package:wikipedia_example/repository/local_database_repository.dart';
import 'package:wikipedia_example/repository/local_database_repository_impl.dart';
import 'package:wikipedia_example/repository/search_repository.dart';
import 'package:wikipedia_example/repository/search_repository_impl.dart';

class Injector {
  static final Injector singleton = new Injector._internal();

  factory Injector() {
    return singleton;
  }

  Injector._internal();

  SearchRepository get getInstanceSearch => SearchRepositoryImpl();

  LocalDatabaseRepository get getInstanceLocalDatabase => LocalDatabaseRepositoryImpl();
}
