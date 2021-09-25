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
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/upload-image.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/register/register_page_3.dart';

typedef Ham = void Function(int);

class RegisterController extends GetxController {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  final ImageUpdateProvider imageProvider = GetIt.I.get<ImageUpdateProvider>();

  final homeController = Get.put(HomeController());
  final categoriesController = Get.put(CategoriesController());

  GetIt sl = GetIt.instance;

  List<ProductModel> productList = [];
  List<OrderItemModel> orderItemList = [];
  bool isLoadingMore = false;
  OrderModel? orderModel;

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

  String url = "";

  @override
  void onInit() {
    loadDonHangDieuKien();
    super.onInit();
  }

  String infoBank(
      {required String stk,
      required String ctk,
      required String tenNganHang,
      required String chiNhanh}) {
    return "Thông tin tài khoản\nSố tài khoản: $stk\nTên chủ tài khoản: $ctk\nTên ngân hàng: $tenNganHang\nChi nhánh $chiNhanh";
  }

  List<Item> items = [];

  //value dropdown
  String? gender;

  //image picker
  File? image;
  // String? imagePath;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      // imagePath = image.path;
      this.image = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  void updateImage() {
    sl.get<SharedPreferenceHelper>().orderId.then((value) {
      final String orderId = value!;
      orderProvider.find(
        id: orderId,
        onSuccess: (model) {
          final OrderModel tempModel = model;

          if (image != null) {
            imageProvider.add(
                data: image!,
                onSuccess: (image) {
                  print(image);
                  tempModel.imagePayment = image.url;
                  print(tempModel.haveIDtoJson());
                  orderProvider.update(
                    data: tempModel,
                    onSuccess: (model) {
                      print("success updated");
                      update();
                    },
                    onError: (error) {},
                  );
                },
                onError: (error) {
                  print(error);
                  update();
                });
          }
        },
        onError: (error) {
          print(error);
          update();
        },
      );
    });
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

  void createUser(UserModel model) {
    userProvider.add(
      data: model,
      onSuccess: (model) {
        update();
      },
      onError: (error) {
        print(error);
        update();
      },
    );
  }

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

  void addToDB(String orderId) {
    items.forEach((element) {
      if (element.isChoose == true) {
        OrderItemModel model = OrderItemModel(
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
                    url: Images.sp1,
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
        });
  }
}
