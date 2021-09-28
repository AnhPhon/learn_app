import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/order_item_response_model.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class CartController extends GetxController {
  GetIt sl = GetIt.instance;

  final qualityController = TextEditingController();
  final focusNode = FocusNode();

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  List<OrderItemResponseModel> orderItemProductList = [];

  UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserModel? userModel;

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  String? province;

  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  String? district;

  String? address;

  bool isLastProduct = false;
  bool isLoading = true;
  bool isLoadingQuality = false;
  bool isReloadData = false;

  int price = 0;

  //số lượng sản phẩm
  List<int> qualityProduct = [];

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
    // qualityHint.clear();

    if (Get.parameters['idOrder'].toString() != "null") {
      orderItemProvider.findByIdOrder(
          page: 1,
          limit: 100,
          idOrder: Get.parameters['idOrder'].toString(),
          onSuccess: (value) {
            orderItemProductList.clear();
            orderItemProductList = value;
            value
                .map((quanlity) =>
                    qualityProduct.add(int.parse(quanlity.quantity!)))
                .toList();
            calculatorPrice();
            isLoading = false;
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
  //             id: orderItemProductList[index].id,
  //             idOrder: orderItemProductList[index].idOrder,
  //             idProduct: orderItemProductList[index].idProduct!.id,
  //             price: orderItemProductList[index].idProduct!.prices,
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
              id: orderItemProductList[index].id.toString(),
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
    for (var i = 0; i < orderItemProductList.length; i++) {
      price = int.parse(orderItemProductList[i].quantity!) *
          int.parse(orderItemProductList[i].idProduct!.prices!);
      price += price;
    }
    update();
  }

  ///
  ///tăng số lượng
  ///
  void incrementQuality(int index) {
    qualityProduct[index] += 1;
    calculatorPriceReload(index);
    update();
    orderItemProvider.update(
        data: OrderItemModel(
            id: orderItemProductList[index].id,
            idOrder: Get.parameters['idOrder'].toString(),
            quantity: qualityProduct[index].toString(),
            price: (qualityProduct[index] *
                    int.parse(orderItemProductList[index].idProduct!.prices!))
                .toString()),
        onSuccess: (value) {
          print("tăng thành công");
        },
        onError: (error) {});
  }

  ///
  ///giảm số lượng
  ///
  void decrementQuality(int index) {
    if (qualityProduct[index] > 1) {
      qualityProduct[index] -= 1;
      calculatorPriceReload(index);
      update();
      orderItemProvider.update(
          data: OrderItemModel(
              id: orderItemProductList[index].id,
              idOrder: Get.parameters['idOrder'].toString(),
              quantity: qualityProduct[index].toString(),
              price: (qualityProduct[index] *
                      int.parse(orderItemProductList[index].idProduct!.prices!))
                  .toString()),
          onSuccess: (value) {
            print("giảm thành công");
          },
          onError: (error) {});
    }
  }

  ///
  ///reload price
  ///
  void calculatorPriceReload(int index) {
    for (var i = 0; i < orderItemProductList.length; i++) {
      price = qualityProduct[index] *
          int.parse(orderItemProductList[i].idProduct!.prices!);
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
    sl.get<SharedPreferenceHelper>().address.then((value) => address = value);
    sl.get<SharedPreferenceHelper>().provinceId.then((value) {
      provinceProvider.find(
          id: value.toString(),
          onSuccess: (value) {
            province = value.name.toString();
          },
          onError: (error) {
            print(error);
          });
    });
    sl.get<SharedPreferenceHelper>().districtId.then((value) {
      districtProvider.find(
          id: value.toString(),
          onSuccess: (value) {
            district = value.name.toString();
          },
          onError: (error) {
            print(error);
          });
    });
    update();
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
