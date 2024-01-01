import 'package:localstore/localstore.dart';

import '../model/user.dart';

class CacheRepostories {
  final Localstore localstore;

  CacheRepostories(this.localstore);

  // Future<List<dynamic>> save(
  //     String collection, List<Map<String, dynamic>> data) async {
  //   final ref = localstore.collection(collection);
  //
  //   return Future.wait(
  //       data.map((each) => ref.doc(each["id"]?.toString()).set(each)));

  // }
  Future<void> save(List<UserModel> user) {
    print("save");
    final userref = localstore.collection("cache_user");

    return Future(() {
      for (var users in user) {
        final postref = localstore.collection("cache_post_${users.id}");

        final albumref = localstore.collection("cache_album_${users.id}");

        userref.doc(users.id.toString()).set(users.toMap());
        for (var post in users.posts) {
          final commentref = localstore.collection("cache_comment_${post.id}");
          postref.doc(post.id.toString()).set(post.toMap());
          for (var comment in post.comments) {
            commentref.doc(comment.postId.toString()).set(comment.toMap());
          }
        }
        ;
        for (var album in users.album) {
          albumref.doc(album.id.toString()).set(album.toMap());
          final photoref = localstore.collection("cache_photo_${album.id}");
          for (var photo in album.photos) {
            photoref.doc(photo.id.toString()).set(photo.toMap());
          }
        }
      }
    });
    // });
  }

  Future<List> get(String collection) async {
    final result = await localstore.collection(collection).get();
    return result?.values.toList() ?? [];
  }
}
