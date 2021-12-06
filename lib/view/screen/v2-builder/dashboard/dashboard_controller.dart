import 'package:get/get.dart';
import 'package:template/helper/izi_alert.dart';

class V2DashboardController extends GetxController {
  int tabIndex = 0;
  DateTime? currentBackPressTime;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
  
  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print(currentBackPressTime);
      IZIAlert.info(message: "Bạn muốn thoát ứng dụng");
      return Future.value(false);
    }
    return Future.value(true);
  }
  
}
