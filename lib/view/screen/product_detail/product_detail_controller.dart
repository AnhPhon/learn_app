import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/home/home_controller.dart';

class ProductDetailController extends GetxController {
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  final homeController = Get.put(HomeController());

  List<ProductModel> productList = [];

  bool isLoadingMore = false;

  // xem thêm mô tả sản phẩm
  void loadingMore() {
    isLoadingMore = true;
    update();
  }

  // thu gọn
  void loadingLess() {
    isLoadingMore = false;
    update();
  }

  // lấy tất cả sản phẩm
  void getAllProduct() {
    productProvider.all(onSuccess: (value) {
      productList = value;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  //tạo id đơn hàng
  void order() {
    orderProvider.add(
        data: OrderModel(
          idUser: homeController.userModel.id,
          statusOrder: "1",
          statusPayment: "2",
          description: "đây là nội dung",
          address: homeController.userModel.address,
          idDistrict: "61435cf012594e54736dd6ca",
          idProvince: "61435cf012594e54736dd6ca",
        ),
        onSuccess: (value) {
          print(value);
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  //thêm vào giỏ hàng
  void addToCart() {
    orderItemProvider.add(
        data: OrderItemModel(),
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

  //  money normalize
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
