import 'package:get/get.dart';
import 'package:manage_zones/data/database.dart';
import 'package:manage_zones/models/region.dart';
import 'package:manage_zones/models/zone.dart';

class DataController extends GetxController {
  RxList<Region> regions = <Region>[].obs;
  RxList<Zone> zones = <Zone>[].obs;

  RxString zoneTitle = "".obs;

  RxInt selectedId = 0.obs;

  final LocalDatabase database = LocalDatabase.instance;

  DataController() {
    _loadRegions();
  }

  setTitle(value) => zoneTitle.value = value;

  _loadRegions() async {
    regions.value = await database.getAllRegions();
    loadSpecificZone(regions[0].id);
  }

  loadSpecificZone(id) async {
    selectedId.value = id;
    zones.value = await database.getAllZones(id);
  }

  addZone() {
    final zone = Zone(
        regionId: selectedId.value,
        areasDto: [],
        type: "",
        id: -1,
        status: false,
        title: zoneTitle.value,
        createdBy: "",
        updatedBy: "",
        createdOn: DateTime.now(),
        updatedOn: DateTime.now());
    database.insert("zones", zone.toJson());
  }
}
