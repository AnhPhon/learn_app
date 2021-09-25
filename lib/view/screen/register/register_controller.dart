// ignore_for_file: type_annotate_public_apis

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
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/register/register_page_3.dart';

typedef Ham = void Function(int);

class RegisterController extends GetxController {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final homeController = Get.put(HomeController());
  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  GetIt sl = GetIt.instance;
  final categoriesController = Get.put(CategoriesController());
  List<ProductModel> productList = [];
  List<OrderItemModel> orderItemList = [];
  bool isLoadingMore = false;

  // Kiểm tra sản phẩm có trong cart
  bool isHave = false;

  final Map<String, TextEditingController> controllers = {
    "magioithieu": TextEditingController(),
    "taikhoan": TextEditingController(),
    "matkhau": TextEditingController(),
    "xacnhanmatkhau": TextEditingController(),
    "sodienthoai": TextEditingController(),
    "hoten": TextEditingController(),
    "cmnd": TextEditingController(),
    "noicap": TextEditingController(),
    "nghenghiep": TextEditingController(),
    "diachithuongtru": TextEditingController(),
    "diachitlienlac": TextEditingController(),
  };

  String? orderID;

  DateTime? ngaysinh = DateTime.now();
  DateTime? ngaycap = DateTime.now();

  String infoBank(
      {required String stk,
      required String ctk,
      required String tenNganHang,
      required String chiNhanh}) {
    return "Thông tin tài khoản\nSố tài khoản: $stk\nTên chủ tài khoản: $ctk\nTên ngân hàng: $tenNganHang\nChi nhánh $chiNhanh";
  }

  final List<Item> items = [
    Item(
        url: Images.sp1,
        amount: 10000000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 5.0",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 183000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 2",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 250000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 3",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 250000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 4",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 652000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 5",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 29000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 6",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 132000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 7",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 2500000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 8",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 29000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 9",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 29000,
        title: "DK VIÊN NÉN TIẾT KIỆM NHIÊN LIỆU YAMAMOTO 10",
        isChoose: false,
        quality: 1),
  ];

  //value dropdown
  String? gender;

  //image picker
  File? image;
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

  // quanlity product
  var qualityProduct = 1.obs;

  // + quanlity product
  void incrementQuality() {
    qualityProduct += 1;
    update();
  }

  // - quanlity product
  void decrementQuality() {
    if (qualityProduct > 1) {
      qualityProduct -= 1;
    }
    update();
  }

  // It is mandatory initialize with one value from listType

  List<int> orderList = [];

  int sum = 0;

  //set điều kiện nếu mã giới thiệu không đúng định dạng
  //thì không cho nhập các trường khác
  bool isMaGioiThieuValid() {
    return controllers["magioithieu"]!.text.contains(RegExp(r"^ytp(\d{4,})"));
  }

  // set selected product
  void accept(int index) {
    if (items[index].isChoose == false) {
      orderList.add(index);
    }
    items[index].isChoose = true;
    items[index].quality = qualityProduct.value;
    update();
  }

  // undselected product
  void cancel(int index) {
    sum -= items[index].amount * items[index].quality;
    items[index].isChoose = false;
    items[index].quality = 1;
    orderList.remove(index);
    update();
  }

  // total price
  void countTotal(int amout) {
    sum += amout * qualityProduct.value;
    update();
  }

  void removeProduct() {}

  // set selected dropdown
  void setSelected(String value) {
    gender = value;
    print("ddax chonj: $gender");
    update();
  }

  Ham? them(int val) {
    sum += val;
    update();
  }

  void createUser(Map<String, dynamic> json) {
    final UserModel model = UserModel.fromJson(json);
    userProvider.add(
        data: model,
        onSuccess: (model) {
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  void createOrder(Map<String, dynamic> json) {
    final OrderModel model = OrderModel.fromJson(json);
    orderProvider.add(
      data: model,
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

  //tạo id đơn hàng
  void order() {
    GetIt sl = GetIt.instance;

    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      if (value == null) {
        isHave = false;
        orderProvider.add(
            data: OrderModel(
                idUser: homeController.userModel.id,
                statusOrder: "1",
                statusPayment: "2",
                description: "đây là nội dung",
                address: "dia chi nha",
                idDistrict: "61435cf012594e54736dd6ca",
                idProvince: "61435cf012594e54736dd6ca",
                discountPrice: "0",
                idWarehouse: "614457d87fee3b5dc8c1c75e",
                userAccept: "614748250c57f118c4a40689",
                totalPrice: "0",
                imagePayment: "0"),
            onSuccess: (value) {
              sl.get<SharedPreferenceHelper>().saveOrderId(value.id.toString());
              update();
            },
            onError: (error) {
              print(error);
              update();
            });
      } else {
        final idOrder = value;
        final indexOrderItemList = orderItemList.indexWhere((element) =>
            element.idProduct == categoriesController.productWithId!.id);
        if (indexOrderItemList == -1) {
          isHave = false;
          getProductFromCart();
          update();
          print("indexOrderItemList: 0");
          addToCart(
              idOrder: idOrder,
              idProduct: categoriesController.productWithId!.id!,
              quanlity: "1",
              price: categoriesController.productWithId!.prices!);
        } else {
          print("indexOrderItemList: 1");
          isHave = true;
          update();
        }
      }
    });
  }

  //lấy sản phẩm trong giỏ hàng
  void getProductFromCart() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      if (value != null) {
        orderItemProvider.paginate(
            page: 1,
            limit: 100,
            filter: "&idOrder=$value",
            onSuccess: (value) {
              orderItemList = value;
              update();
            },
            onError: (error) {
              print(error);
              update();
            });
      }
    });
  }

  //thêm vào giỏ hàng
  void addToCart(
      {required String idOrder,
      required String idProduct,
      required String quanlity,
      required String price}) {
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
}
