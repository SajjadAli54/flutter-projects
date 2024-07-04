import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_zones/controllers/DataController.dart';
import 'package:manage_zones/models/region.dart';
import 'package:manage_zones/view/log_out.dart';

class Zones extends StatelessWidget {
  const Zones({super.key});

  @override
  Widget build(BuildContext context) {
    final DataController controller = Get.put(DataController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zones and Regions"),
        actions: const [LogOut()],
      ),
      body: Obx(() => Center(
            child: ListView(
              children: [
                DropdownButton<Region>(
                  menuMaxHeight: 12,
                  items: controller.regions
                      .map<DropdownMenuItem<Region>>((Region value) {
                    return DropdownMenuItem<Region>(
                      value: value,
                      child: Text(value.title),
                    );
                  }).toList(),
                  onChanged: (reg) => controller.loadSpecificZone(reg?.id),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => controller.setTitle(value),
                  decoration: const InputDecoration(
                      labelText: "Enter the Zone title to add in region"),
                ),
                const SizedBox(height: 20),
                // ListView(
                //   children: controller.zones
                //       .map((element) => Text(element.title))
                //       .toList(),
                // )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: controller.addZone, child: const Icon(Icons.add)),
    );
  }
}
