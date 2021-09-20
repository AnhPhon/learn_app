// ignore_for_file: unnecessary_null_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

// dimensions
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'register_controller.dart';

class RegisterPage3 extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegisterController());
    final double width = MediaQuery.of(context).size.width;

    final List<List<Item>> items = [
      [
        Item(url: Images.sp1, amount: 10000000, title: "Sản phẩm 1"),
        Item(url: Images.sp1, amount: 183000, title: "Sản phẩm 2"),
      ],
      [
        Item(url: Images.sp1, amount: 250000, title: "Sản phẩm 3"),
        Item(url: Images.sp1, amount: 250000, title: "Sản phẩm 4"),
      ],
      [
        Item(url: Images.sp1, amount: 652000, title: "Sản phẩm 5"),
        Item(url: Images.sp1, amount: 29000, title: "Sản phẩm 6"),
      ],
      [
        Item(url: Images.sp1, amount: 132000, title: "Sản phẩm 7"),
        Item(url: Images.sp1, amount: 2500000, title: "Sản phẩm 8"),
      ],
      [
        Item(url: Images.sp1, amount: 29000, title: "Sản phẩm 9"),
        Item(url: Images.sp1, amount: 29000, title: "Sản phẩm 10"),
      ],
    ];

    // final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // Padding(
              //   padding:
              //       const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              //   child: Column(
              //     children: [
              //       Container(
              //         margin: const EdgeInsets.only(top: 80),
              //         child: Image.asset(Images.register_bg),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Column(
                  children: [
                    Column(
                        children: items.map((element) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              print("Hiện tại đang là ${controller.sum} đã thêm ${element[0].amount}");
                              controller.sum += element[0].amount;
                              print("Hiện tại: ${controller.sum}");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: width / 2 -
                                  Dimensions.PADDING_SIZE_EXTRA_LARGE,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Image.asset(element[0].url),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      element[0].title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${controller.moneyNormalize(element[0].amount*1, ",")}đ",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              print("Hiện tại đang là ${controller.sum} đã thêm ${element[1].amount}");
                              controller.sum += element[1].amount;
                              print("Hiện tại: ${controller.sum}");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: width / 2 -
                                  Dimensions.PADDING_SIZE_EXTRA_LARGE,
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Image.asset(element[1].url),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      element[1].title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "${controller.moneyNormalize(element[1].amount*1, ",")}đ",
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList()),
                    GestureDetector(
                      onTap: () {
                        final double money = controller.sum * .75;
                        final bool moneyValid = money > 2500000;
                        if(moneyValid) {
                          print("Hiện tại là ${controller.moneyNormalize(money, ",")} >= ${controller.moneyNormalize(2500000, ",")}");
                          print("Đăng ký thành công");

                          Get.toNamed(AppRoutes.DASHBOARD);
                        } else {
                          print("Hiện tại là ${controller.moneyNormalize(money, ",")} đang thiếu ${controller.moneyNormalize(2500000-money, ",")}");
                          print("Đăng ký thất bại");
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFF59DC12),
                            Color(0xFF61A63C),
                          ], begin: Alignment(0, -1), end: Alignment(0, 1)),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: const Text(
                          "Hoàn thành",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
Widget _normalInputWidget(String? label, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: const Color(0xFFEBEDEF), // set border color
        width: 3.0,
      ), // set border width
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ), // set rounded corner radius
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: label,
        border: InputBorder.none,
      ),
      controller: controller,
    ),
  );
}

class Item {
  String url;
  String title;
  int amount;

  Item({required this.url, required this.title, required this.amount});
}
