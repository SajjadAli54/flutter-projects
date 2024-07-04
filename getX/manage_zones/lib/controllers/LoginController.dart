import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:manage_zones/data/constants.dart';

class LoginController extends GetxController {
  RxString _username = "".obs;
  RxString _password = "".obs;

  final storage = const FlutterSecureStorage();

  void setUsername(value) => _username = value;
  void setPassword(value) => _password = value;

  Future<void> login() async {
    const url = Api.loginUrl;

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
    } else {
      throw Exception('Failed to login');
    }
  }

  _saveJwtToken(String token) async {
    await storage.write(key: MyJwtToken.token, value: token);
  }

  Future<String?> readToken() async {
    return await storage.read(key: MyJwtToken.token);
  }
}
