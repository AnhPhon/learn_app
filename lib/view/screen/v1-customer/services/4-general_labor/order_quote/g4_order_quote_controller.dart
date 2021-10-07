import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1G4OrderQuoteController extends GetxController{
  int currentSelected = 0;


  ///
  /// Chọn item
  ///
  void onSelectedItem(int index){
    // Get item position index 
    currentSelected = index;
    update();
  }

  void onNextPage(){
    Get.toNamed(AppRoutes.V1_G4_ORDER_DETAIL);
  }

}