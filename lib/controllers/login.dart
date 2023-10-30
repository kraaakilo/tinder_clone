import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = "".obs;
  final pin = "".obs;

  void setEmail(String value) {
    email.value = value;
  }

  void setPin(String value) {
    pin.value = value;
  }
}
