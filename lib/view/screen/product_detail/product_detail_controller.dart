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

class ProductDetailController extends GetxController {
  GetIt sl = GetIt.instance;

  //initialize scroll controller
  ScrollController? scrollController;

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  List<OrderItemModel> listOrderItem = [];

  bool isLoadingMore = false;
  List<ProductModel> productModelList = [];
  ProductModel? productModel;

  bool isLoadingProductDetail = true;
  bool isLoadingProductRelative = true;

  String idProduct = '';
  String idUser = '';

  // số lượng sản phẩm
  int quantityProduct = 1;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()
      ..addListener(() {
        scrollToTop();
      });

    // get id product from parameter
    idProduct = Get.parameters['productId'].toString();
    print('phuong $idProduct');

    // load id user
    sl.get<SharedPreferenceHelper>().userId.then((value) => idUser = value!);

    // get detail product by id
    getProductFromId(idProduct);

    // load product relative
    getMoreProduct();

    // load quantity cart
    loadQuanlityCart();
  }

  @override
  void dispose() {
    scrollController!.dispose(); // dispose the controller
    super.dispose();
  }

  ///
  ///load product
  ///
  void getProductFromId(String idProduct) {
    productProvider.find(
        id: idProduct,
        onSuccess: (value) {
          productModel = value;
          print('phuong $isLoadingProductDetail');
          print('phuong ${productModel!.toJson()}');
          isLoadingProductDetail = false;
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
          isLoadingProductRelative = false;
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  /// load cart initial
  ///
  void loadQuanlityCart() {
    listOrderItem.clear();

    // load info order item
    sl.get<SharedPreferenceHelper>().orderId.then((orderId) {
      print('orderId $orderId');
      if (orderId != null) {
        // load all product item by id order
        orderItemProvider.paginate(
            page: 1,
            limit: 100,
            filter: "&idOrder=$orderId",
            onSuccess: (data) {
              listOrderItem = data;

              print('listOrderItem ${listOrderItem.length}');
              update();
            },
            onError: (error) {});
      }
    });
  }

  ///
  /// tạo id đơn hàng
  ///
  void addProductToCartTap() {
    // kiểm tra đã có đơn hàng nào của user này chưa
    sl.get<SharedPreferenceHelper>().orderId.then((idOrder) async {
      // nếu có rồi thì dùng idOrder đó tạo orderItem
      if (idOrder != null) {
        // add order item to database
        addOrderItemToDatabase(idOrder);
      } else {
        // nếu chưa có thì tạo ra 1 order sau đó lưu id lại
        final OrderModel orderModel = OrderModel();
        orderModel.idUser = idUser;
        orderModel.userAccept = '0';
        orderModel.idWarehouse = '0';
        orderModel.description = 'Đơn đặt hàng mới';
        orderModel.statusOrder = '1';
        orderModel.statusPayment = '1';
        orderModel.totalPrice = '0';
        orderModel.discountPrice = '0';
        orderModel.idProvince = 'idProvince';
        orderModel.idDistrict = 'idDistrict';
        orderModel.address = 'address';
        orderProvider.add(
            data: orderModel,
            onSuccess: (data) {
              print('phuong ${data.toJson()}');
              // save id order
              sl.get<SharedPreferenceHelper>().saveOrderId(data.id.toString());

              // add order item to database
              addOrderItemToDatabase(data.id.toString());
            },
            onError: (error) {});
      }
    });
    // sau khi ấn view cart thì cần phải get all order item để tính toán tiền để update ngược lại cho đơn hàng để thông tin nó ok
  }

  ///
  /// add Order Item To Database
  ///
  void addOrderItemToDatabase(String idOrder) {
    final OrderItemModel itemModel = OrderItemModel();
    itemModel.idOrder = idOrder;
    itemModel.idProduct = idProduct;
    itemModel.quantity = quantityProduct.toString();
    itemModel.price = productModel!.prices;

    orderItemProvider.add(
        data: itemModel,
        onSuccess: (data) {
          print('add order item sucess $data');
          Get.snackbar(
            "Thành công",
            "Đã thêm sản phẩm vào giỏ hàng",
            colorText: ColorResources.PRIMARY,
            duration: const Duration(seconds: 3),
            backgroundGradient: const LinearGradient(colors: [
              Color(0xffd7ffba),
              Color(0xffeaffdb),
              Color(0xffd7ffba),
            ], begin: Alignment(2, -1), end: Alignment(1, 5)),
          );

          // sau khi add xong thì call lại method load số lượng đơn hàng trong cart
          loadQuanlityCart();
        },
        onError: (error) {});
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
  ///go to cart page
  ///
  void onCartClick() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      Get.toNamed("${AppRoutes.CART}?idOrder=$value");
    });
  }

  ///
  ///on Click more product
  ///
  void onClickMoreProduct(int index) {
    //gán lại idProduct sau khi click vào sản phẩm tương tự
    idProduct = productModelList[index].id!;

    // Load sản phẩm từ sản phẩm tương tự
    getProductFromId(productModelList[index].id!);

    //reload lại list sản phẩm tương tự, remove sản phẩm đã chọn khỏi list
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
          scrollToTop();
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  ///scroll to top when click other product
  ///
  void scrollToTop() {
    scrollController!.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  ///
  ///tăng số lượng
  ///
  void incrementQuality() {
    quantityProduct += 1;
    update();
  }

  ///
  ///giảm số lượng
  ///
  void decrementQuality() {
    if (quantityProduct > 1) {
      quantityProduct -= 1;
    }
    update();
  }
}
