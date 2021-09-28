import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/image_model.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/order_item_response_model.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class CheckoutController extends GetxController {
  GetIt sl = GetIt.instance;
  File? image;
  ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();
  ImageUpdateModel? imageUpdateModel;

  UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserModel? userModel;

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  List<OrderItemResponseModel> selectedProductList = [];

  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  int price = 0;

  bool isLoading = true;
  bool isLoadingImage = false;

  String? orderId;
  String? address;
  String? provinceId;
  String? districtId;
  String? idUser;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value) => idUser = value);
    loadSelectedProduct();
    getValue();
  }

  ///
  ///load selected product
  ///
  void loadSelectedProduct() {
    sl
        .get<SharedPreferenceHelper>()
        .orderId
        .then((value) => orderItemProvider.findByIdOrder(
            page: 1,
            limit: 100,
            idOrder: Get.parameters['idOrder'].toString(),
            onSuccess: (value) {
              selectedProductList = value;
              calculatorPrice();
              isLoading = false;
              update();
            },
            onError: (error) {
              print(error);
              update();
            }));
  }

  ///
  ///calculator price
  ///
  void calculatorPrice() {
    for (var i = 0; i < selectedProductList.length; i++) {
      price = int.parse(selectedProductList[i].quantity!) *
          int.parse(selectedProductList[i].idProduct!.prices!);
      price += price;
    }
    update();
  }

  ///
  ///pick image
  ///
  Future pickImage() async {
    isLoadingImage = true;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      uploadImage();
      isLoadingImage = false;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage() {
    imageProvider.add(
        file: image!,
        onSuccess: (image) {
          imageUpdateModel = image;
          print(imageUpdateModel!.data);
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  ///
  ///on Done
  ///
  void onClickDoneBtn(
    BuildContext context,
  ) {
    if (image != null) {
      orderProvider.update(
          data: OrderModel(
              id: orderId,
              idUser: idUser,
              statusOrder: "1",
              statusPayment: "2",
              description: "đây là nội dung",
              address: address,
              idDistrict: districtId,
              idProvince: provinceId,
              discountPrice: "0",
              idWarehouse: "614457d87fee3b5dc8c1c75e",
              userAccept: "614748250c57f118c4a40689",
              totalPrice: price.toString(),
              imagePayment: imageUpdateModel!.data),
          onSuccess: (value) {
            Get.offAllNamed(AppRoutes.DASHBOARD);
            sl.get<SharedPreferenceHelper>().removeOrderId();
            showAnimatedDialog(
                context,
                const MyDialog(
                  icon: Icons.check,
                  title: "Hoàn tất",
                  description: "Đặt hàng thành công",
                ),
                dismissible: false,
                isFlip: true);
            update();
          },
          onError: (error) {
            print(error);
            update();
          });
    } else {
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
  }

  ///
  ///get value from SharedPreferenceHelper
  ///
  void getValue() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) => orderId = value!);
    sl.get<SharedPreferenceHelper>().address.then((value) => address = value!);
    sl
        .get<SharedPreferenceHelper>()
        .provinceId
        .then((value) => provinceId = value!);
    sl
        .get<SharedPreferenceHelper>()
        .districtId
        .then((value) => districtId = value!);
    update();
  }
}
