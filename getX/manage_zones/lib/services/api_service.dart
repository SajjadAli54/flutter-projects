import 'package:manage_zones/data/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static getRegions(String token) {
    final url = Uri.parse(Api.getRegionsUrl);
    final headers = {"Authorization": token, 'accept': "*/*"};
    http.get(url, headers: headers);
  }
}
