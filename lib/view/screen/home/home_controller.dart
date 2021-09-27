import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_model.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class HomeController extends GetxController {
  UserProvider userProvider = GetIt.I.get<UserProvider>();

  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();

  UserModel userModel = UserModel();
  OrderModel orderModel = OrderModel();
  OrderItemModel orderItemModel = OrderItemModel();
  //banner
  List banner = [Images.banner1, Images.banner2, Images.banner3];

  List<CategoryModel> categoriesList = [];

  double? doanhSoDoiNhom;
  double? doanhSoCaNhan;
  int? soLuongId;
  int? soLuongDonGia;

  int categoryPages = 0;

  String name = "";
  String role = "";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getAllCategory();

    doanhSoDoiNhom = 0;
    doanhSoCaNhan = 0;
    soLuongId = 0;
    soLuongDonGia = 0;

    getUserById();
    update();
  }

  ///
  ///get all categ
  ///
  void getAllCategory() {
    categoryProvider.all(onSuccess: (value) {
      categoriesList = value;
      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///lấy thông tin user
  ///
  void getUserById() {
    update();
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        final String userId = value!;
        userProvider.find(
            id: userId,
            onSuccess: (value) {
              name = value.fullname!;

              // ??????
              role = value.idOptionalRole!;
              update();
            },
            onError: (error) {
              print(error);
            });

        orderProvider.paginate(
          filter: '&idUser=$userId',
          limit: 100,
          page: 1,
          onSuccess: (data) {
            for (final OrderModel element in data) {
              final String orderId = element.id!;
              // order item
              orderItemProvider.paginate(
                page: 1,
                limit: 100,
                filter: "&idOrder=$orderId",
                onSuccess: (models) {
                  for (final OrderItemModel model in models) {
                    if (model.idOrder! == orderId) {
                      soLuongDonGia =
                          soLuongDonGia! + int.parse(model.quantity!);
                      doanhSoCaNhan = doanhSoCaNhan! +
                          int.parse(model.price!) * int.parse(model.quantity!);
                      update();
                    }
                  }
                },
                onError: (error) {
                  print(error);
                },
              );
            }
          },
          onError: (error) {
            print(error);
          },
        );

        userProvider.find(
          id: userId,
          onSuccess: (models) {
            soLuongId = soLuongId! + 1;
            orderProvider.paginate(
              filter: '&idUser=${models.id}',
              limit: 100,
              page: 1,
              onSuccess: (data) {
                for (final OrderModel element in data) {
                  final String orderId = element.id!;
                  // order item
                  orderItemProvider.paginate(
                    page: 1,
                    limit: 100,
                    filter: "&idOrder=$orderId",
                    onSuccess: (models) {
                      for (final OrderItemModel model in models) {
                        if (model.idOrder! == orderId) {
                          doanhSoDoiNhom = doanhSoDoiNhom! +
                              int.parse(model.price!) *
                                  int.parse(model.quantity!);
                          update();
                        }
                      }
                    },
                    onError: (error) {
                      print(error);
                    },
                  );
                }
              },
              onError: (error) {
                print(error);
              },
            );
          },
          onError: (error) {
            print(error);
            // update();
          },
        );
      },
    );
    update();
  }

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }

  ///
  /// onRegisterIdClick
  ///
  void onRegisterIdClick() {
    Get.toNamed(AppRoutes.REGISTER);
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
