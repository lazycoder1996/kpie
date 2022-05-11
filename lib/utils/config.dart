import 'dart:convert';

import 'package:http/http.dart' as http;

class Config {
  static String baseUrl = "https://raktapp.sharpali.com";
  static String serverKey = "0e2603d8db46b8f6c1fdf0988436e815";
  static String accessToken = "hellodjdj";
  static Map<String, String> loginDetails = {
    "username": "james",
    "password": "12345678",
    "server_key": serverKey,
  };
}

class ApiConfig {
  static String loginUrl = Config.baseUrl + "/api/auth";
  static Future<bool> login() async {
    Uri url = Uri.parse(loginUrl);
    var req = http.Request('POST', url);
    req.body = json.encode(Config.loginDetails);
    var res = await req.send();
    await res.stream.bytesToString().then((value) {
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    });
    return true;
  }
}
