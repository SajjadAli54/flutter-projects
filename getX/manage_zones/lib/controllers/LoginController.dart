import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:manage_zones/data/constants.dart';
import 'package:manage_zones/data/database.dart';
import 'package:manage_zones/services/api_service.dart';

class LoginController extends GetxController {
  RxString _username = "".obs;
  RxString _password = "".obs;

  String _token = "";

  final storage = const FlutterSecureStorage();

  void setUsername(value) => _username = value;
  void setPassword(value) => _password = value;

  Future<void> login() async {
    var url = Api.loginUrl;

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
      _token = jsonDecode(response.body)['jwtToken'];
      await _saveJwtToken();
      await populate();
    } else {
      throw Exception('Failed to login');
    }
  }

  _saveJwtToken() async {
    await storage.write(key: MyJwtToken.token, value: _token);
  }

  Future<String?> readToken() async {
    return await storage.read(key: MyJwtToken.token);
  }

  Future<void> populate() async {
    final LocalDatabase database = LocalDatabase.instance;

    final regions = await ApiService.getRegions(_token);
    await database.insertBatch("regions", regions);

    for (var reg in regions) {
      var id = reg["id"];
      final zones = await ApiService.getZones(_token, id);
      await database.insertBatch("zones", zones);
    }
  }
}
