import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/home/kho_hang_tro_gia/kho_hang_tro_gia_controller.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class HomeController extends GetxController {
  UserProvider userProvider = GetIt.I.get<UserProvider>();

  UserModel userModel = UserModel();

  final categoriesController = Get.put(CategoriesController());
  final khoHangTroGiaController = Get.put(KhoHangTroGiaController());
  //banner
  List banner = [Images.banner1, Images.banner2, Images.banner3];

  int categoryPages = 0;

  @override
  void onInit() {
    super.onInit();
    getUserById();
    khoHangTroGiaController.getAllCategories();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //lấy thông tin user
  void getUserById() {
    userProvider.find(
        id: "614748250c57f118c4a40689",
        onSuccess: (value) {
          userModel = value;
          print("user");
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }

  // tạo id
  void onRegisterIdClick() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  //danh mục
  void onBtnCategoriesClick(int? index) {
    categoriesController.tabController!.index = index!;
    Get.toNamed(AppRoutes.CATEGORIES);
  }

  //kho hàng trợ giá
  void onProductVoucherClick() {
    Get.toNamed(AppRoutes.KHOHANGTROGIA);
  }

  // kho hàng điều kiện
  void onBtnKhoHangDieuKienClick() {
    Get.toNamed(AppRoutes.KHOHANGDIEUKIEN);
  }

  //đội nhóm
  void onGroupClick() {
    Get.toNamed(AppRoutes.GROUP);
  }
}
