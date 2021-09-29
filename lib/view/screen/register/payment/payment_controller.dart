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

      // image provider
      imageProvider.add(
        file: image!,
        onSuccess: (image) {
          print('link image ${image.data}');

          // gen username
          userProvider.genUsername(onSuccess: (genModel) {
            user.paymentProofImage = image.data;
            user.username = genModel.username;

            // add api user provider
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
                  totalPrice: convertSum(context, items),
                  userAccept: userModel.idUser,
                  description: 'Đơn hàng mới',
                  discountPrice: "0",
                );

                // add api order provider
                orderProvider.add(
                  data: order,
                  onSuccess: (model) {
                    // add Order Item To database
                    _addOrderItemToDB(model.id!, items);

                    Get.back();
                    Get.back();
                    Get.back();

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
  /// _add order item to database
  ///
  void _addOrderItemToDB(String orderId, List<ProductConditionModel> items) {
    // duyệt các sản phẩm
    items.forEach((element) {
      final OrderItemModel model = OrderItemModel(
        idOrder: orderId,
        idProduct: element.id,
        price: element.amount.toString(),
        quantity: element.quality.toString(),
      );

      // add api của order item
      orderItemProvider.add(
        data: model,
        onSuccess: (value) {},
        onError: (error) {
          print(error);
        },
      );

      print("Order item added");
    });
  }

  ///
  /// convert sum number to sum string
  ///
  String convertSum(BuildContext context, List<ProductConditionModel> items) {
    return PriceConverter.convertPrice(context, sumCalculator(items));
  }

  ///
  /// tính tổng tiền
  ///
  double sumCalculator(List<ProductConditionModel> items) {
    int sum = 0;

    // tổng (số lượng và đơn giá) của các sản phẩm
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
      backgroundColor: const Color(0xffFFEBEE),
      icon: const Icon(Icons.error_outline),
      shouldIconPulse: true,
      isDismissible: true,
      duration: Duration(seconds: seconds),
    );
  }
}
