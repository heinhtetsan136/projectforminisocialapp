import 'package:project/controller/album_controller.dart';
import 'package:project/controller/post_controller.dart';
import 'package:project/controller/user_controller.dart';
import 'package:project/model/album.dart';
import 'package:project/model/comment.dart';
import 'package:project/model/photo.dart';
import 'package:project/model/post.dart';
import 'package:project/model/user.dart';

import '../repositories/cache_respositories.dart';

class Load {
  bool isnewdata;
  final List<UserModel> user;
  final List<List<PostModel>> post;
  final List<List<AlbumModel>> album;

  Load(this.user, this.post, this.album, this.isnewdata);
}

class FeedController {
  final CacheRepostories cacheRepostories;
  final UserController userController;
  final PostController postController;
  final AlbumController albumController;

  void match(List<UserModel> usersmodel, List<List<PostModel>> postuser,
      List<List<AlbumModel>> albumuser) {
    for (int i = 0; i < usersmodel.length; i++) {
      final usermodel = usersmodel[i];
      final post = postuser[i];

      usermodel.posts.addAll(post.map((e) {
        e.user = usermodel;
        return e;
      }));
      usermodel.album.addAll(albumuser[i]);
    }
    FeedController.users.clear();
    FeedController.users.addAll(usersmodel);
    print(" $usersmodel");
    print("${FeedController.users}");
  }

  FeedController(
      {required this.userController,
      required this.postController,
      required this.albumController,
      required this.cacheRepostories});
  Future<List> loadfromcachewithfold(
      List parent, String collection, Function(dynamic) parser) async {
    final result = await loadfromcache(parent, collection, parser);

    return result.fold<List>(
        [], (previousValue, element) => [...previousValue, ...element]);
  }

  Future<List> get(String collection, Function(dynamic) parser) async {
    final result = await cacheRepostories.get(collection);
    return result.map(parser).toList();
  }

  Future<List<List>> loadfromcache(
      List parents, String collection, Function(dynamic) parser) async {
    final future = parents.map((e) => get("${collection}${e.id}", parser));
    final result = await Future.wait(future);
    return result;
  }

  Future<Load> loaddata() async {
    final List<UserModel> usersmodel = await userController.getUser();

    if (usersmodel.isEmpty) {
      final List<UserModel> cachemodel =
          (await cacheRepostories.get("cache_user"))
              .map(UserModel.fromJsObject)
              .toList();
      final List<PostModel> cachepost = (await loadfromcachewithfold(
              cachemodel, "cache_post_", PostModel.fromJsObject))
          .map((e) {
        e as PostModel;

        return e;
      }).toList();

      final List<List<CommentModel>> cachecomment = (await loadfromcache(
              cachepost, "cache_comment_", CommentModel.fromJsObject))
          .map((e) => e.map((e) => e as CommentModel).toList())
          .toList();

      final List<PostModel> matchpost =
          this.postController.match(cachepost, cachecomment);

      final List<AlbumModel> cachealbum = (await loadfromcachewithfold(
              cachemodel, "cache_album_", AlbumModel.fromJsObject))
          .map((e) {
        e as AlbumModel;

        return e;
      }).toList();
      final List<List<PhotoModel>> cachephoto = (await loadfromcache(
              cachealbum, "cache_photo_", PhotoModel.fromJsObject))
          .map((e) => e.map((e) => e as PhotoModel).toList())
          .toList();
      final List<AlbumModel> matchalbum =
          this.albumController.match(cachealbum, cachephoto, cachemodel);
      final List<List<PostModel>> userpost = [];
      final List<List<AlbumModel>> useralbum = [];

      for (var user in cachemodel) {
        userpost.add(
            matchpost.where((element) => element.userId == user.id).toList());
        useralbum.add(
            matchalbum.where((element) => element.userId == user.id).toList());
      }

      return Load(cachemodel, userpost, useralbum, false);
    }

    final List<Future<List<PostModel>>> posts =
        usersmodel.map((e) => getPost(e.id)).toList();
    final List<Future<List<AlbumModel>>> albums =
        usersmodel.map((e) => getAlbum(e)).toList();

    final List<List<PostModel>> postuser = await Future.wait(posts);
    final List<List<AlbumModel>> albumuser = await Future.wait(albums);
    // match(usersmodel, postuser, albumuser);

    return Load(usersmodel, postuser, albumuser, true);
  }

  static List<UserModel> users = [];
  Future<List<UserModel>> getUser() async {
    final model = await loaddata();
    match(model.user, model.post, model.album);
    if (model.isnewdata) cacheRepostories.save(users);
    return users;
  }

  Future<List<PostModel>> getPost(int userId) async {
    return postController.getPost(userId);
  }

  Future<List<AlbumModel>> getAlbum(UserModel userId) async {
    return albumController.getAlbum(userId);
  }
}
