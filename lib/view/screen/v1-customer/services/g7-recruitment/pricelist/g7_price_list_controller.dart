


import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:template/routes/app_routes.dart';

class V1G7PriceListController extends GetxController{
  

  ///
  /// Nhấn tiếp tục 
  ///
  void onClickContinueButton(){
    Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION);
  }
}