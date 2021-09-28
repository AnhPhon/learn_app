import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/product_condition_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/register/payment/payment_page.dart';

class OrderConditionController extends GetxController {
  GetIt sl = GetIt.instance;

  final OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  final String notificateValidMessage =
      "Với việc đăng ký tài khoản lần đầu, bạn được tặng voucher giảm 25% tổng giá trị đơn hàng. Để đăng ký tài khoản bạn phải thực hiện mua đơn hàng trị giá ít nhất 2,500,000 đ.";
  final String twoFivePercent =
      "Lưu ý: Hoá đơn sau khi trừ 25% phải lớn hơn hoặc bằng 2,500,000 đ";
  List<ProductModel> productList = [];
  List<OrderItemModel> orderItemList = [];
  List<ProductConditionModel> items = [];

  // It is mandatory initialize with one value from listType
  List<ProductConditionModel> orderList = [];
  int sum = 0;

  @override
  void onInit() {
    loadDonHangDieuKien();

    super.onInit();
  }

  ///
  /// set selected product
  ///
  void accept(int index) {
    // kiếm tra 
    if (items[index].isChoose == false) {
      items[index].isChoose = true;
      items[index].quality = qualityProduct.value;
      orderList.add(items[index]);
    } else {
      sum -= items[index].quality * items[index].amount;
      for (int i = 0; i < orderList.length; i++) {
        if (orderList[i].title == items[index].title) {
          orderList[i].quality = qualityProduct.value;
        }
      }
    }

    update();
  }

  ///
  /// undselected product
  ///
  void cancel(int index) {
    sum -= items[index].amount * items[index].quality;
    items[index].isChoose = false;
    items[index].quality = 1;
    orderList.remove(items[index]);
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
  ///loadDonHangDieuKien
  ///
  void loadDonHangDieuKien() {
    productProvider.paginate(
      page: 1,
      limit: 20,
      filter: "&type=1",
      onSuccess: (value) {
        items = value
            .map((ProductModel model) => ProductConditionModel(
                  id: model.id!,
                  url: model.thumbnail.toString(),
                  amount: int.parse(model.prriceOrigin!),
                  title: model.name!,
                  isChoose: false,
                  quality: 1,
                ))
            .toList();
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
  void btnContinue(
    BuildContext context,
    UserModel user,
  ) {
    final double money = sum * .75;
    final bool moneyValid = money > 2500000;
    if (moneyValid) {
      // Thành công
      Get.to(PaymentPage(
        user: user,
        items: orderList,
      ));
    } else {
      faildNotification(context, money);
    }
  }
}
