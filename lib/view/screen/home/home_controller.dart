import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/static_user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/images.dart';

class HomeController extends GetxController {
  UserProvider userProvider = GetIt.I.get<UserProvider>();
  CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();

  UserModel userModel = UserModel();
  StaticUserResponse staticUserResponse = StaticUserResponse();

  // banner
  List banner = [Images.banner1, Images.banner2, Images.banner3];
  List<CategoryModel> categoriesList = [];

  int categoryPages = 0;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    sl.get<SharedPreferenceHelper>().userId.then(
      (userId) {
        // load data user by id
        getUserById(userId!);
      },
    );

    // load data categories
    getAllCategory();
  }

  ///
  /// lấy thông tin user
  ///
  void getUserById(String userId) {
    // load data user by id
    userProvider.find(
        id: userId,
        onSuccess: (data) {
          userModel = data;
          // load data revanue and statistical of team
          userProvider.statisUser(
              idUser: userId,
              onSuccess: (data) {
                staticUserResponse = data;
                isLoading = false;
                update();
              },
              onError: (error) {});
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///get all categ
  ///
  void getAllCategory() {
    categoryProvider.all(onSuccess: (value) {
      categoriesList = value;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///onCartClick
  ///
  void onCartClick() {
    Get.toNamed(AppRoutes.CART);
  }

  ///
  /// onRegisterIdClick
  ///
  void onRegisterIdClick() {
    Get.toNamed(AppRoutes.INFORMATION_USER);
  }

  ///
  /// onBtnCategoriesClick
  ///
  void onBtnCategoriesClick(int? index) {
    Get.toNamed(
        "${AppRoutes.CATEGORIES}?indexTab=$index&idCategory=${categoriesList[index!].id}")!;
  }

  ///
  /// onProductVoucherClick
  ///
  void onProductVoucherClick() {
    Get.toNamed(AppRoutes.KHOHANGTROGIA);
  }

  ///
  /// onBtnKhoHangDieuKienClick
  ///
  void onBtnKhoHangDieuKienClick() {
    Get.toNamed(AppRoutes.KHOHANGDIEUKIEN);
  }

  ///
  /// onGroupClick
  ///
  void onGroupClick() {
    Get.toNamed(AppRoutes.GROUP);
  }
}
