import 'package:flutter/cupertino.dart';
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

  final qualityController = TextEditingController();
  final focusNode = FocusNode();

  UserModel? userModel;

  bool isLastProduct = false;

  bool isLoading = true;

  bool isLoadingQuality = false;
  bool isReloadData = false;

  List<ProductResponse> selectedProductList = [];

  String? idUser;

  // List<String> qualityHint = [];

  int price = 0;

  //số lượng sản phẩm
  int qualityProduct = 1;

  @override
  void onInit() {
    super.onInit();
    loadSelectedProduct();
    getAddress();
    sl.get<SharedPreferenceHelper>().userId.then((value) => idUser = value);
  }

  ///
  ///load list selected product
  ///
  void loadSelectedProduct() {
    // qualityHint.clear();
    print("trong0");
    selectedProductList.clear();
    if (Get.parameters['idOrder'].toString() != "null") {
      print("trong1");
      productProvider.findByIdOrder(
          page: 1,
          limit: 100,
          idOrder: Get.parameters['idOrder'].toString(),
          onSuccess: (value) {
            print("trong2");
            selectedProductList = value;
            calculatorPrice();
            update();
          },
          onError: (error) {
            print(error);
            update();
          });
    }
  }

  ///
  ///get order id
  ///
  // void getOrderItem(int index) {
  //   focusNode.addListener(() {
  //     print("qualityController.text: ${qualityController.text}");
  //     orderItemProvider.update(
  //         data: OrderItemModel(
  //             id: selectedProductList[index].id,
  //             idOrder: selectedProductList[index].idOrder,
  //             idProduct: selectedProductList[index].idProduct!.id,
  //             price: selectedProductList[index].idProduct!.prices,
  //             quantity: qualityController.text),
  //         onSuccess: (value) {
  //           isLoadingQuality = false;
  //           update();
  //         },
  //         onError: (error) {});
  //   });
  // }

  ///
  ///xoá khỏi giỏ hàng
  ///
  void deleteItem(int index) {
    Get.defaultDialog(
        middleText: "Bạn có chắc muốn xóa sản phẩm",
        textCancel: "Hủy",
        textConfirm: "Đồng ý",
        cancelTextColor: ColorResources.BLACK,
        confirmTextColor: ColorResources.RED,
        onConfirm: () {
          isLoadingQuality = true;
          update();
          orderItemProvider.delete(
              id: selectedProductList[index].id.toString(),
              onSuccess: (value) {
                loadSelectedProduct();
                isReloadData = true;
                isLoadingQuality = false;
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
        id: idUser!,
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
    // .then((value) {
    //   if (value == true) {
    //     sl.get<SharedPreferenceHelper>().address.then((value) => null);
    //   }
    // });
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

  ///
  ///get back
  ///
  void onGetBack() {
    Get.back(result: isReloadData);
  }
}
