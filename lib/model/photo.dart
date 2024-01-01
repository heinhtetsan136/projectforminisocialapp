import 'package:project/model/user.dart';

class PhotoModel {
  final int albumId, id;
  final String title, url, thumbnailUrl;
 late UserModel user;

  PhotoModel(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});
  factory PhotoModel.fromJsObject(dynamic jsobject) {

    return PhotoModel(
        albumId: int.parse(jsobject["albumId"].toString()),
        id: int.parse(jsobject["id"].toString()),
        title: jsobject["title"],
        url: jsobject["url"],
        thumbnailUrl: jsobject["thumbnailUrl"]);
  }
  Map<String,dynamic> toMap(){
    return {
      "albumId":albumId,
      "id":id,
      "title":title,
      "url":url,
      "thumbnailUrl":thumbnailUrl,
    };
  }
}
