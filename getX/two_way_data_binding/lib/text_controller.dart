import 'package:get/get.dart';

class TextController extends GetxController {
  RxString text = ''.obs;

  updateText(text) => this.text.value = text;
}
