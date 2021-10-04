import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/home/home_controller.dart';

class V1HomePage extends GetView<V1HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1HomeController>(
        init: V1HomeController(),
        builder: (controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Trang chủ"),
                GestureDetector(
                  onTap: () => controller.onClickFormManagementPage(),
                  child: const Text("Quản lý đơn tạo",
                      style: TextStyle(
                        color: ColorResources.LIGHT_SKY_BLUE,
                        decoration: TextDecoration.underline,
                      )),
                ),
              ],
            ),
          );
        });
  }
}
