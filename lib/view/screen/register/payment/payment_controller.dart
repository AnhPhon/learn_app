import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/register/register_page_3.dart';

class PaymentController extends GetxController {
  GetIt sl = GetIt.instance;

  final OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();

  final homeController = Get.put(HomeController());
  final categoriesController = Get.put(CategoriesController());

  List<ProductModel> productList = [];
  List<OrderItemModel> orderItemList = [];
  bool isLoadingMore = false;
  OrderModel? orderModel;

  // Kiểm tra sản phẩm có trong cart
  bool isHave = false;

  List<Item> items = [];

  // value dropdown
  String? gender;

  // image picker
  File? image;

  // quanlity product
  RxInt qualityProduct = 1.obs;

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
  /// set selected dropdown
  ///
  void setSelected(String value) {
    gender = value;
    print("ddax chonj: $gender");
    update();
  }
  
  ///
  /// thêm vào giỏ hàng
  ///
  void addToCart({
    required String idOrder,
    required String idProduct,
    required String quanlity,
    required String price,
  }) {
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
  /// hoanTatFaild
  ///
  void hoanTatFaild() {
    Get.snackbar(
      "Thất bại",
      "Vui lòng tải lên hình ảnh thanh toán",
      colorText: ColorResources.RED,
      backgroundGradient: const LinearGradient(colors: [
        Color(0xffffb8b3),
        Color(0xffff9b94),
        Color(0xffffb8b3),
      ], begin: Alignment(2, -1), end: Alignment(1, 5)),
    );
  }

  ///
  /// pick image
  ///
  Future pickImage() async {
    try {
      final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picker == null) return;
      image = File(picker.path);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  /// upload image
  ///
  void uploadImage() {
    imageProvider.add(
        file: image!,
        onSuccess: (image) {
          print('link image ${image.data}');
        },
        onError: (error) {
          print(error);
          update();
        });
  }

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
}
