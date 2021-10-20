import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/loai_tai_khoan_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/label.dart';

import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (RegisterController value) {
          return Scaffold(
              backgroundColor: const Color(0xffF6F6F7),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    // logo
                    _logoWidget(context),

                    // chọn loại tài khoản  và pháp lý
                    _loaiTaiKhoanWidget(context),

                    // tên doanh nghiệp
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Tên doanh nghiệp/đội trưởng/cá nhân",
                      hidden: false,
                      label: "Tên doanh nghiệp/đội trưởng/cá nhân",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Mã số thuế
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Mã số thuế",
                      hidden: false,
                      label: "Mã số thuế",
                      obligatory: false,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Họ và tên
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Họ và tên",
                      hidden: false,
                      label: "Họ và tên",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Ngày tháng năm sinh
                    TextFieldDate(
                      isDate: true,
                      allowEdit: true,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "dd-MM-yyyy",
                      label: "Ngày tháng năm sinh",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Giới tính
                    DropDownButton<LoaiTaiKhoanResponse>(
                      data: controller.loaiTaiKhoans,
                      obligatory: true,
                      onChanged: (value) =>
                          controller.onLoaiTaikhoanChange(value!),
                      value: controller.loaiTaiKhoan,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Giới tính",
                      hint: "Giới tính",
                    ),

                    // cmnd
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Số CMND/Căn cước",
                      hidden: false,
                      label: "Số CMND/Căn cước",
                      obligatory: true,
                      typeInput: TextInputType.number,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // ngày cấp
                    TextFieldDate(
                      isDate: true,
                      allowEdit: true,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "dd-MM-yyyy",
                      label: "Ngày cấp",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Nơi cấp
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Nơi cấp",
                      hidden: false,
                      label: "Nơi cấp",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Số điện thoại
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Số điện thoại",
                      hidden: false,
                      label: "Số điện thoại",
                      obligatory: true,
                      typeInput: TextInputType.number,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // email
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Nhập email",
                      hidden: false,
                      label: "Email",
                      obligatory: false,
                      typeInput: TextInputType.emailAddress,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Khu vực tham gia chọn nhiều
                    DropDownButton<LoaiTaiKhoanResponse>(
                      data: controller.loaiTaiKhoans,
                      obligatory: true,
                      onChanged: (value) =>
                          controller.onLoaiTaikhoanChange(value!),
                      value: controller.loaiTaiKhoan,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Khu vực tham gia chọn nhiều ",
                      hint: "Khu vực tham gia",
                    ),

                    // địa chỉ hiện tại
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Nhập địa chỉ hiện tại",
                      hidden: false,
                      label: "Địa chỉ hiện tại",
                      obligatory: false,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Tỉnh/TP
                    DropDownButton<LoaiTaiKhoanResponse>(
                      data: controller.loaiTaiKhoans,
                      obligatory: true,
                      onChanged: (value) =>
                          controller.onLoaiTaikhoanChange(value!),
                      value: controller.loaiTaiKhoan,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Tỉnh/TP",
                      hint: "Tỉnh/TP",
                    ),

                    // Quận/Huyện
                    DropDownButton<LoaiTaiKhoanResponse>(
                      data: controller.loaiTaiKhoans,
                      obligatory: true,
                      onChanged: (value) =>
                          controller.onLoaiTaikhoanChange(value!),
                      value: controller.loaiTaiKhoan,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Quận/Huyện",
                      hint: "Quận/Huyện",
                    ),

                    // Phường xã
                    DropDownButton<LoaiTaiKhoanResponse>(
                      data: controller.loaiTaiKhoans,
                      obligatory: true,
                      onChanged: (value) =>
                          controller.onLoaiTaikhoanChange(value!),
                      value: controller.loaiTaiKhoan,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Phường xã",
                      hint: "Phường xã",
                    ),

                    // Chỉ áp dụng cho thợ thầu
                    // Số lượng người
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Số lượng người",
                      hidden: false,
                      label: "Số lượng người",
                      obligatory: true,
                      typeInput: TextInputType.number,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Chuyên làm việc gì
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Chuyên làm việc gì",
                      hidden: false,
                      label: "Chuyên làm việc gì",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Giới thiệu năng lực, kinh nghiệm
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Giới thiệu năng lực, kinh nghiệm",
                      hidden: false,
                      label: "Giới thiệu năng lực, kinh nghiệm",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Bạn sẵn sàng làm việc ở những Tỉnh/TP nào
                    InputField(
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.usernameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Bạn sẵn sàng làm việc ở những Tỉnh/TP nào",
                      hidden: false,
                      label: "Bạn sẵn sàng làm việc ở những Tỉnh/TP nào",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Ảnh đại diện
                    _uploadAvatar(context),

                    // Khuôn mặt đại diện
                    _uploadFace(context),

                    // mặt trước và sau cammera
                    _uploadCMND(context),

                    // button đăng ký
                    _buttonRegisterWidget(context),
                  ],
                ),
              ));
        });
  }

  ///
  /// _logo Widget
  ///
  Widget _logoWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: 175,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 135,
              height: 135,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.logo_removebg),
                  fit: BoxFit.cover,
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
            child: const Text(
              "ĐĂNG KÝ TÀI KHOẢN",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff0D3B8C),
                fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                fontFamily: "Nunito Sans",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Loai tai khoan
  ///
  Widget _loaiTaiKhoanWidget(BuildContext context) {
    return Column(
      children: [
        DropDownButton<LoaiTaiKhoanResponse>(
          data: controller.loaiTaiKhoans,
          obligatory: true,
          onChanged: (value) => controller.onLoaiTaikhoanChange(value!),
          value: controller.loaiTaiKhoan,
          width: DeviceUtils.getScaledSize(context, 1),
          label: "Loại tài khoản",
          hint: "Loại tài khoản đăng ký",
        ),
        DropDownButton<LoaiTaiKhoanResponse>(
          data: controller.loaiTaiKhoans,
          obligatory: true,
          onChanged: (value) => controller.onLoaiTaikhoanChange(value!),
          value: controller.loaiTaiKhoan,
          width: DeviceUtils.getScaledSize(context, 1),
          label: "Pháp lý",
          hint: 'Chọn Pháp lý',
        ),
      ],
    );
  }

  ///
  /// upload avatar
  ///
  Widget _uploadAvatar(BuildContext context) {
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
                "Hình ảnh đại diện",
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
            onTap: () => controller.onAvatarPicker(),
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.382),
              width: DeviceUtils.getScaledSize(context, 0.509),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(
                      context, controller.avatarFile != null ? 0 : 0.101)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.avatarFile != null
                    ? null
                    : Border.all(width: 2, color: Colors.grey),
              ),
              child: controller.avatarFile != null
                  ? Image.file(
                      controller.avatarFile!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.icon_photo,
                          height: 50,
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
  /// upload face
  ///
  Widget _uploadFace(BuildContext context) {
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
                "Chụp ảnh khuôn mặt",
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
            onTap: () => controller.onAvatarPicker(),
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.382),
              width: DeviceUtils.getScaledSize(context, 0.509),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(
                      context, controller.avatarFile != null ? 0 : 0.101)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.avatarFile != null
                    ? null
                    : Border.all(width: 2, color: Colors.grey),
              ),
              child: controller.avatarFile != null
                  ? Image.file(
                      controller.avatarFile!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.icon_camera,
                          height: 50,
                          // color: Colors.grey,
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
  /// upload CMND
  ///
  Widget _uploadCMND(BuildContext context) {
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
                "CMND/Căn cước",
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

          // cmnd mặt trước và sau
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // mặt trước
              GestureDetector(
                onTap: () => controller.onAvatarPicker(),
                child: Container(
                  height: DeviceUtils.getScaledSize(context, 0.382),
                  width: DeviceUtils.getScaledSize(context, 0.509 * 0.8),
                  padding: EdgeInsets.symmetric(
                      horizontal: DeviceUtils.getScaledSize(
                          context, controller.avatarFile != null ? 0 : 0.101)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: controller.avatarFile != null
                        ? null
                        : Border.all(width: 2, color: Colors.grey),
                  ),
                  child: controller.avatarFile != null
                      ? Image.file(
                          controller.avatarFile!,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.icon_photo,
                              height: 50,
                            ),
                            Text(
                              "Tải lên mặt trước",
                              textAlign: TextAlign.center,
                              style: Dimensions.fontSizeStyle14w600()
                                  .copyWith(color: Colors.grey),
                            )
                          ],
                        ),
                ),
              ),

              // mặt sau
              GestureDetector(
                onTap: () => controller.onAvatarPicker(),
                child: Container(
                  height: DeviceUtils.getScaledSize(context, 0.382),
                  width: DeviceUtils.getScaledSize(context, 0.509 * 0.8),
                  padding: EdgeInsets.symmetric(
                      horizontal: DeviceUtils.getScaledSize(
                          context, controller.avatarFile != null ? 0 : 0.101)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: controller.avatarFile != null
                        ? null
                        : Border.all(width: 2, color: Colors.grey),
                  ),
                  child: controller.avatarFile != null
                      ? Image.file(
                          controller.avatarFile!,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.icon_photo,
                              height: 50,
                            ),
                            Text(
                              "Tải lên mặt sau",
                              textAlign: TextAlign.center,
                              style: Dimensions.fontSizeStyle14w600()
                                  .copyWith(color: Colors.grey),
                            )
                          ],
                        ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  ///
  /// Button register
  ///
  Widget _buttonRegisterWidget(BuildContext context) {
    return GestureDetector(
      // onOTPVerifierTap
      onTap: () => controller.onBtnRegisterTap(),
      child: Container(
        margin: const EdgeInsets.only(
            top: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
            bottom: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
        width: DeviceUtils.getScaledWidth(context, 0.9),
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: DeviceUtils.getScaledWidth(context, 0.9),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 9,
              ),
              child: const Text(
                "Đăng ký",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Nunito Sans",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
