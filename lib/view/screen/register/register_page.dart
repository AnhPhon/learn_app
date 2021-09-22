// ignore_for_file: unnecessary_null_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
// dimensions
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/register/register_page_2.dart';
import 'package:template/view/screen/register/register_page_3.dart';

import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
//input ma gioi thieu
  Widget _inputMaGioiThieu(
      BuildContext context, String? label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        cursorColor: ColorResources.PRIMARY,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: DeviceUtils.getScaledSize(context, 0.025),
              vertical: DeviceUtils.getScaledSize(context, 0.038)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.PRIMARY)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.GREY)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.GREY)),
          hintText: label,
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

//input widget
  Widget _normalInputWidget(
      BuildContext context, String? label, TextEditingController controllers) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        enabled: controller.isMaGioiThieuValid(),
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.center,
        controller: controllers,
        cursorColor: ColorResources.PRIMARY,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
              horizontal: DeviceUtils.getScaledSize(context, 0.025),
              vertical: DeviceUtils.getScaledSize(context, 0.038)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.PRIMARY)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.GREY)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorResources.GREY)),
          hintText: label,
          filled: true,
          fillColor: Colors.transparent,

          // suffixIcon: Container(
          //   padding:
          //       EdgeInsets.only(right: DeviceUtils.getScaledSize(context, 0.025)),
          //   child: Icon(
          //     Icons.person,
          //     size: DeviceUtils.getScaledSize(context, 0.045),
          //     color: ColorResources.PRIMARY,
          //   ),
          // ),
        ),
      ),
    );
  }

  ///
  /// select
  ///
  Widget _genderSelectionWidget(BuildContext context, controllers) {
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

    return DropDownButton1(
      width: 0.5,
      hint: "Giới tính",
      value: controller.gender,
      onChanged: controller.setSelected,
      data: genderOptions
          .map((Map<String, dynamic> gender) => gender["name"].toString())
          .toList(),
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
        margin: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.025)),
        padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.025)),
        width: double.infinity,
        height: DeviceUtils.getScaledSize(context, 0.127),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: ColorResources.GREY, // set border color
          ), // set border width
          borderRadius: BorderRadius.circular(10), // set rounded corner radius
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateConverter.estimatedDate(DateTime.now()),
              style: const TextStyle(color: ColorResources.GREY),
            ),
            Icon(
              Icons.calendar_today,
              size: DeviceUtils.getScaledSize(context, 0.045),
              color: ColorResources.PRIMARY,
            ),
          ],
        ),
      ),
    );
  }

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

    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (RegisterController value) {
          final controllers = controller.controllers;

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(
                            DeviceUtils.getScaledSize(context, 0.063)),
                        child: Image.asset(Images.register_bg)),
                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
                    Padding(
                      padding: EdgeInsets.all(
                          DeviceUtils.getScaledSize(context, 0.063)),
                      child: Column(
                        children: [
                          // Mã giới thiệu
                          _inputMaGioiThieu(context, "Mã giới thiệu",
                              controllers["magioithieu"]!),

                          // Tài khoản
                          _normalInputWidget(
                              context, "Tài khoản", controllers["taikhoan"]!),

                          // Mất khẩu
                          _normalInputWidget(
                              context, "Mật khẩu", controllers["matkhau"]!),

                          // Xác nhận mật khẩu
                          _normalInputWidget(context, "Xác nhận mật khẩu",
                              controllers["xacnhanmatkhau"]!),

                          // Số điện thoại
                          _normalInputWidget(context, "Số điện thoại",
                              controllers["sodienthoai"]!),

                          // Mã giới thiệu
                          _normalInputWidget(
                              context, "Họ và tên", controllers["hoten"]!),

                          // gender
                          _genderSelectionWidget(context, controller),

                          // Ngày sinh
                          _dateTimePick(context),

                          // cmnd
                          _normalInputWidget(context, "Số chứng minh nhân dân",
                              controllers["cmnd"]!),

                          // ngày cấp
                          _dateTimePick(context),

                          // Nơi cấp
                          _normalInputWidget(
                              context, "Nơi cấp", controllers["noicap"]!),

                          // Nghề nghiệp
                          _normalInputWidget(context, "Nghề nghiệp",
                              controllers["nghenghiep"]!),

                          // Địa chỉ thường trú
                          _normalInputWidget(context, "Địa chỉ thường trú",
                              controllers["diachithuongtru"]!),

                          // Địa chỉ liên lạc
                          _normalInputWidget(context, "Địa chỉ liên lạc",
                              controllers["diachitlienlac"]!),

                          GestureDetector(
                            onTap: () {
                              Get.to(RegisterPage3());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: DeviceUtils.getScaledSize(
                                      context, 0.035)),
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      DeviceUtils.getScaledSize(context, 0.035),
                                  horizontal:
                                      DeviceUtils.getScaledSize(context, 0.03)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF61A63C),
                                    Color(0xFF61A63C),
                                    Color(0xFF61A63C),
                                  ],
                                ),
                              ),
                              child: const Text(
                                "Tiếp tục",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.all(10),
                            //   decoration: const BoxDecoration(
                            //     gradient: LinearGradient(colors: [
                            //       Color(0xFF59DC12),
                            //       Color(0xFF61A63C),
                            //     ], begin: Alignment(0, -1), end: Alignment(0, 1)),
                            //     borderRadius: BorderRadius.all(Radius.circular(30)),
                            //   ),
                            //   alignment: Alignment.center,
                            //   padding: const EdgeInsets.all(20),
                            //   width: double.infinity,
                            //   child: const Text(
                            //     "Tiếp tục",
                            //     style: TextStyle(color: Colors.white, fontSize: 18),
                            //   ),
                            // ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
