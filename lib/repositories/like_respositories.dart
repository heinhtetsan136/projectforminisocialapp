import 'package:shared_preferences/shared_preferences.dart';

abstract class LikeRespositories {
  static SharedPreferences? prefences;
  static Future init() async {
    prefences ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get _pref {
    if (prefences == null) {
      throw "Please call init method";
    }
    return prefences!;
  }

  static Future<bool> action(String key) async {
    return prefences!.setBool(key, !get(key));
  }

  static bool get(String key) {
    return _pref.getBool(key) ?? false;
  }
}
