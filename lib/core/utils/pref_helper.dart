import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const _tokenkey = "auth_token";

  static Future<void> savetoken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenkey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenkey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenkey);
  }
}
