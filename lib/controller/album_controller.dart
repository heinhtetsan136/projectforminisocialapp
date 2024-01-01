import 'package:project/model/album.dart';
import 'package:project/model/photo.dart';
import 'package:project/model/user.dart';
import 'package:project/repositories/api.dart';

class AlbumController {
  final ApiRepositories api;

  AlbumController(this.api);
  List<AlbumModel> match(List<AlbumModel> albumuser,
      List<List<PhotoModel>> photo, List<UserModel> user) {
    for (var album in albumuser) {
      album.photos.addAll(
          photo[albumuser.indexWhere((element) => element.id == album.id)]
              .map((e) {
        e.user = user.firstWhere((element) => element.id == album.userId);
        return e;
      }));
    }
    return albumuser;
  }

  Future<List<AlbumModel>> getAlbum(UserModel user) async {
    final List album = await api.get(
        "https://jsonplaceholder.typicode.com/albums?userId=${user.id}",
        "cache_album");

    final List<AlbumModel> albumuser =
        album.map(AlbumModel.fromJsObject).toList();
    final List<List<PhotoModel>> photo =
        await Future.wait(albumuser.map((e) => getPhoto(e.id)).toList());
    print("user ${albumuser.length} & photo ${photo.length}");
    match(albumuser, photo, [user]);
    return albumuser;
  }

  Future<List<PhotoModel>> getPhoto(int albumId) async {
    final List user = await api.get(
        "https://jsonplaceholder.typicode.com/photos?albumId=$albumId",
        "cache_photo");
    return user.map(PhotoModel.fromJsObject).toList();
  }
}
