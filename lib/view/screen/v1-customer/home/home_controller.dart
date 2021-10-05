import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1HomeController extends GetxController {
  ///
  /// tới trang quản lý đơn tạo
  ///
  
  String fullname = "KH, Nguyễn Văn A";
  void onClickFormManagementPage() {
    Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
  }

  ///
  /// Tới trang Tạo đơn công việc
  ///
  void onClickCreateWork(){
    Get.offAndToNamed(AppRoutes.V1_CREATEWORK);
  }
  
}
