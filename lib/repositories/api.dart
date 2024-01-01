import 'package:dio/dio.dart';

import 'cache_respositories.dart';

class ApiRepositories {
  final CacheRepostories cacheRepostories;
  final Dio dio;

  ApiRepositories({required this.dio, required this.cacheRepostories});

  Future<List> get(final String url, String collection) async {
    try {
      final response = await dio.get(url);

      final result = response.data as List;
      // await cacheRepostories.save(
      //     collection, result.map((e) => e as Map<String, dynamic>).toList());
      return result;
    } catch (e) {
      print("error $e");
      this.cacheRepostories.get(collection);
      return [];
    }
  }
}
