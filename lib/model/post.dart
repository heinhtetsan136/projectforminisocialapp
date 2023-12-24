
import 'package:project/model/comment.dart';
import 'package:project/model/user.dart';

class PostModel {
  final int userId,id;
  final String title, body;
  List<CommentModel> comments;
  late final UserModel user;

  PostModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body}):comments=[];

      factory PostModel.fromJsObject(dynamic jsobject){
        return PostModel(id: int.parse(jsobject["id"].toString()),
        userId: int.parse(jsobject["userId"].toString()),
         title: jsobject["title"],
          body: jsobject["body"],
        );
           
      }
}