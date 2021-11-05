import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class V2AccountController extends GetxController {
  final TaiKhoanProvider accountProvider = GetIt.I.get<TaiKhoanProvider>();
   
  String title = "Tài khoản";

  String urlImage =
      "https://upload.wikimedia.org/wikipedia/commons/1/1e/Default-avatar.jpg";

  String name = "username";

  String email = "email@gmail.com";

  ///
  ///go to profile page
  ///
  void onProfileClick() {
    Get.toNamed(AppRoutes.V2_PROFILE);
  }

  ///
  ///go to point-based page
  ///
  void onPointBasedPageClick() {
    Get.toNamed(AppRoutes.V2_POINT_BASED);
  }

  ///
  ///go to wallet page
  ///
  void onWalletPageClick() {
    Get.toNamed(AppRoutes.V2_WALLET);
  }

  ///
  ///go to rules page
  ///
  void onRulesPageClick() {
    Get.toNamed(AppRoutes.V2_RULES);
  }

  ///
  ///go to intoduce page
  ///
  void onIntroducePageClick() {
    Get.toNamed(AppRoutes.V2_INTRODUCE);
  }

  ///
  ///go to help page
  ///
  void onHelpPageClick() {
    Get.toNamed(AppRoutes.V2_HELP);
  }

  ///
  ///go to job management page
  ///
  void onJobManagementClick() {
    Get.toNamed(AppRoutes.V2_JOB_MANAGEMENT);
  }

  ///
  ///Switch role customer
  ///
  void onSwitchCustomer() {
    sl.get<SharedPreferenceHelper>().userId.then((value){
      final TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();
       
        taiKhoanRequest.id = value;
        taiKhoanRequest.idLoaiTaiKhoan = KHACH_HANG;
        accountProvider.update(data: taiKhoanRequest, onSuccess: (onSuccess){
          sl.get<SharedPreferenceHelper>().saveTypeAccount(KHACH_HANG);
          Get.offAndToNamed(AppRoutes.V1_DASHBOARD);
        }, onError: (onError){
           Alert.error(message:"Chuyển vai trò thất bại");
        });
    });
  }

  ///
  ///Switch role agent
  ///
  void onSwitchAgent() {
    sl.get<SharedPreferenceHelper>().userId.then((value){
      final TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();
        taiKhoanRequest.id = value;
        taiKhoanRequest.idLoaiTaiKhoan = DAI_LY;
        accountProvider.update(data: taiKhoanRequest, onSuccess: (onSuccess){
          sl.get<SharedPreferenceHelper>().saveTypeAccount(DAI_LY);
          Get.offAndToNamed(AppRoutes.V3_DASHBOARD);
        }, onError: (onError){
           Alert.error(message:"Chuyển vai trò thất bại");
        });
    });
  }

}
