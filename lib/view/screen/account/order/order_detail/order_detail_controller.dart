import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/response/order_item_response_model.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class OrderDetailController extends GetxController {
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  List<OrderModel> orderList = [];
  OrderModel orderModel = OrderModel();
  String? orderId;

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  List<OrderItemResponseModel> orderItemList = [];

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  String? province;

  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  String? district;

  String? address;

  String? userId;
  int? price;

  bool isLoading = true;

  Map<String, String> statusLabel = {
    "1": "Mới tạo",
    "2": "Đang xử lý",
    "3": "Đã vận chuyển",
    "4": "Đã giao hàng",
    "5": "Hủy đơn",
  };

  @override
  void onInit() {
    super.onInit();
    orderId = Get.parameters['idOrder'].toString();
    getAddress();
    getOrderItem();
    getOrderInfo();
    update();
  }

  ///
  ///get order item
  ///
  void getOrderItem() {
    orderItemProvider.findByIdOrder(
        page: 1,
        limit: 100,
        idOrder: orderId.toString(),
        onSuccess: (value) {
          orderItemList = value;
          getPrice();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///get order info
  ///
  void getOrderInfo() {
    orderProvider.find(
        id: orderId.toString(),
        onSuccess: (value) {
          orderModel = value;
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///convert datetime
  ///
  String convertDateTime(String orderDate) {
    final loadedTime = DateConverter.isoStringToLocalDateHMS(
        orderDate.replaceAll("T", " ").substring(0, orderDate.length - 1));
    return loadedTime;
  }

  ///
  ///get price
  ///
  void getPrice() {
    for (var i = 0; i < orderItemList.length; i++) {
      price = int.parse(orderItemList[i].quantity.toString()) *
          int.parse(orderItemList[i].idProduct!.prices.toString());
    }
    isLoading = false;
    update();
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

  // void onHistoryClick() {
  //   Get.toNamed(AppRoutes.HISTORY);
  // }

}
