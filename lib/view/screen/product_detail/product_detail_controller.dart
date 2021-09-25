import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';

class ProductDetailController extends GetxController {
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();

  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  GetIt sl = GetIt.instance;

  final homeController = Get.put(HomeController());

  final categoriesController = Get.put(CategoriesController());

  List<ProductModel> productList = [];

  List<OrderItemModel> orderItemList = [];

  bool isLoadingMore = false;

  bool? isHave;

  @override
  void onInit() {
    super.onInit();
    getProductFromCart();
  }

  ///
  /// xem thêm mô tả sản phẩm
  ///
  void loadingMore() {
    isLoadingMore = true;
    update();
  }

  ///
  /// thu gọn
  ///
  void loadingLess() {
    isLoadingMore = false;
    update();
  }

  ///
  /// lấy tất cả sản phẩm
  ///
  void getAllProduct() {
    productProvider.all(onSuccess: (value) {
      productList = value;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///tạo id đơn hàng
  ///
  void order() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) async {
      if (value == null) {
        await orderProvider.add(
            data: OrderModel(
                idUser: homeController.userModel.id,
                statusOrder: "1",
                statusPayment: "2",
                description: "đây là nội dung",
                address: "dia chi nha",
                idDistrict: "61435cf012594e54736dd6ca",
                idProvince: "61435cf012594e54736dd6ca",
                discountPrice: "0",
                idWarehouse: "614457d87fee3b5dc8c1c75e",
                userAccept: "614748250c57f118c4a40689",
                totalPrice: "0",
                imagePayment: "0"),
            onSuccess: (value) {
              sl.get<SharedPreferenceHelper>().saveOrderId(value.id.toString());

              ///
              ///show snackbar
              ///
              Get.snackbar(
                "Thành công",
                "Đã thêm sản phẩm vào giỏ hàng",
                colorText: ColorResources.PRIMARY,
                backgroundGradient: const LinearGradient(colors: [
                  Color(0xffd7ffba),
                  Color(0xffeaffdb),
                  Color(0xffd7ffba),
                ], begin: Alignment(2, -1), end: Alignment(1, 5)),
              );
              update();
            },
            onError: (error) {
              print(error);
              update();
            });
      } else {
        final idOrder = value;
        final indexOrderItemList = orderItemList.indexWhere((element) =>
            element.idProduct == categoriesController.productWithId!.id);
        if (indexOrderItemList == -1) {
          Get.snackbar(
            "Thành công",
            "Đã thêm sản phẩm vào giỏ hàng",
            colorText: ColorResources.PRIMARY,
            backgroundGradient: const LinearGradient(colors: [
              Color(0xffd7ffba),
              Color(0xffeaffdb),
              Color(0xffd7ffba),
            ], begin: Alignment(2, -1), end: Alignment(1, 5)),
          );
          getProductFromCart();
          update();
          addToCart(
              idOrder: idOrder,
              idProduct: categoriesController.productWithId!.id!,
              quanlity: "1",
              price: categoriesController.productWithId!.prices!);
          update();
        } else {
          Get.snackbar(
            "Thất bại",
            "Sản phẩm đã tồn tại trong giỏ hàng",
            colorText: ColorResources.RED,
            backgroundGradient: const LinearGradient(colors: [
              Color(0xfffffcfc),
              Color(0xfffff5f5),
              Color(0xfffffcfc),
            ], begin: Alignment(2, -1), end: Alignment(1, 5)),
          );
          update();
        }
      }
    });
  }

  ///
  /// lấy sản phẩm trong giỏ hàng
  ///
  void getProductFromCart() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      if (value != null) {
        orderItemProvider.paginate(
            page: 1,
            limit: 100,
            filter: "&idOrder=$value",
            onSuccess: (value) {
              orderItemList = value;
              update();
            },
            onError: (error) {
              print(error);
              update();
            });
      }
    });
  }

  ///
  /// thêm vào giỏ hàng
  ///
  void addToCart(
      {required String idOrder,
      required String idProduct,
      required String quanlity,
      required String price}) {
    orderItemProvider.add(
        data: OrderItemModel(
            idOrder: idOrder,
            idProduct: idProduct,
            quantity: quanlity,
            price: price),
        onSuccess: (value) {
          print(value);
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  void onCartClick() {
    Get.toNamed(AppRoutes.CART);
  }

  ///
  ///  money normalize
  ///
  String moneyNormalize(int money, String splitSymbol) {
    String text = money.toString().split('').reversed.join();
    int size = text.length;

    String result = "";
    int mark = 0;
    for (int i = 0; i < size; i++) {
      mark += 1;
      result = text[i] + result;

      if (mark % 3 == 0) {
        result = splitSymbol + result;
      }
    }

    if (result[0] == splitSymbol) result = result.substring(1, result.length);

    return result;
  }
}
