import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/response/product_response_model.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class OrderDetailController extends GetxController {
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  List<OrderModel> orderList = [];

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  List<ProductResponse> orderItemList = [];

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();

  String? userId;
  double? price;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    // sl.get<SharedPreferenceHelper>().userId.then((value) {
    //   userId = value;
    //   getOrderbyIdUser();
    // });
    getOrderItem();
    update();
  }

  ///
  ///get order by id user
  ///
  void getOrderbyIdUser() {
    sl
        .get<SharedPreferenceHelper>()
        .userId
        .then((value) => orderProvider.paginate(
            page: 1,
            limit: 100,
            filter: "&idUser=$value",
            onSuccess: (value) {
              orderList = value;
              update();
            },
            onError: (error) {
              print(error);
            }));
  }

  ///
  ///get order item
  ///
  void getOrderItem() {
    productProvider.findByIdOrder(
        page: 1,
        limit: 100,
        idOrder: Get.parameters['idOrder'].toString(),
        onSuccess: (value) {
          orderItemList = value;
          isLoading = false;
          getPrice();
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  void onHistoryClick() {
    Get.toNamed(AppRoutes.HISTORY);
  }

  ///
  ///get price
  ///
  void getPrice() {
    for (var i = 0; i < orderItemList.length; i++) {
      price = double.parse(orderItemList[i].quantity.toString()) *
          double.parse(orderItemList[i].idProduct!.prices.toString());
    }
  }
}



  // List payment = ["Giá tiền", "Phí ship", "Khuyến mãi", "Tổng"];
  // List price = ["150.000đ", "15.000đ", "-50.000đ", "115.000đ"];
