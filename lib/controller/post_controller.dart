import 'package:dio/dio.dart';
import 'package:project/model/comment.dart';
import 'package:project/model/post.dart';
import 'package:project/repositories/api.dart';

class PostController{
 final ApiRepositories api;

  PostController(this.api);

  Future<List<PostModel>> getPost(int userId) async{
  final List user= await api.get("https://jsonplaceholder.typicode.com/posts?userId=$userId");
 List<PostModel> postsuser= user.map(PostModel.fromJsObject).toList();
 List<List<CommentModel>> comment=await Future.wait(postsuser.map((e) => getComment(e.id)).toList());
 for(var post in postsuser){
   post.comments.addAll(comment[postsuser.indexWhere((element) => element.id==post.id)]);
 }
 return postsuser;
  
   
}
Future<List<CommentModel>> getComment(int postId ) async{
    final List user=await api.get("https://jsonplaceholder.typicode.com/comments?postId=$postId");
    return user.map(CommentModel.fromJsObject).toList();
   }
}