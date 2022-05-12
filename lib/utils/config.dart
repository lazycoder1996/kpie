import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kpie/utils/shared_pref.dart';

class Config {
  static String baseUrl = "https://raktapp.sharpali.com";
  static String serverKey = "0e2603d8db46b8f6c1fdf0988436e815";
}

class ApiConfig {
  static Future<Map<String, dynamic>> postItem(
      Map<String, String> bodyData) async {
    String accessToken = SharedPrefs.getToken();
    String postUrl = Config.baseUrl + "/api/new_post?access_token=$accessToken";
    Uri url = Uri.parse(postUrl);
    var req = http.MultipartRequest('POST', url);
    bodyData['server_key'] = Config.serverKey;
    req.fields.addAll(bodyData);

    var res = await req.send();
    String resBody = await res.stream.bytesToString();
    Map<String, dynamic> body = json.decode(resBody);
    int? code = int.tryParse(body['api_status'].toString());
    if (code! >= 200 && code < 300) {
      return {
        'response': resBody,
        'status': true,
      };
    } else {
      return {
        'response': body['errors'],
        'status': false,
      };
    }
  }

  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    String loginUrl = Config.baseUrl + "/api/auth";

    Uri url = Uri.parse(loginUrl);
    var req = http.MultipartRequest('POST', url);
    Map<String, String> reqBody = {
      'username': username,
      'password': password,
      'server_key': Config.serverKey,
    };
    req.fields.addAll(reqBody);

    var res = await req.send();
    String resBody = await res.stream.bytesToString();
    Map<String, dynamic> body = json.decode(resBody);
    int? code = int.tryParse(body['api_status'].toString());
    if (code! >= 200 && code < 300) {
      await SharedPrefs.saveToken(body["access_token"]);
      return {
        'response': resBody,
        'status': true,
      };
    } else {
      return {
        'response': body['errors'],
        'status': false,
      };
    }
  }
}
