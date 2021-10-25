import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4NewWorkController extends GetxController {
  GetIt sl = GetIt.instance;
  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  CongViecNhanVienResponse? moiTaoModel;
  //Khai báo isLoading
  bool isLoading = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetailNewWork();
  }

  ///
  ///Get thông tin chi tiết công việc mới tạo
  ///
  void getDetailNewWork() {
    //get chi tiết công việc mới tạo theo id
    sl.get<SharedPreferenceHelper>().idNewWork.then((id) {
      congViecNhanVienProvider.find(
        id: id!,
        onSuccess: (value) {
          moiTaoModel = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }
}
