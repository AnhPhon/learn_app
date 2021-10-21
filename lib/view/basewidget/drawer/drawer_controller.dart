import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:template/data/model/body/menu.dart';
import 'package:template/provider/lien_he_cong_ty_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

import '../../../di_container.dart';
class DrawerController extends GetxController{
  LienHeCongTyProvider contactProvider = GetIt.I.get<LienHeCongTyProvider>();
  List<Menu> menu = [];
  List<String> contact = [];

  @override
  void onInit() {
    super.onInit();

    menu = [
      Menu(title: 'Giới thiệu tóm tắt cơ chế hoạt động', onPress:()=> onPushName(AppRoutes.V1_ABOUT)),
      Menu(title: 'Quyền và nghĩa vụ của FSS', onPress: ()=> onPushName(AppRoutes.V1_OBLIGATIONS)),
      Menu(title: 'Quy trình sử dụng vào giao dịch', onPress: ()=> onPushName(AppRoutes.V1_USAGE_PROCEDURE)),
      Menu(title: 'Điều khoản và chính sách', onPress: ()=> onPushName(AppRoutes.V1_TERM_AND_POLICY)),
      Menu(title: 'Lợi ích khi tham gia FSS', onPress: ()=> onPushName(AppRoutes.V1_BENEFITS)),
      Menu(title: 'Đánh giá', onPress: rating),
      Menu(title: 'Đăng xuất', onPress: ()=> logout()),
    ];
    
    // contact = const [
    //   'Hotline: 098.999.333',
    //   'Email: duan5sao@gmail.com',
    //   'VP: 170 Nguyễn Đình Thi Phường Hoà Xuân, Quận Cẩm Lệ Thành Phố Đà Nẵng'
    // ];
    getContact();

  }

  ///
  /// Logout
  ///
  void logout() {
    sl.get<SharedPreferenceHelper>().removeIsLogin();
    sl.get<SharedPreferenceHelper>().removeJwtToken();
    sl.get<SharedPreferenceHelper>().removePassword();
    sl.get<SharedPreferenceHelper>().removeUserId();
    onPushName(AppRoutes.LOGIN);
  }

  void getContact(){
    contactProvider.all(onSuccess: (data){
      contact = [
        'Hotline: ${data.first.soDienThoai}',
        'Email: ${data.first.email}',
        'VP: ${data.first.diaChi}'
      ];
      update();
    }, onError: (onError){
      update();
      print("DrawerController getContact onError $onError");
    });
  }

  void rating()async{
    final InAppReview inAppReview = InAppReview.instance;
    print("Show");
    if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
    }
  }

  void onPushName(String name){
    Get.toNamed(name);
  }

}