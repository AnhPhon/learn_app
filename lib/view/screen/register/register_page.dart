// ignore_for_file: unnecessary_null_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
// dimensions
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';
import 'package:template/view/screen/register/register_page_2.dart';

import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
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
                    // Mã giới thiệu
                    _normalInputWidget(
                        "Mã giới thiệu", controllers["magioithieu"]!),

                    // Tài khoản
                    _normalInputWidget("Tài khoản", controllers["taikhoan"]!),

                    // Mất khẩu
                    _normalInputWidget("Mật khẩu", controllers["matkhau"]!),

                    // Xác nhận mật khẩu
                    _normalInputWidget(
                        "Xác nhận mật khẩu", controllers["xacnhanmatkhau"]!),

                    // Số điện thoại
                    _normalInputWidget(
                        "Số điện thoại", controllers["sodienthoai"]!),

                    // Mã giới thiệu
                    _normalInputWidget("Họ và tên", controllers["hoten"]!),

                    // gender
                    _genderSelectionWidget(controller),

                    // Ngày sinh
                    _dateTimePick(context),

                    // cmnd
                    _normalInputWidget(
                        "Số chứng minh nhân dân", controllers["cmnd"]!),

                    // ngày cấp
                    _dateTimePick(context),

                    // Nơi cấp
                    _normalInputWidget("Nơi cấp", controllers["noicap"]!),

                    // Nghề nghiệp
                    _normalInputWidget(
                        "Nghề nghiệp", controllers["nghenghiep"]!),

                    // Địa chỉ thường trú
                    _normalInputWidget(
                        "Địa chỉ thường trú", controllers["diachithuongtru"]!),

                    // Địa chỉ liên lạc
                    _normalInputWidget(
                        "Địa chỉ liên lạc", controllers["diachitlienlac"]!),

                    GestureDetector(
                      onTap: () {
                        Get.to(RegisterPage2());
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF59DC12),
                              Color(0xFF61A63C),
                            ],
                            begin: Alignment(0, -1),
                            end: Alignment(0, 1)
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: const Text(
                          "Tiếp tục",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
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

///
/// select
///
Widget _genderSelectionWidget(controller) {
  final List<Map<String, dynamic>> genderOptions = [
    {
      "index": "1",
      "name": "Nam",
    },
    {
      "index": "2",
      "name": "Nữ",
    }
  ];

  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    width: double.infinity,
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
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        value: controller.selected.value,
        items: genderOptions
            .map(
              (Map<String, dynamic> gender) => DropdownMenuItem(
                value: gender["index"],
                child: Text(gender["name"].toString()),
              ),
            )
            .toList(),
        onChanged: (newValue) {
          controller.setSelected(newValue);
        },
      ),
    ),
  );
}

///
/// datetimepick
///
Widget _dateTimePick(BuildContext context) {
  return GestureDetector(
    onTap: () {
      DatePicker.showDatePicker(
        context,
        minTime: DateTime(1900),
        maxTime: DateTime(2022),
        onChanged: (date) {},
        onConfirm: (date) {},
        currentTime: DateTime.now(),
        locale: LocaleType.vi,
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerLeft,
      width: double.infinity,
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
      child: const Text(
        '20/9/2021',
        style: TextStyle(color: Colors.grey),
      ),
    ),
  );
}
