import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_condition_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class PaymentController extends GetxController {
  GetIt sl = GetIt.instance;

  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();

  bool isLoadingMore = false;
  // image picker
  File? image;

  // quanlity product
  RxInt qualityProduct = 1.obs;

  // It is mandatory initialize with one value from listType
  List<int> orderList = [];

  int sum = 0;

  @override
  void onInit() {
    super.onInit();
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
  void onBtnFinishTap(
    BuildContext context,
    UserModel user,
    List<ProductConditionModel> items,
  ) {
    if (image != null) {
      EasyLoading.show(status: 'loading...');
      imageProvider.add(
        file: image!,
        onSuccess: (image) {
          print('link image ${image.data}');

          userProvider.genUsername(onSuccess: (genModel) {
            user.paymentProofImage = image.data;
            user.username = genModel.username;
            userProvider.add(
              data: user,
              onSuccess: (userModel) {
                print("User added");

                final OrderModel order = OrderModel(
                  idUser: userModel.id,
                  address: userModel.address,
                  idDistrict: '1',
                  idProvince: '1',
                  idWarehouse: '1',
                  imagePayment: image.data,
                  statusOrder: '1',
                  statusPayment: '1',
                  totalPrice: getSum(context, items),
                  userAccept: userModel.idUser,
                  description: 'Đơn hàng mới',
                  discountPrice: "0",
                );

                orderProvider.add(
                  data: order,
                  onSuccess: (model) {
                    // add Order Item To database
                    _addOrderItemToDB(model.id!, items);

                    Get.offAllNamed(AppRoutes.LOGIN);

                    EasyLoading.dismiss();
                    showAnimatedDialog(
                      context,
                      const MyDialog(
                        icon: Icons.check,
                        title: "Hoàn tất",
                        description: "Đợi admin active",
                      ),
                      dismissible: false,
                      isFlip: true,
                    );
                  },
                  onError: (error) {
                    print(error);
                  },
                );
              },
              onError: (error) {
                print(error);
              },
            );
          }, onError: (error) {
            print(error);
          });
        },
        onError: (error) {
          print(error);
        },
      );
    } else {
      _showSnakebar(
        "Upload hình lỗi",
        "Bạn cần phải bổ sung hình trước khi thanh toán",
        2,
      );
    }
  }

  ///
  /// addToDB
  ///
  void _addOrderItemToDB(String orderId, List<ProductConditionModel> items) {
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
          },
        );

        print("Order item added");
      }
    });
  }

  String getSum(BuildContext context, List<ProductConditionModel> items) {
    return PriceConverter.convertPrice(context, sumCalculator(items));
  }

  double sumCalculator(List<ProductConditionModel> items) {
    int sum = 0;
    items.forEach((element) {
      sum += element.quality * element.amount;
    });
    return sum.toDouble();
  }

  ///
  /// show snackbar
  ///
  void _showSnakebar(String title, String message, int seconds) {
    Get.snackbar(
      title, // title
      message, // message
      backgroundColor: Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: seconds),
    );
  }
}
