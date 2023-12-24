import 'package:project/model/photo.dart';

class AlubmModel {
  final int userId, id;
  final String title;
  final List<PhotoModel> photos;


  AlubmModel({
    required this.id,
    required this.userId,
    required this.title,
  }) : photos = [];

  factory AlubmModel.fromJsObject(dynamic jsobject) {
    return AlubmModel(
      id: int.parse(jsobject["id"].toString()),
      userId: int.parse(jsobject["userId"].toString()),
      title: jsobject["title"],
    );
  }
  AlubmModel copy(){
    final news=AlubmModel(id: id, userId: userId, title: title);
    news.photos.addAll(photos);
    return news;


  }

}
