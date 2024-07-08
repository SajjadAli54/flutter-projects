import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString title = "".obs;
  RxList tasks = [].obs;

  setTitle(title) => this.title.value = title;

  add() {}
}
