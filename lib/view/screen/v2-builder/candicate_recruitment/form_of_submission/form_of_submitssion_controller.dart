import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2FormOfSubmitssionController extends GetxController {
//idTuyenDung
  String? idTuyenDung;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    idTuyenDung = Get.parameters['idTuyenDung'];
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  /// Nhân nút đánh văn bản
  ///
  void onClickTextTyingButton() {
    Get.toNamed(AppRoutes.V2_TEXT_TYING);
  }

  ///
  /// Nhấn vào nút nộp cv
  ///
  void onClickCvButton() {
    Get.toNamed('${AppRoutes.V2_CV}?idTuyenDung=$idTuyenDung')!
        .then((value) => {
              if (value != null && value == true) {Get.back(result: true)}
            });
  }
}
