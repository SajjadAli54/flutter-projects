import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:manage_zones/data/constants.dart';
import 'package:manage_zones/data/database.dart';
import 'package:manage_zones/services/api_service.dart';

class LoginController extends GetxController {
  RxString username = "".obs;
  RxString password = "".obs;
  var body = "".obs;

  String _token = "";

  final storage = const FlutterSecureStorage();

  void setUsername(value) => username.value = value;
  void setPassword(value) => password.value = value;

  Future<void> login() async {
    if (username.isEmpty || password.isEmpty) return;

    var url = Api.loginUrl;

    final headers = {'accept': "*/*", 'Content-Type': 'application/json'};

    final data = jsonEncode({
      'username': username.value,
      'password': password.value,
    });

    final response = await http.post(
        Uri.parse("https://pspapi.eraconnect.net/api/account/login"),
        headers: headers,
        body: data);

    Map<String, dynamic> map =
        jsonDecode(response.body) as Map<String, dynamic>;

    _token = map["data"]["jwtToken"];
    body.value = map.toString();
    await _saveJwtToken();
    await populate();
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
