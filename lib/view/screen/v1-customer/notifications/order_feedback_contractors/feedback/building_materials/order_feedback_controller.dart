


import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1OrderFeedBackController extends GetxController{


    void onClickAgreeButton(){
      Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION);
    }
}