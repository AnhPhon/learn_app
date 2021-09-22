// ignore_for_file: type_annotate_public_apis

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/register/register_page_3.dart';

typedef Ham = void Function(int);

class RegisterController extends GetxController {
  final Map<String, TextEditingController> controllers = {
    "magioithieu": TextEditingController(),
    "taikhoan": TextEditingController(),
    "matkhau": TextEditingController(),
    "xacnhanmatkhau": TextEditingController(),
    "sodienthoai": TextEditingController(),
    "hoten": TextEditingController(),
    "cmnd": TextEditingController(),
    "ngaycap": TextEditingController(),
    "noicap": TextEditingController(),
    "nghenghiep": TextEditingController(),
    "diachithuongtru": TextEditingController(),
    "diachitlienlac": TextEditingController(),
  };

  final List<Item> items = [
    Item(
        url: Images.sp1,
        amount: 10000000,
        title: "Sản phẩm 1",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 183000,
        title: "Sản phẩm 2",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 250000,
        title: "Sản phẩm 3",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 250000,
        title: "Sản phẩm 4",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 652000,
        title: "Sản phẩm 5",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 29000,
        title: "Sản phẩm 6",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 132000,
        title: "Sản phẩm 7",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 2500000,
        title: "Sản phẩm 8",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 29000,
        title: "Sản phẩm 9",
        isChoose: false,
        quality: 1),
    Item(
        url: Images.sp1,
        amount: 29000,
        title: "Sản phẩm 10",
        isChoose: false,
        quality: 1),
  ];

  String? gender;

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

  var qualityProduct = 1.obs;

  void incrementQuality() {
    qualityProduct += 1;
    update();
  }

  void decrementQuality() {
    if (qualityProduct > 1) {
      qualityProduct -= 1;
    }
    update();
  }

  // It is mandatory initialize with one value from listType
  final selected = "1".obs;

  List<int> orderList = [];

  int sum = 0;

  bool isMaGioiThieuValid() {
    return controllers["magioithieu"]!.text.contains(RegExp(r"^ytp(\d{4,})"));
  }

  void accept(int index) {
    if (items[index].isChoose == false) {
      orderList.add(index);
    }
    items[index].isChoose = true;
    items[index].quality = qualityProduct.value;
    update();
  }

  void cancel(int index) {
    sum -= items[index].amount * items[index].quality;
    items[index].isChoose = false;
    items[index].quality = 1;
    orderList.remove(index);
    update();
  }

  // void addOrder(Item item) {
  //   orderList.add(item);
  // }

  void countTotal(int amout) {
    sum += amout * qualityProduct.value;
    update();
  }

  void removeProduct() {}

  // ignore: use_setters_to_change_properties
  void setSelected(String? value) {
    gender = value;
    update();
  }

  // ignore: always_declare_return_types
  Ham? them(int val) {
    sum += val;
    update();
  }
}
