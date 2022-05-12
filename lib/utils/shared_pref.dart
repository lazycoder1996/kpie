import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static String userToken = "token";
  static Future<SharedPreferences> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> saveToken(String token) async {
    init().then((prefs) async {
      await prefs.setString(userToken, token);
    });
  }

  static getToken() {
    init().then((prefs) {
      return prefs.getString(userToken);
    });
  }
}
