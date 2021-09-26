import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:intl/intl.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'information_user_controller.dart';

class InformationUserPage extends GetView<InformationUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().customAppBar(title: "Thông tin cá nhân"),
      body: SingleChildScrollView(
          child: GetBuilder<InformationUserController>(
              init: InformationUserController(),
              builder: (InformationUserController controller) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      // logo
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.03)),
                          child: Image.asset(Images.logo_image)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_DEFAULT,
                            right: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          children: [
                            // Mã giới thiệu
                            _inputMaGioiThieu(context, "Mã giới thiệu",
                                controller.textEditControllers["magioithieu"]!),

                            // Tài khoản
                            // _normalInputWidget(
                            //     context,
                            //     "Tài khoản",
                            //     controller.textEditControllers["taikhoan"]!,
                            //     TextInputType.text),

                            // Mất khẩu
                            _passwordInputWidget(
                                context,
                                "Mật khẩu",
                                controller.textEditControllers["matkhau"]!,
                                TextInputType.visiblePassword),

                            // Xác nhận mật khẩu
                            _passwordInputWidget(
                                context,
                                "Xác nhận mật khẩu",
                                controller
                                    .textEditControllers["xacnhanmatkhau"]!,
                                TextInputType.visiblePassword),

                            // Số điện thoại
                            _normalInputWidget(
                                context,
                                "Số điện thoại",
                                controller.textEditControllers["sodienthoai"]!,
                                TextInputType.number),

                            // Mã giới thiệu
                            _normalInputWidget(
                                context,
                                "Họ và tên",
                                controller.textEditControllers["hoten"]!,
                                TextInputType.text),

                            // gender
                            _genderSelectionWidget(context, controller),

                            // Ngày sinh
                            _dateTimePickNgaySinh(context),

                            // cmnd
                            _normalInputWidget(
                                context,
                                "Số chứng minh nhân dân",
                                controller.textEditControllers["cmnd"]!,
                                TextInputType.number),

                            // ngày cấp
                            _dateTimePickNgayCap(context),

                            // Nơi cấp
                            _normalInputWidget(
                                context,
                                "Nơi cấp",
                                controller.textEditControllers["noicap"]!,
                                TextInputType.text),

                            // mặt trước cmnd
                            _uploadCmndFront(context),

                            // mặt sau cmnd
                            _uploadCmndBack(context),

                            // Nghề nghiệp
                            _normalInputWidget(
                                context,
                                "Nghề nghiệp",
                                controller.textEditControllers["nghenghiep"]!,
                                TextInputType.text),

                            // Địa chỉ thường trú
                            _normalInputWidget(
                                context,
                                "Địa chỉ thường trú",
                                controller
                                    .textEditControllers["diachithuongtru"]!,
                                TextInputType.text),

                            // Địa chỉ liên lạc
                            _addressInputWidget(
                                context,
                                "Địa chỉ liên lạc",
                                controller
                                    .textEditControllers["diachitlienlac"]!,
                                TextInputType.text),

                            // tiếp tục button
                            _buttonContinue(context),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }

  ///
  /// input ma gioi thieu
  ///
  Widget _inputMaGioiThieu(BuildContext context, String? label,
      TextEditingController editTextcontroller) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        textInputAction: TextInputAction.next,
        textAlignVertical: TextAlignVertical.center,
        controller: editTextcontroller,
        focusNode: controller.focusNodeMaGioiThieu,
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
  /// input widget
  ///
  Widget _normalInputWidget(BuildContext context, String? label,
      TextEditingController controllers, TextInputType extInputType) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        textInputAction: TextInputAction.next,
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
  /// input widget
  ///
  Widget _passwordInputWidget(BuildContext context, String? label,
      TextEditingController controllers, TextInputType extInputType) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
        textInputAction: TextInputAction.next,
        textAlignVertical: TextAlignVertical.center,
        controller: controllers,
        keyboardType: extInputType,
        cursorColor: ColorResources.PRIMARY,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
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
  ///  address input widget
  ///
  Widget _addressInputWidget(BuildContext context, String? label,
      TextEditingController controllers, TextInputType extInputType) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.025)),
      child: TextField(
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
  /// select gender
  ///
  Widget _genderSelectionWidget(BuildContext context, controllers) {
    final List<String> genderOptions = ["Nam", "Nữ"]; 

    return DropDownButton1(
      hint: "Giới tính",
      value: controller.gender,
      onChanged: (newValue) => controller.onGenderChange(newValue!),
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
          initialDate: DateTime(1990),
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
        ).then((value) => controller.onNgaySinhChange(value));
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
              controller.ngaySinh.toString(),
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
          initialDate: DateTime(1990),
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
        ).then((value) => controller.onNgayCapChange(value));
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
              controller.ngayCap.toString(),
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
  /// upload cmnd front
  ///
  Widget _uploadCmndFront(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.05),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tải lên CMND/CCCD mặt trước",
                style: Dimensions.fontSizeStyle16w600()
                    .copyWith(color: ColorResources.BLACK),
              ),
              Text(
                "*",
                style: Dimensions.fontSizeStyle16w600()
                    .copyWith(color: ColorResources.RED),
              ),
            ],
          ),

          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),

          // hình ảnh thanh toán
          GestureDetector(
            onTap: () => controller.onCmndFrontPicker(),
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.382),
              width: DeviceUtils.getScaledSize(context, 0.509),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(
                      context, controller.cmndFrontFile != null ? 0 : 0.101)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.cmndFrontFile != null
                    ? null
                    : Border.all(width: 2, color: Colors.grey),
              ),
              child: controller.cmndFrontFile != null
                  ? Image.file(
                      controller.cmndFrontFile!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/bill.png",
                          height: 50,
                          color: Colors.grey,
                        ),
                        Text(
                          "Bấm vào đây để tải lên",
                          textAlign: TextAlign.center,
                          style: Dimensions.fontSizeStyle14w600()
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// upload cmnd back
  ///
  Widget _uploadCmndBack(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.05),
          vertical: DeviceUtils.getScaledSize(context, 0.03)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Tải lên CMND/CCCD mặt sau",
                style: Dimensions.fontSizeStyle16w600()
                    .copyWith(color: ColorResources.BLACK),
              ),
              Text(
                "*",
                style: Dimensions.fontSizeStyle16w600()
                    .copyWith(color: ColorResources.RED),
              ),
            ],
          ),

          SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),

          // hình ảnh thanh toán
          GestureDetector(
            onTap: () => controller.onCmndBackPicker(),
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.382),
              width: DeviceUtils.getScaledSize(context, 0.509),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(
                      context, controller.cmndBackFile != null ? 0 : 0.101)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.cmndBackFile != null
                    ? null
                    : Border.all(width: 2, color: Colors.grey),
              ),
              child: controller.cmndBackFile != null
                  ? Image.file(
                      controller.cmndBackFile!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/bill.png",
                          height: 50,
                          color: Colors.grey,
                        ),
                        Text(
                          "Bấm vào đây để tải lên",
                          textAlign: TextAlign.center,
                          style: Dimensions.fontSizeStyle14w600()
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// button tiếp tục
  ///
  Widget _buttonContinue(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onBtnContinueClick(),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.035)),
        padding: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledSize(context, 0.035),
            horizontal: DeviceUtils.getScaledSize(context, 0.03)),
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
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
