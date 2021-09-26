// ignore_for_file: unnecessary_null_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:intl/intl.dart';
// images
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
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
      BuildContext context, String? label, TextEditingController controllers,TextInputType extInputType) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        enabled: controller.isMaGioiThieuValid(),
        textInputAction: TextInputAction.done,
        textAlignVertical: TextAlignVertical.center,
        controller: controllers, 
        keyboardType: extInputType,
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

  ///
  /// select
  ///
  Widget _genderSelectionWidget(BuildContext context, controllers) {
    final List<String> genderOptions = ["Nam", "Nữ"];

    return DropDownButton1(
      hint: "Giới tính",
      value: controller.gender,
      onChanged: (newValue) {
        controller.setSelected(newValue!);
      },
      data: genderOptions,
    );
  }

  ///
  /// _dateTimePickNgaySinh
  ///
  Widget _dateTimePickNgaySinh(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          locale: const Locale("vi", "VI"),
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2022),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData().copyWith(
                primaryColor: ColorResources.PRIMARY,
                accentColor: ColorResources.PRIMARY,
                colorScheme:
                    const ColorScheme.light(primary: ColorResources.PRIMARY),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        ).then((value) {
          controller.ngaysinh = value;
          print(controller.ngaysinh);
        });
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
              DateFormat("dd MMMM yyyy", "vi").format(DateTime.now()),
              style: const TextStyle(color: Colors.grey),
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

  ///
  /// _dateTimePickNgayCap
  ///
  Widget _dateTimePickNgayCap(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          locale: const Locale("vi", "VI"),
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2022),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData().copyWith(
                primaryColor: ColorResources.PRIMARY,
                accentColor: ColorResources.PRIMARY,
                colorScheme:
                    const ColorScheme.light(primary: ColorResources.PRIMARY),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        ).then((value) {
          controller.ngaycap = value;
          print(controller.ngaycap);
        });
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
              'Ngày cấp',
              style: const TextStyle(color: Colors.grey),
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
            appBar: CustomAppBar().customAppBar(title: "Thông tin cá nhân"),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                DeviceUtils.getScaledSize(context, 0.03)),
                        child: Image.asset(Images.logo_image)),
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
                              context, "Tài khoản", controllers["taikhoan"]!, TextInputType.text),

                          // Mất khẩu
                          _normalInputWidget(
                              context, "Mật khẩu", controllers["matkhau"]!, TextInputType.visiblePassword),

                          // Xác nhận mật khẩu
                          _normalInputWidget(context, "Xác nhận mật khẩu",
                              controllers["xacnhanmatkhau"]!, TextInputType.visiblePassword),

                          // Số điện thoại
                          _normalInputWidget(context, "Số điện thoại",
                              controllers["sodienthoai"]!, TextInputType.number),

                          // Mã giới thiệu
                          _normalInputWidget(
                              context, "Họ và tên", controllers["hoten"]!, TextInputType.text),

                          // gender
                          _genderSelectionWidget(context, controller),

                          // Ngày sinh
                          _dateTimePickNgaySinh(context),

                          // cmnd
                          _normalInputWidget(context, "Số chứng minh nhân dân",
                              controllers["cmnd"]!, TextInputType.number),

                          // ngày cấp
                          _dateTimePickNgayCap(context),

                          // Nơi cấp
                          _normalInputWidget(
                              context, "Nơi cấp", controllers["noicap"]!, TextInputType.text),

                          // Nghề nghiệp
                          _normalInputWidget(context, "Nghề nghiệp",
                              controllers["nghenghiep"]!, TextInputType.text),

                          // Địa chỉ thường trú
                          _normalInputWidget(context, "Địa chỉ thường trú",
                              controllers["diachithuongtru"]!, TextInputType.text),

                          // Địa chỉ liên lạc
                          _normalInputWidget(context, "Địa chỉ liên lạc",
                              controllers["diachitlienlac"]!, TextInputType.text),

                          GestureDetector(
                            onTap: () {
                              // final String magioithieu =
                              //     controllers["magioithieu"]!.text;

                              final UserModel userModel = UserModel(
                                password: controllers["matkhau"]!.text,
                                idUser: "",
                                idRole: "",
                                idOptionalRole: "0",
                                fullname: controllers["hoten"]!.text,
                                username: controllers["taikhoan"]!.text,
                                sex: controller.gender ?? "",
                                avatar:
                                    "https://izisoft.s3.ap-southeast-1.amazonaws.com/p08yamamoto/1632456310...",
                                born: DateConverter.estimatedDate(
                                    controller.ngaysinh!),
                                phone: controllers["sodienthoai"]!.text,
                                address: controllers["diachithuongtru"]!.text,
                                citizenIdentification:  controllers["cmnd"]!.text,
                                status: "1",
                                imageCitizenIdentification:
                                    "https://izisoft.s3.ap-southeast-1.amazonaws.com/p08yamamoto/1632455894...",
                                imageCitizenIdentification1:
                                    "https://izisoft.s3.ap-southeast-1.amazonaws.com/p08yamamoto/1632455901...",
                                paymentProofImage: "",
                              );

                              // cho phép tạo
                              bool allowCreate = false;
                              if (allowCreate == true) {
                                controller.createUser(userModel);
                              }
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
