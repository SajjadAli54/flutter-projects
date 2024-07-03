import 'package:get/get.dart';

class CounterController extends GetxController {
  RxInt count = 0.obs;

  increment() => count++;
}
