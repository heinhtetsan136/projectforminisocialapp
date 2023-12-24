import 'package:dio/dio.dart';
import 'package:project/model/user.dart';

class ApiRepositories{
  final Dio dio;
  

  ApiRepositories({required this.dio});
  Future<List> get(final String url) async{
    try {
      
     final response=await dio.get(url);
      print(response);
    return response.data as List;
      
    } catch (e) {
      return [];
      
    }
  }

  
  
}