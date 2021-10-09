import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class V3StoreInfomationController extends GetxController {
  //image
  File? image;
  List<File> taxImageList = [];

  //name of company
  final nameController = TextEditingController();
  //legal Representative
  final legalRepresentativeController = TextEditingController();
  //phone
  final phoneController = TextEditingController();
  //email
  final emailController = TextEditingController();
  //address
  final addressController = TextEditingController();
  //start time range
  final startController = TextEditingController();
  //end time range
  final endController = TextEditingController();
  //warehouse address
  final warehouseController = TextEditingController();

  //accept
  Map<String, String> boolAccept = {
    "0": "Không",
    "1": "Có",
  };
  String? acceptWork;

  //store group
  final storeGroupController = TextEditingController();
  StoreGroup? storeGroup;
  List<StoreGroup> storeGroupList = [
    StoreGroup(
        id: "${Random().nextInt(1000)}",
        name: "group ${Random().nextInt(100)}"),
    StoreGroup(
        id: "${Random().nextInt(1000)}",
        name: "group ${Random().nextInt(100)}"),
    StoreGroup(
        id: "${Random().nextInt(1000)}",
        name: "group ${Random().nextInt(100)}"),
  ];

  //product special
  final productSpecialController = TextEditingController();
  ProductSpecial? productSpecial;
  List<ProductSpecial> productSpecialList = [
    ProductSpecial(
        id: "${Random().nextInt(1000)}",
        name: "product ${Random().nextInt(100)}"),
    ProductSpecial(
        id: "${Random().nextInt(1000)}",
        name: "product ${Random().nextInt(100)}"),
    ProductSpecial(
        id: "${Random().nextInt(1000)}",
        name: "product ${Random().nextInt(100)}"),
  ];

  //province
  String? province;
  List<String> provinceList = [];
  //province
  String? district;
  List<String> districtList = [];
  //province
  String? ward;
  List<String> wardList = [];

  String title = "Thông tin cửa hàng";

  String note =
      "Nếu địa điểm kho hàng nằm ở vị trí khác (hoặc tỉnh khác) cửa hàng chính thì cập nhật thêm địa chỉ để tính toán cước vận chuyển";

  @override
  void onInit() {
    super.onInit();
    storeGroup = storeGroupList.first;
    productSpecial = productSpecialList.first;
  }

  ///
  ///on selected stor group
  ///
  void onSelectedStoreGroup(StoreGroup? value) {
    storeGroup = value;
    update();
  }

  ///
  ///on selected store group
  ///
  void onProductSpecialGroup(ProductSpecial value) {
    productSpecial = value;
    update();
  }

  ///
  ///on selected accept work
  ///
  void onSelectedAcceptWork(String? value) {
    acceptWork = value;
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
      taxImageList.add(imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }
}

class StoreGroup {
  String id;
  String name;
  StoreGroup({
    required this.id,
    required this.name,
  });
  @override
  String toString() {
    return name.toString();
  }
}

class ProductSpecial {
  String id;
  String name;
  ProductSpecial({
    required this.id,
    required this.name,
  });
  @override
  String toString() {
    return name.toString();
  }
}
