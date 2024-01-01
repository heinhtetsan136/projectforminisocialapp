import 'package:project/model/album.dart';
import 'package:project/model/comment.dart';
import 'package:project/model/post.dart';

class UserModel {
  final int id;
  final String name, username, email;
  List<PostModel> posts;
  List<CommentModel> comments;
  List<AlbumModel> album;
  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email})
      : posts = [],
        comments = [],
        album = [];

  factory UserModel.fromJsObject(dynamic jsobject) {
    return UserModel(
        id: int.parse(jsobject["id"].toString()),
        name: jsobject["name"],
        username: jsobject["username"],
        email: jsobject["email"]);
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
    };
  }
}
