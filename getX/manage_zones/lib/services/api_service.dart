import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manage_zones/data/constants.dart';

class ApiService {
  // Fetch regions
  static Future<List<Map<String, dynamic>>> getRegions(String token) async {
    final url = Uri.parse(Api.getRegionsUrl);
    final headers = {"Authorization": token, 'accept': "*/*"};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load regions');
    }
  }

  // Fetch zones by region ID
  static Future<List<Map<String, dynamic>>> getZones(
      String token, int regionId) async {
    final url = Uri.parse("${Api.getZonesUrl}$regionId");
    final headers = {"Authorization": token, 'accept': "*/*"};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load zones');
    }
  }

  // Post zones
  static Future<dynamic> postZone(
      String token, Map<String, dynamic> zoneData) async {
    final url = Uri.parse("${Api.postZonesUrl}/${zoneData["regionId"]}");
    final headers = {
      "Authorization": token,
      'Content-Type': 'application/json',
      'accept': "*/*"
    };

    final body = jsonEncode(zoneData);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post zone');
    }
  }
}
