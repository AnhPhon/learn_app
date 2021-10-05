import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:template/data/model/body/menu.dart';
import 'package:template/routes/app_routes.dart';
class DrawerController extends GetxController{

  List<Menu> menu = [];
  List<String> contact = [];

  @override
  void onInit() {
    super.onInit();

    menu = [
      Menu(title: 'Giới thiệu tóm tắt cơ chế hoạt động', onPress:()=> onPushName(AppRoutes.V1ABOUT)),
      Menu(title: 'Quyền và nghĩa vụ của FSS', onPress: ()=> onPushName(AppRoutes.V1OBLIGATIONS)),
      Menu(title: 'Quy trình sử dụng vào giao dịch', onPress: ()=> onPushName(AppRoutes.V1USAGEPROCEDURE)),
      Menu(title: 'Điều khoản và chính sách', onPress: ()=> onPushName(AppRoutes.V1TERMANDPOLICY)),
      Menu(title: 'Lợi ích khi tham gia FSS', onPress: ()=> onPushName(AppRoutes.V1BENEFITS)),
      Menu(title: 'Đánh giá', onPress: (){}),
      Menu(title: 'Đăng xuất', onPress: ()=> onPushName(AppRoutes.LOGIN)),
    ];
    
    contact = const [
      'Hotline: 098.999.333',
      'Email: duan5sao@gmail.com',
      'VP: 170 Nguyễn Đình Thi Phường Hoà Xuân, Quận Cẩm Lệ Thành Phố Đà Nẵng'
    ];

  }

  void onPushName(String name){
    Get.toNamed(name);
  }

}