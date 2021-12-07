import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  bool isButtonActive = true;
  @override
  void onClose() {
    super.onClose();
  }

  void checkButton() {
    print("phone");
    isButtonActive = false;
    update();
  }
}
