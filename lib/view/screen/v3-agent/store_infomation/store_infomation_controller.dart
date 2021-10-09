import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class V3StoreInfomationController extends GetxController {
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

  String title = "Thông tin cửa hàng";

  @override
  void onInit() {
    super.onInit();
    // storeGroup = storeGroupList.first;
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
  ///on selected stor group
  ///
  void onProductSpecialGroup(ProductSpecial value) {
    productSpecial = value;
    update();
  }
}

class StoreGroup {
  String id;
  String name;
  StoreGroup({
    required this.id,
    required this.name,
  });
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
