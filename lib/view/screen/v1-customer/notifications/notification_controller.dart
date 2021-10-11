

import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1NotificationController extends GetxController{

  void onClickItem(int group){
    if(group == 1){
      // Đây là nhóm 1 không có trang thông báo phản hồi
      Get.toNamed(AppRoutes.V1_BUILD_ORDER_FEEDBACK);
    }else if(group == 5){
      // Đây là nhóm 5 phản hồi dịch vụ xe tải, xe ben, cầu thùng
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK5);
    }else if(group == 2){
      // Đây là nhóm 2 Công việc DVTX khảo sát báo giá
      Get.toNamed(AppRoutes.V1_ORDER_FEEDBACK_CONTRACTORS);
    }else if(group == 3){
      // Đây là nhóm 3 không có trang thông báo phản hồi
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6);
    }else if(group == 4){
      // Đây là nhóm 4 Không có trang thông báo phản hồi
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6);
    }else if(group == 6){
      // Đây là nhóm 6 dịch vụ xe đào,cầu nặng, máy khác
      Get.toNamed(AppRoutes.V1_GROUP_ORDER_FEEDBACK6);
    }
    //Get.toNamed(AppRoutes.V1ORDERFEEDBACKCONTRACTORS);
  }

}