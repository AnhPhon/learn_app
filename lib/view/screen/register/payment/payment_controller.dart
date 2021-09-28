import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/register/register_page_3.dart';

class PaymentController extends GetxController {
  GetIt sl = GetIt.instance;

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();

  final homeController = Get.put(HomeController());
  final categoriesController = Get.put(CategoriesController());

  bool isLoadingMore = false;
  // image picker
  File? image;

  // quanlity product
  RxInt qualityProduct = 1.obs;

  // It is mandatory initialize with one value from listType
  List<int> orderList = [];

  int sum = 0;

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
    print("Order added");
  }

  ///
  /// addToDB
  ///
  void addToDB(String orderId, List<Item> items) {
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

        print("Order item added");
      }
    });
  }

  ///
  /// upload image
  ///
  void uploadImage(BuildContext context) {
    imageProvider.add(
      file: image!,
      onSuccess: (image) {
        print('link image ${image.data}');
      },
      onError: (error) {
        print(error);
        update();
      },
    );
  }

  void userAdd(UserModel user) {
    userProvider.add(
        data: user,
        onSuccess: (value) {
          print("User added");
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  void btnFinish(
    BuildContext context,
    UserModel user,
    OrderModel order,
    List<Item> items,
  ) {
    uploadImage(context);

    print(user);
    userAdd(user);

    createOrder(order);

    sl.get<SharedPreferenceHelper>().orderId.then((orderId) {
      addToDB(orderId!, items);
    });

    Get.offNamed(AppRoutes.LOGIN);

    showAnimatedDialog(
        context,
        const MyDialog(
          icon: Icons.check,
          title: "Hoàn tất",
          description: "Đợi admin active",
        ),
        dismissible: false,
        isFlip: true);
  }
}
