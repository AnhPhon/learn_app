// ignore_for_file: unnecessary_null_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

// dimensions
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';
import 'package:template/view/screen/register/register_page_3.dart';
import 'package:template/view/screen/register/register_page_4.dart';

import 'register_controller.dart';

class RegisterPage2 extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RegisterController());
    // final double width = MediaQuery.of(context).size.width;

    /**
     * Mã giới thiệu
     * Tài khoản
     * mật khẩu
     * xác nhận mật khẩu
     * Sô điện thoại
     * họ và tên
     * giới tính
     * Ngày sinh
     * Nơi sinh
     * Số CMND
     * Cấp ngày, tại
     * Nghề nghiệp
     * Địa chỉ thường trú
     * Địa chỉ liên lạc
     */

    final Map<String, TextEditingController> controllers = {
      "noidavadanglamviec": TextEditingController(),
      "kinhnghiemlamviec": TextEditingController(),
      "khanangnoitroinhat": TextEditingController(),
      "kinhnghiemlamcongtacvien": TextEditingController()
    };

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                      child: Image.asset(Images.register_bg),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Column(
                  children: [
                    // Nơi đã và đang làm việc
                    _normalInputWidget("Nơi đã và đang làm việc",
                        controllers["noidavadanglamviec"]!),

                    // Kinh nghiệm làm việc
                    _normalInputWidget("Kinh nghiệm làm việc",
                        controllers["kinhnghiemlamviec"]!),

                    // Khả năng nổi trội nhất
                    _normalInputWidget("Khả năng nổi trội nhất",
                        controllers["khanangnoitroinhat"]!),

                    // Kinh nghiệm làm công tác viên
                    _normalInputWidget("Kinh nghiệm làm công tác viên",
                        controllers["kinhnghiemlamcongtacvien"]!),

                    GestureDetector(
                      onTap: () {
                        Get.to(RegisterPage4());
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
                          "Tiếp tục",
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
