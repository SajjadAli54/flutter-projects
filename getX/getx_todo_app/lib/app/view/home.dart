import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/app/modules/controllers/home.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.red,
              Colors.blue,
              Colors.red,
            ],
          ),
        ),
        child: Obx(
          () => SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _rowItem(
                Icons.location_city_outlined,
                "Your location is ${_controller.address}",
              ),
              const SizedBox(height: 18),
              _rowItem(
                Icons.thermostat_outlined,
                "Your location is ${_controller.temperature}",
              ),
              const SizedBox(height: 18),
              _rowItem(
                Icons.info_outline,
                "You should ${_controller.message}",
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _rowItem(IconData icon, String message) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 8),
            Expanded(
              // We will give advice on what to do
              child: Text(
                message,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
