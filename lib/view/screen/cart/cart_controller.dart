import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/product_response_model.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class CartController extends GetxController {
  GetIt sl = GetIt.instance;

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  UserProvider userProvider = GetIt.I.get<UserProvider>();

  bool isLastProduct = false;

  bool isLoading = true;

  List<ProductResponse> selectedProductList = [];

  int price = 0;

  UserModel? userModel;

  //số lượng sản phẩm
  int qualityProduct = 1;

  @override
  void onInit() {
    super.onInit();
    loadSelectedProduct();
    getAddress();
  }

  ///
  ///load list selected product
  ///
  void loadSelectedProduct() {
    selectedProductList.clear();
    productProvider.findByIdOrder(
        page: 1,
        limit: 100,
        idOrder: Get.parameters['idOrder'].toString(),
        onSuccess: (value) {
          selectedProductList = value;
          calculatorPrice();
          // isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  //xoá khỏi giỏ hàng
  void deleteItem(int index) {
    Get.defaultDialog(
        middleText: "Bạn có chắc muốn xóa sản phẩm",
        textCancel: "Hủy",
        textConfirm: "Đồng ý",
        cancelTextColor: ColorResources.BLACK,
        confirmTextColor: ColorResources.RED,
        onConfirm: () {
          update();
          orderItemProvider.delete(
              id: selectedProductList[index].id.toString(),
              onSuccess: (value) {
                loadSelectedProduct();
                update();
              },
              onError: (error) {
                print(error);
                update();
              });
          Get.back();
        });
  }

  ///
  ///calculator price
  ///
  void calculatorPrice() {
    for (var i = 0; i < selectedProductList.length; i++) {
      price = int.parse(selectedProductList[i].quantity!) *
          int.parse(selectedProductList[i].idProduct!.prices!);
      price += price;
    }
    update();
  }

  ///
  ///tăng số lượng
  ///
  void incrementQuality() {
    qualityProduct += 1;
    update();
  }

  ///
  ///giảm số lượng
  ///
  void decrementQuality() {
    qualityProduct -= 1;
    update();
  }

  ///
  ///address
  ///

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }

  ///
  ///get address from iUser
  ///
  void getAddress() {
    userProvider.find(
        id: "614748250c57f118c4a40689",
        onSuccess: (value) {
          userModel = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  ///thay đổi địa chỉ
  ///
  void onAddressClick() {
    Get.toNamed(AppRoutes.ADDRESS);
  }

  ///
  ///thanh toán
  ///
  void onCheckoutClick() {
    sl
        .get<SharedPreferenceHelper>()
        .orderId
        .then((value) => Get.toNamed("${AppRoutes.CHECKOUT}?idOrder=$value"));
  }
}
