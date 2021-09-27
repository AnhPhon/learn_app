import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/response/product_response_model.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';
import 'package:template/view/screen/register/register_page_3.dart';

class CheckoutController extends GetxController {
  final List<Item> items = [
    // Item(
    //     url: Images.sp1,
    //     amount: 10000000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 5.0",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 183000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 2",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 250000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 3",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 250000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 4",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 652000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 5",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 29000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 6",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 132000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 7",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 2500000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 8",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 29000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 9",
    //     isChoose: false,
    //     quality: 1),
    // Item(
    //     url: Images.sp1,
    //     amount: 29000,
    //     title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 10",
    //     isChoose: false,
    //     quality: 1),
  ];
  GetIt sl = GetIt.instance;

  File? image;

  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  UserProvider userProvider = GetIt.I.get<UserProvider>();

  List<ProductResponse> selectedProductList = [];

  UserModel? userModel;

  int price = 0;

  bool isLoading = true;

  late final String orderId;
  late final String address;
  late final String provinceId;
  late final String districtId;

  @override
  void onInit() {
    super.onInit();
    loadSelectedProduct();
    getValue();
    getInfoUser();
  }

  ///
  ///load selected product
  ///
  void loadSelectedProduct() {
    sl
        .get<SharedPreferenceHelper>()
        .orderId
        .then((value) => productProvider.findByIdOrder(
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
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///on Done
  ///
  void onClickDoneBtn(BuildContext context) {
    if (image != null) {
      orderProvider.update(
          data: OrderModel(
              id: orderId,
              idUser: "614748250c57f118c4a40689",
              statusOrder: "1",
              statusPayment: "2",
              description: "đây là nội dung",
              address: userModel!.address,
              idDistrict: districtId,
              idProvince: provinceId,
              discountPrice: "0",
              idWarehouse: "614457d87fee3b5dc8c1c75e",
              userAccept: "614748250c57f118c4a40689",
              totalPrice: price.toString(),
              imagePayment:
                  "https://izisoft.s3.ap-southeast-1.amazonaws.com/p08yamamoto/1632467128649_217393826_152304257001167_594051930663616020_n.jpg"),
          onSuccess: (value) {
            Get.offNamed(AppRoutes.DASHBOARD);
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
    sl
        .get<SharedPreferenceHelper>()
        .address
        .then((value) => print("assress: $value"));
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

  ///
  ///get infomation users
  ///
  void getInfoUser() {
    userProvider.find(
        id: "614748250c57f118c4a40689",
        onSuccess: (value) {
          userModel = value;
          update();
        },
        onError: (error) {});
  }
}
