import 'package:get/get.dart';

class LoginCOntroller extends GetxController {
  RxString _username = "".obs;
  RxString _password = "".obs;

  void setUsername(value) => _username = value;

  void setPassword(value) => _password = value;

  void login() {}
}
