import 'package:flutter/material.dart';
import 'package:project/controller/feed_controller.dart';

import '../../../model/post.dart';

class SearchScreen extends SearchDelegate{
  // final List<PostModel> _post=[];
  // List<PostModel> get posts{
  //   if(_post.isEmpty){
  //     return _post.addAll(FeedController.)
  //   }
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
   return [SizedBox()];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      Navigator.of(context).pop();
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return SizedBox();
  }
  
}