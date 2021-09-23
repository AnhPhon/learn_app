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

  void setSelected(String value) {
    gender = value;
    print("ddax chonj: $gender");
    update();
  }

  Ham? them(int val) {
    sum += val;
    update();
  }
}
