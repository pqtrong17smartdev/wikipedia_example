import 'package:flutter/material.dart';
import 'package:wikipedia_example/navigation/navigation.dart';
import 'package:wikipedia_example/repository/injector.dart';
import 'package:wikipedia_example/repository/search_repository.dart';
import 'package:wikipedia_example/response/search_response.dart';
import 'package:wikipedia_example/ui/search/views/suggesstion_list_view.dart';
import 'package:wikipedia_example/values/images.dart';
import 'package:wikipedia_example/values/strings.dart';
import 'package:wikipedia_example/widgets/image_customized.dart';
import 'package:wikipedia_example/widgets/text_customized.dart';

class SearchDelegatePage extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => search_text;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return InkWell(
      onTap: () {
        Navigation.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ImageCustomized(
          url: ic_back,
          color: Colors.black38,
        ),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListView.builder(
      itemBuilder: (context, index) => Container(
        child: TextCustomized("$index"),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return query != ""
        ? SuggestionListView(
            query: query,
          )
        : Center(
            child: TextCustomized(
              enter_to_search,
              fontSize: 20,
            ),
          );
  }
}
