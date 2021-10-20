

import 'package:get/get.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/routes/app_routes.dart';

class ReferencePriceTableController extends GetxController{
  DonDichVuRequest? request;
  String id = '0';
    @override
  void onInit() {
    
    super.onInit();
    if(Get.arguments != null){
      request = Get.arguments as DonDichVuRequest;
      id = Get.parameters['id'].toString();
    }
  }

  ////////////////////////////////
  /// Click continue button
  ///
  void onClickCotinueButton(){
    if(id == '2'){
      Get.toNamed(AppRoutes.V1_G2_CREATE_WORK, arguments: request,);
    }else if(id == '3'){
      // Tạo đơn dịch vụ có gía nhóm 3
      Get.toNamed(AppRoutes.V1_G3_CREATE_SERVICE, arguments: request);
    }else if(id == '4'){
      // Tạo đơn dich vụ có giá nhóm 4
      Get.toNamed(AppRoutes.V1_G4_CREATE_SERVICE,arguments: request);
    }else if(id == '5'){
      // Tạo đơn công viẹc và dịch nhóm 5
      Get.toNamed(AppRoutes.V1_G5_CREATE_SERVICE, arguments: request);
    }else if(id == '6'){
      // Tạo đơn công viẹc và dịch nhóm 6
      Get.toNamed(AppRoutes.V1_G6_CREATE_SERVICE, arguments: request);
    }else if(id == '7'){
      // Tạo đơn công viẹc và dịch nhóm 7
      Get.toNamed(AppRoutes.V1_G7_RECRUITMENT, arguments: request);
    }
  }

}