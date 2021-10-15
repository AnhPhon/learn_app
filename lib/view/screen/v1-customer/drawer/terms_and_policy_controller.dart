

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/dieu_khoan_chinh_sach_response.dart';
import 'package:template/provider/dieu_khoan_chinh_sach_provider.dart';

class TermsAndPolicyController extends GetxController{
  final DieuKhoanChinhSachProvider dieuKhoanChinhSachProvider = GetIt.I.get<DieuKhoanChinhSachProvider>();
  List<DieuKhoanChinhSachResponse> fss = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getTermsAndPolicy();
  }

  ////////////////////////////////
  /// Lấy thông tin fss
  ///
  void getTermsAndPolicy(){
    dieuKhoanChinhSachProvider.all(onSuccess: (data){
      fss = data;
      isLoading = false;
      update();
    }, onError: (onError){
      print("TermsAndPolicyController getTermsAndPolicy onError $onError");
    });
  }
}