

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';

class V1BuildOrderFeedBackController extends GetxController{
  DonDichVuResponse? dichVuResponse;

  @override
  void onInit() {
    if(Get.arguments != null){
      dichVuResponse = Get.arguments as DonDichVuResponse;
    }
    super.onInit();
  }

  void onClickAgreeButton(){
    // Đến màn hình chọn phương thức thanh toán
  }
}