import 'package:get/get.dart';
import 'package:getx_weather_app/app/modules/controllers/home.dart';
import 'package:getx_weather_app/app/modules/repositories/weather_repository.dart';

class HomeBinding extends Bindings {
  HomeBinding();
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherRepository());
    Get.lazyPut(() => HomeController());
  }
}
