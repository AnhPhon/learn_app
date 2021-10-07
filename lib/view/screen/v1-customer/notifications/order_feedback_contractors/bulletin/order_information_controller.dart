

import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class OrderInformationController extends GetxController{


    ///
    /// Nhấn vào đông ý đơn hàng
    ///
    void onNextPage(){
      Get.toNamed(AppRoutes.V1_FORMAL_PAYMENT);
    }
}