import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1G1ReviewController extends GetxController{
  

  void onClickButton(){
    Get.offAll(AppRoutes.V1_SUCCESSFULLY);
  }

}