import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/register/register_page_3.dart';

class OrderConditionController extends GetxController {
  GetIt sl = GetIt.instance;

  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  final homeController = Get.put(HomeController());
  final categoriesController = Get.put(CategoriesController());

  final String notificateValidMessage =
      "Với việc đăng ký tài khoản lần đầu, bạn được tặng voucher giảm 25% tổng giá trị đơn hàng. Để đăng ký tài khoản bạn phải thực hiện mua đơn hàng trị giá ít nhất 2,500,000 đ.";
  final String twoFivePercent =
      "Lưu ý: Hoá đơn sau khi trừ 25% phải lớn hơn hoặc bằng 2,500,000 đ";
  List<ProductModel> productList = [];
  List<OrderItemModel> orderItemList = [];
  bool isLoadingMore = false;
  OrderModel? orderModel;

  // Kiểm tra sản phẩm có trong cart
  bool isHave = false;

  String url = "";

  List<Item> items = [];

  @override
  void onInit() {
    loadDonHangDieuKien();
    super.onInit();
  }

  // It is mandatory initialize with one value from listType
  List<int> orderList = [];
  int sum = 0;

  ///
  /// set selected product
  ///
  void accept(int index) {
    if (items[index].isChoose == false) {
      orderList.add(index);
    }
    items[index].isChoose = true;
    items[index].quality = qualityProduct.value;
    update();
  }

  ///
  /// undselected product
  ///
  void cancel(int index) {
    sum -= items[index].amount * items[index].quality;
    items[index].isChoose = false;
    items[index].quality = 1;
    orderList.remove(index);
    update();
  }

  ///
  /// total price
  ///
  void countTotal(int amout) {
    sum += amout * qualityProduct.value;
    update();
  }

  ///
  /// createOrder
  ///
  void createOrder(OrderModel orderModel) {
    orderProvider.add(
      data: orderModel,
      onSuccess: (model) {
        final GetIt sl = GetIt.instance;
        sl.get<SharedPreferenceHelper>().saveOrderId(model.id!);
        update();
      },
      onError: (error) {
        print(error);
        update();
      },
    );
  }

  ///
  /// faildNotification
  ///
  void faildNotification(BuildContext context, double money) {
    Get.snackbar(
      "Đăng ký thất bại",
      "Hoá đơn hiện tại là ${PriceConverter.convertPrice(context, money)} đang thiếu ${PriceConverter.convertPrice(context, 2500000 - money)}",
      colorText: ColorResources.RED,
      backgroundGradient: const LinearGradient(colors: [
        Color(0xffffb8b3),
        Color(0xffff9b94),
        Color(0xffffb8b3),
      ], begin: Alignment(2, -1), end: Alignment(1, 5)),
    );
  }

  ///
  /// addToDB
  ///
  void addToDB(String orderId) {
    items.forEach((element) {
      if (element.isChoose == true) {
        final OrderItemModel model = OrderItemModel(
          idOrder: orderId,
          idProduct: element.id,
          price: element.amount.toString(),
          quantity: element.quality.toString(),
        );

        orderItemProvider.add(
          data: model,
          onSuccess: (value) {},
          onError: (error) {
            print(error);
            update();
          },
        );
      }
    });
  }

  ///
  ///loadDonHangDieuKien
  ///
  void loadDonHangDieuKien() {
    productProvider.paginate(
      page: 1,
      limit: 20,
      filter: "&type=1",
      onSuccess: (value) {
        items = value
            .map((ProductModel model) => Item(
                  id: model.id!,
                  url: model.thumbnail.toString(),
                  amount: int.parse(model.prriceOrigin!),
                  title: model.name!,
                  isChoose: false,
                  quality: 1,
                ))
            .toList();

        value.forEach((ProductModel model) {
          print(model.resource);
        });

        print(items);
        update();
      },
      onError: (error) {
        print(error);
        update();
      },
    );
  }

  // quanlity product
  RxInt qualityProduct = 1.obs;

  ///
  /// + quanlity product
  ///
  void incrementQuality() {
    qualityProduct += 1;
    update();
  }

  ///
  /// - quanlity product
  ///
  void decrementQuality() {
    if (qualityProduct > 1) {
      qualityProduct -= 1;
    }
    update();
  }

  ///
  /// continue button
  ///
  void btnContinue(BuildContext context) {
    final double money = sum * .75;
    final bool moneyValid = money > 2500000;
    if (moneyValid) {
      // Thành công
      sl.get<SharedPreferenceHelper>().orderId.then((value) {
        final String orderId = value!;
        addToDB(orderId);

        Get.toNamed(AppRoutes.PAYMENT);
      });
    } else {
      faildNotification(context, money);
    }
  }
}
