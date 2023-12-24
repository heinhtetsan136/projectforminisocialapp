
import "package:dio/dio.dart";
import "package:project/model/user.dart";
import "package:project/repositories/api.dart";
class UserController{
  final ApiRepositories api;



  UserController({required this.api,});
Future<List<UserModel>> getUser() async{
  final List user= await api.get("https://jsonplaceholder.typicode.com/users");
  // print(user);
  return user.map(UserModel.fromJsObject).toList();

}}
    

  
  