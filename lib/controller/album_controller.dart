import 'package:project/model/album.dart';
import 'package:project/model/photo.dart';
import 'package:project/model/user.dart';
import 'package:project/repositories/api.dart';

class AlbumController{
  final ApiRepositories api;

  AlbumController(this.api);
  Future<List<AlubmModel>> getAlbum(UserModel user) async{
  final List album= await api.get("https://jsonplaceholder.typicode.com/albums?userId=${user.id}");

  final List<AlubmModel> albumuser= album.map(AlubmModel.fromJsObject).toList();
 final List<List<PhotoModel>> photo=await Future.wait(albumuser.map((e) => getPhoto(e.id)).toList());
 print ("user ${albumuser.length } & photo ${photo.length}");
for(var album in albumuser)
  {
    album.photos.addAll(photo[
      albumuser.indexWhere((element) => element.id==album.id)
    ].map((e) {
      e.user = user;
      return e;
    }
    ));
  }
 return albumuser;
  
   
}
Future<List<PhotoModel>> getPhoto(int albumId ) async{
    final List user=await api.get("https://jsonplaceholder.typicode.com/photos?albumId=$albumId");
    return user.map(PhotoModel.fromJsObject).toList();
   }


}
