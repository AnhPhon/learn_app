import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/register/register_controller.dart';
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

  List<int> orderList = [];

  int sum = 0;

  void countTotal(int amout) {
    sum += amout * qualityProduct.value;
    update();
  }

  Ham? them(int val) {
    sum += val;
    update();
  }
}
