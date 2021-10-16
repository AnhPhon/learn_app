

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/thong_tin_f_s_s_response.dart';
import 'package:template/provider/thong_tin_f_s_s_provider.dart';

class BenefitsController extends GetxController{
  final ThongTinFSSProvider thongTinFSS = GetIt.I.get<ThongTinFSSProvider>();
  List<ThongTinFSSResponse> fss = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getBenefits();
  }

  ////////////////////////////////
  /// Lấy thông tin Hoat động
  ///
  void getBenefits(){
    thongTinFSS.all(onSuccess: (data){
      fss = data;
      isLoading = false;
      update();
    }, onError: (onError){
      print("BenefitsController getBenefits onError $onError");
    });
  }
}