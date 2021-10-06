import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1FormalPaymentController extends GetxController{
  
  void onNextPage(){
    Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION);
  }

}