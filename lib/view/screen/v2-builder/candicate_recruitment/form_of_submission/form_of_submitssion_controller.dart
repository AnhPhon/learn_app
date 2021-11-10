import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class V2FormOfSubmitssionController extends GetxController {
  //Provider
  final dangKyViecMoiProvider = GetIt.I.get<DangKyViecMoiProvider>();
  //idTuyenDung
  String? idTuyenDung;

  //isLoading
  bool isLoading = true;

  //userId
  String? userId;

  //check data user đăng ký việc mới
  bool isDangKyViecMoiWithUser = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idTuyenDung = Get.parameters['idTuyenDung'];
    isLoading = false;
    update();
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
    Get.toNamed('${AppRoutes.V2_WORK_CREATE}?tuyenDung=true');
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
