import 'package:project/controller/album_controller.dart';
import 'package:project/controller/post_controller.dart';
import 'package:project/controller/user_controller.dart';
import 'package:project/model/album.dart';
import 'package:project/model/post.dart';
import 'package:project/model/user.dart';

class FeedController{
  final UserController userController;
  final PostController postController;
  final AlbumController albumController;

  FeedController({required this.userController, required this.postController, required this.albumController});

  static List<UserModel> users=[];
  Future<List<UserModel>> getUser() async{
    final List<UserModel> usersmodel=await userController.getUser();
   
   final List<Future<List<PostModel>>> posts= usersmodel.map((e) => getPost(e.id)).toList();
   final List<Future<List<AlubmModel>>> albums= usersmodel.map((e) => getAlbum(e)).toList();
   
   final List<List<PostModel>>postuser= await Future.wait(posts);
  final List<List<AlubmModel>> albumuser= await Future.wait(albums);


  for(int i=0;i< usersmodel.length;i++){
    final usermodel=usersmodel[i];
    final post=postuser[i];

    usermodel.posts.addAll(post.map((e) {
      e.user=usermodel;
      return e;

    }));
    usermodel.album.addAll(albumuser[i]);
  }
  FeedController.users.clear();
  FeedController.users.addAll(usersmodel);
  return usersmodel;

  }
  Future<List<PostModel>> getPost(int userId) async{
   return postController.getPost(userId);

  }

  Future<List<AlubmModel>> getAlbum(UserModel userId) async{
    return albumController.getAlbum(userId);

  }

  
}

