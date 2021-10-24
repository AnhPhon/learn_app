import 'package:get/get.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';

class V1CandidateProfileController extends GetxController {
  // Trạng thái hồ sơ data ảo
  bool statusProfile = false;

  //value model
  DangKyViecMoiResponse dangKyViecMoiResponse = DangKyViecMoiResponse();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //set data đang ký việc mới
    dangKyViecMoiResponse = Get.arguments as DangKyViecMoiResponse;
    print('dangKyViecMoiResponse ${dangKyViecMoiResponse.toJson()}');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onViewProfile() {
    statusProfile = true;
    update();
  }
}
