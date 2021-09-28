import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/order_item_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/product_condition_model.dart';
import 'package:template/data/model/body/user_model.dart';
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
                  address: '123',
                  idDistrict: '1',
                  idProvince: '1',
                  idWarehouse: '1',
                  imagePayment: image.data,
                  statusOrder: '1',
                  statusPayment: '1',
                  totalPrice: '0',
                  userAccept: userModel.idUser,
                  description: 'ABC',
                  discountPrice: "0");

              orderProvider.add(
                data: order,
                onSuccess: (model) {
                  _addToDB(model.id!, items);
                  update();
                },
                onError: (error) {
                  print(error);
                  update();
                },
              );

              update();
            },
            onError: (error) {
              print(error);
            },
          );

          Get.offNamed(AppRoutes.LOGIN);

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
        }, onError: (error) {
          print(error);
        });
      },
      onError: (error) {
        print(error);
        update();
      },
    );
  }

  ///
  /// addToDB
  ///
  void _addToDB(String orderId, List<ProductConditionModel> items) {
    items.forEach((element) {
      if (element.isChoose == true) {
        print(element.id);
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
}
