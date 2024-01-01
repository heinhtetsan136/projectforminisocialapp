import 'package:flutter/material.dart';
import 'package:project/controller/feed_controller.dart';
import 'package:project/view/screen/widget/post_card.dart';

import '../../../model/post.dart';

class SearchScreen extends SearchDelegate {
  final List<PostModel> _post = [];
  List<PostModel> get posts {
    if (_post.isEmpty) {
      _post.addAll(FeedController.users.fold([],
          (previousValue, element) => [...previousValue, ...element.posts]));
    }
    return _post;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [SizedBox()];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    print("search");
    final searchresult = posts
        .where((element) =>
            element.title.toLowerCase().startsWith(query.toLowerCase()) ||
            element.body.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    // TODO: implement buildResults
    return ListView.builder(
        itemCount: searchresult.length,
        itemBuilder: (_, i) {
          return Column(
            children: [
              PostCard(
                post: searchresult[i],
                onTap: () {
                  Navigator.of(context).pushNamed("/details",
                      arguments: FeedController.users.firstWhere(
                          (element) => element.id == searchresult[i].userId));
                },
              ),
              Divider(),
            ],
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final searchresult = posts
        .where((element) =>
            element.title.toLowerCase().startsWith(query.toLowerCase()) ||
            element.body.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    // TODO: implement buildResults
    return ListView.builder(
        itemCount: searchresult.length,
        itemBuilder: (_, i) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed("/details",
                      arguments: FeedController.users.firstWhere(
                          (element) => element.id == searchresult[i].userId));
                },
                title: Text("${searchresult[i].title}"),
              ),
              Divider(),
            ],
          );
        });
  }
}
