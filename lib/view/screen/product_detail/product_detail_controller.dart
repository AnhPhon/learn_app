import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/data/model/response/product_response_model.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class ProductDetailController extends GetxController {
  GetIt sl = GetIt.instance;

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();

  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  List<ProductResponse> productFromCartList = [];

  bool isLoadingMore = false;

  ProductModel? productModel;

  List<ProductModel> productModelList = [];

  bool isLoading = true;

  //số lượng sản phẩm
  int qualityProduct = 1;

  @override
  void onInit() {
    super.onInit();
    getProductFromId(Get.parameters['productId'].toString());
    getMoreProduct();
    loadQuanlityCart();
    print(Get.parameters['productId'].toString());
  }

  ///
  ///load product
  ///
  void getProductFromId(String idProduct) {
    productProvider.find(
        id: idProduct,
        onSuccess: (value) {
          productModel = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///load more product
  ///
  void getMoreProduct() {
    productProvider.paginate(
        page: 1,
        limit: 100,
        filter: "idCategory=${Get.parameters['categoryId']}",
        onSuccess: (value) {
          // minus selected product
          final int indexIdInitialProduct = value.indexWhere((element) =>
              element.id.toString() == Get.parameters['productId'].toString());
          value.removeAt(indexIdInitialProduct);
          productModelList = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  /// xem thêm mô tả sản phẩm
  ///
  void loadingMore() {
    isLoadingMore = false;
    update();
  }

  ///
  /// thu gọn
  ///
  void loadingLess() {
    isLoadingMore = true;
    update();
  }

  ///
  ///tạo id đơn hàng
  ///
  void order() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) async {
      if (value == null) {
        print("trong0");
        await orderProvider.add(
            data: OrderModel(
                idUser: "614748250c57f118c4a40689",
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
              print("IDORDER: ${value.id}");

              ///
              ///add to cart
              ///
              addToCart(
                  idOrder: value.id!,
                  idProduct: Get.parameters['productId'].toString(),
                  quanlity: qualityProduct.toString(),
                  price: Get.parameters['price'].toString());

              ///
              ///load quality again
              ///
              loadQuanlityCart();

              isLoading = false;
              update();

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
            },
            onError: (error) {
              print(error);
              update();
            });
      } else {
        final idOrder = value;
        final indexOrderItemList = productFromCartList.indexWhere((element) =>
            element.idProduct!.id == Get.parameters['productId'].toString());
        if (indexOrderItemList == -1) {
          print("trong2");
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

          ///
          ///add to cart
          ///
          addToCart(
              idOrder: idOrder,
              idProduct: Get.parameters['productId'].toString(),
              quanlity: qualityProduct.toString(),
              price: Get.parameters['price'].toString());

          ///
          ///load quality
          ///
          loadQuanlityCart();

          isLoading = false;
          update();
        } else {
          print("trong4");
          isLoading = false;
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
  /// load cart initial
  ///
  void loadQuanlityCart() {
    productFromCartList.clear();
    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      if (value != null) {
        productProvider.findByIdOrder(
            page: 1,
            limit: 100,
            idOrder: value,
            onSuccess: (value) {
              productFromCartList = value;
              update();
            },
            onError: (error) {
              print(error);
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

  ///
  ///go to cart page
  ///
  void onCartClick() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      Get.toNamed("${AppRoutes.CART}?idOrder=$value")!.then((value) {
        if (value == true) {
          loadQuanlityCart();
        }
      });
    });
  }

  ///
  ///on Click more product
  ///
  void onClickMoreProduct(int index) {
    isLoading = true;
    update();
    getProductFromId(productModelList[index].id!);
    reloadMoreProduct(productModelList[index].id!);
  }

  ///
  ///reload more product
  ///
  void reloadMoreProduct(String id) {
    productProvider.paginate(
        page: 1,
        limit: 100,
        filter: "idCategory=${Get.parameters['categoryId']}",
        onSuccess: (value) {
          // minus selected product
          final int indexIdInitialProduct =
              value.indexWhere((element) => element.id == id);
          value.removeAt(indexIdInitialProduct);

          //reload list
          productModelList = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
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
    if (qualityProduct > 1) {
      qualityProduct -= 1;
    }
    update();
  }
}