import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wikipedia_example/ui/home/views/home_page.dart';
import 'package:wikipedia_example/ui/search/services/database_local_services.dart';
import 'package:wikipedia_example/ui/search/services/search_services.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DatabaseLocalServices>(
            create: (_) => DatabaseLocalServices(),
          ),
          ChangeNotifierProvider<SearchServices>(
            create: (_) => SearchServices(),
          ),
        ],
        child: MaterialApp(
          home: HomePage(),
        ),
      )
  );
}

