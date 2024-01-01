import "package:project/repositories/api.dart";

import "../model/user.dart";

class UserController {
  final ApiRepositories api;

  UserController({
    required this.api,
  });

  Future<List<UserModel>> getUser() async {
    final List user = await api.get(
        "https://jsonplaceholder.typicode.com/users", "cahe_user");
    // print(user);
    return user.map(UserModel.fromJsObject).toList();
  }
}
