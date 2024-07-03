import 'package:get/get.dart';

import 'package:getx_weather_app/app/modules/data/location_data.dart';
import 'package:getx_weather_app/app/modules/data/weather_data.dart';
import 'package:getx_weather_app/app/modules/repositories/weather_repository.dart';

class HomeController extends GetxController {
  final WeatherRepository _weatherRepository = Get.find();

  final Rxn<Location> _location = Rxn();
  final Rxn<Weather> _weather = Rxn();
  final Rxn<String> _infoText = Rxn();

  String get address =>
      "${_location.value?.city} ${_location.value?.regionName}, ${_location.value?.country}";

  String get temperature => "${_weather.value?.temp}";

  String? get message => _infoText.value;

  @override
  void onInit() async {
    super.onInit();
    await getCurrentLocation();
    await getTemperatureForCurrentLocation();
  }

  getCurrentLocation() async {
    Location? location = await _weatherRepository.getCurrentLocation();
    // log(location?.regionName);

    _location.value = location;
  }

  getTemperatureForCurrentLocation() async {
    if (_location.value != null) {
      _weather.value =
          await _weatherRepository.getWeatherForLocation(_location.value!);
      _getInfoText(_weather.value?.temp);
    }
  }

  _getInfoText(int? temperature) {
    if (temperature == null) {
      _infoText.value = "unknown";
    } else if (temperature <= 0) {
      _infoText.value =
          "make sure to dress thick cloths! It's freezing out there!";
    } else if (temperature <= 15) {
      _infoText.value = "wear a jacket, don't catch a cold!";
    } else if (temperature <= 40) {
      _infoText.value = "enjoy the weather, it's nice!";
    } else {
      _infoText.value = "be at your home or cool place! It's too hot!";
    }
  }
}
