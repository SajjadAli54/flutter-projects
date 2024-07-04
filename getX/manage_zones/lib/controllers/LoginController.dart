import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  RxString _username = "".obs;
  RxString _password = "".obs;

  void setUsername(value) => _username = value;

  void setPassword(value) => _password = value;

  Future<String> login() async {
    const url = "https://pspapi.eraconnect.net/api/login";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _username.value,
        'password': _password.value,
      }),
    );

    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)['token'];
      _saveJwtToken(token);
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  _saveJwtToken(String token) {}
}
