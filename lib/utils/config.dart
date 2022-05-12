import 'dart:convert';
import 'package:http/http.dart' as http;

class Config {
  static String baseUrl = "https://raktapp.sharpali.com";
  static String serverKey = "0e2603d8db46b8f6c1fdf0988436e815";
}

class ApiConfig {
  static String loginUrl = Config.baseUrl + "/api/auth";
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    print('username $username password $password');
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
    print(body);
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
}
