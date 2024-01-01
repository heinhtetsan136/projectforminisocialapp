import 'package:project/model/photo.dart';

class AlbumModel {
  final int userId, id;
  final String title;
  final List<PhotoModel> photos;

  AlbumModel({
    required this.id,
    required this.userId,
    required this.title,
  }) : photos = [];

  factory AlbumModel.fromJsObject(dynamic jsobject) {
    return AlbumModel(
      id: int.parse(jsobject["id"].toString()),
      userId: int.parse(jsobject["userId"].toString()),
      title: jsobject["title"],
    );
  }
  AlbumModel copy() {
    final news = AlbumModel(id: id, userId: userId, title: title);
    news.photos.addAll(photos);
    return news;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
    };
  }
}
