import 'dart:convert' as convert;
import 'dart:developer';

import 'package:getx_weather_app/app/modules/data/location_data.dart';
import 'package:getx_weather_app/app/modules/data/weather_data.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  final apiKey = "588b27dfbfc2acfec5d1db60d0cd2345";

  Future<Location?> getCurrentLocation() async {
    Location? location;

    var uri = Uri.http('ip-api.com', '/json');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      log('jsonResponse: $jsonResponse');
      location = Location.fromJson(jsonResponse);
      return location;
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }

    return location!;
  }

  Future<Weather?> getWeatherForLocation(Location location) async {
    Weather? weatherData;

    var params = {
      "lat": location.lat.toString(),
      "lon": location.lon.toString(),
      "city": location.regionName,
      "appid": apiKey,
    };

    var url = Uri.http("api.openweathermap.org", "/data/2.5/weather", params);

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      weatherData = Weather.fromJson(jsonResponse);
    }
    return weatherData;
  }
}
