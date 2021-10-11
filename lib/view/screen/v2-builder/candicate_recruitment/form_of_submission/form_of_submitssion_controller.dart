

import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2FormOfSubmitssionController extends GetxController{

  ///
  /// Nhân nút đánh văn bản
  ///
  void onClickTextTyingButton(){
    Get.toNamed(AppRoutes.V2_TEXT_TYING);
  }

  ///
  /// Nhấn vào nút nộp cv
  ///
  void onClickCvButton(){
    Get.toNamed(AppRoutes.V2_CV);
  }

}