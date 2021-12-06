import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:template/data/model/response/loai_tai_khoan_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/button/custom_button.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
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
          if (value.isLoadTypeAccount || value.isLoadProvince) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
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
                      controller: controller.enterpriseNameController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Tên doanh nghiệp/đội trưởng/cá nhân",
                      hidden: false,
                      label: "Tên doanh nghiệp/đội trưởng/cá nhân",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Mã số thuế
                    InputField(
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.taxCodeController,
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
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.fullNameController,
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
                      isBirthDate: true,
                      isDate: true,
                      allowEdit: true,
                      controller: controller.birthDateController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "dd-MM-yyyy",
                      label: "Ngày tháng năm sinh",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                    ),

                    // Giới tính
                    DropDownButton<String>(
                      data: controller.genders,
                      obligatory: true,
                      onChanged: (value) => controller.onChangedGender(value!),
                      value: controller.gender,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Giới tính",
                      hint: "Giới tính",
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                    ),

                    // cmnd
                    InputField(
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.cmndController,
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
                      isBirthDate: true,
                      isDate: true,
                      allowEdit: true,
                      controller: controller.dateRangeController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "dd-MM-yyyy",
                      label: "Ngày cấp",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                    ),

                    // Nơi cấp
                    InputField(
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.placeIssueController,
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
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.phoneNumberController,
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
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.emailController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Nhập email",
                      hidden: false,
                      label: "Email",
                      obligatory: false,
                      typeInput: TextInputType.emailAddress,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),
                    // email
                    InputField(
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.passwordController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Nhập mật khẩu",
                      hidden: true,
                      label: "Mật khẩu",
                      obligatory: true,
                      typeInput: TextInputType.emailAddress,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),
                    // email
                    InputField(
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.repeatPasswordController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Nhập lại mật khẩu",
                      hidden: true,
                      label: "Nhập lại mật khẩu",
                      obligatory: true,
                      typeInput: TextInputType.emailAddress,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // TODO: baohq
                    const Label(
                        label: "Khu vực tham gia chọn nhiều", obligatory: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child: MultiSelectDialogField(
                        searchable: true,
                        listType: MultiSelectListType.LIST,
                        buttonIcon: const Icon(Icons.arrow_drop_down),
                        items: controller.multipSelecteProvince,
                        title: const Text("Khu vực"),
                        decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            border:
                                Border.all(color: ColorResources.PRIMARYCOLOR),
                            borderRadius: BorderRadius.circular(5)),
                        selectedColor: Colors.blue,
                        selectedItemsTextStyle:
                            const TextStyle(color: ColorResources.BLACK),
                        checkColor: ColorResources.WHITE,
                        buttonText: const Text(
                          "Khu vực tham gia chọn nhiều",
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (List<TinhTpResponse?> results) {
                          // DeviceUtils.unFocus(context);
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.multipSelectedProvinces = results;
                        },
                      ),
                    ),

                    // địa chỉ hiện tại
                    InputField(
                      textInputAction: TextInputAction.next,
                      allowEdit: true,
                      allowMultiline: false,
                      controller: controller.addressController,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      holdplacer: "Nhập địa chỉ hiện tại",
                      hidden: false,
                      label: "Địa chỉ hiện tại",
                      obligatory: true,
                      typeInput: TextInputType.text,
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),

                    // Tỉnh/TP
                    SearchDropDownButton<TinhTpResponse>(
                      data: controller.provinces,
                      obligatory: true,
                      onChanged: (value) =>
                          controller.onChangedProvince(value!),
                      value: controller.province,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Tỉnh/TP",
                      hint: "Tỉnh/TP",
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                    ),

                    // Quận/Huyện
                    SearchDropDownButton<QuanHuyenResponse>(
                      data: controller.districts,
                      obligatory: true,
                      isEnable: controller.province != null,
                      // highLightHint: true,
                      onChanged: (value) =>
                          controller.onChangedDistrict(value!),
                      value: controller.district,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Quận/Huyện",
                      hint: "Quận/Huyện",
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                    ),

                    // Phường xã
                    SearchDropDownButton<PhuongXaResponse>(
                      data: controller.wards,
                      obligatory: true,
                      isEnable: controller.district != null,
                      onChanged: (value) => controller.onChangedWard(value!),
                      value: controller.ward,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Phường xã",
                      hint: "Phường xã",
                      padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                          top: Dimensions.PADDING_SIZE_DEFAULT),
                    ),

                    // Chỉ áp dụng cho thợ thầu
                    // Số lượng người
                    if (controller.loaiTaiKhoan != null)
                      if (controller.loaiTaiKhoan!.tieuDe!
                          .toLowerCase()
                          .contains('thợ thầu'))
                        InputField(
                          textInputAction: TextInputAction.next,
                          allowEdit: true,
                          allowMultiline: false,
                          controller: controller.amountController,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          holdplacer: "Số người (Thầu/tổ đội)",
                          hidden: false,
                          label: "Số người (Thầu/tổ đội)",
                          obligatory: false,
                          typeInput: TextInputType.number,
                          width: DeviceUtils.getScaledWidth(context, 1),
                        ),

                    // Chuyên làm việc gì
                    if (controller.loaiTaiKhoan != null)
                      if (controller.loaiTaiKhoan!.tieuDe!
                          .toLowerCase()
                          .contains('thợ thầu'))
                        InputField(
                          textInputAction: TextInputAction.next,
                          allowEdit: true,
                          allowMultiline: false,
                          controller: controller.jobExpertsController,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          holdplacer: "Chuyên môn",
                          hidden: false,
                          label: "Chuyên môn",
                          obligatory: false,
                          typeInput: TextInputType.text,
                          width: DeviceUtils.getScaledWidth(context, 1),
                        ),

                    // Giới thiệu năng lực, kinh nghiệm
                    if (controller.loaiTaiKhoan != null)
                      if (controller.loaiTaiKhoan!.tieuDe!
                          .toLowerCase()
                          .contains('thợ thầu'))
                        InputField(
                          textInputAction: TextInputAction.next,
                          allowEdit: true,
                          allowMultiline: false,
                          controller: controller.experienceController,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          holdplacer: "Giới thiệu năng lực, kinh nghiệm",
                          hidden: false,
                          label: "Giới thiệu năng lực, kinh nghiệm",
                          obligatory: true,
                          typeInput: TextInputType.text,
                          width: DeviceUtils.getScaledWidth(context, 1),
                        ),

                    // Bạn sẵn sàng làm việc ở những Tỉnh/TP nào
                    if (controller.loaiTaiKhoan != null)
                      if (controller.loaiTaiKhoan!.tieuDe!
                          .toLowerCase()
                          .contains('thợ thầu'))
                        InputField(
                          textInputAction: TextInputAction.next,
                          allowEdit: true,
                          allowMultiline: false,
                          controller: controller.readyWorkController,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          holdplacer:
                              "Bạn sẵn sàng hoạt động việc ở những Tỉnh/TP nào",
                          hidden: false,
                          label: "Bạn sẵn sàng hoạt động ở những Tỉnh/TP nào",
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
      height: 185,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 135,
              height: 135,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.logo_app),
                  fit: BoxFit.contain,
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
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT,
              top: Dimensions.PADDING_SIZE_DEFAULT),
        ),
        DropDownButton<String>(
          data: controller.juridicals,
          obligatory: true,
          onChanged: (value) => controller.onChangedjuridical(value!),
          value: controller.juridical,
          width: DeviceUtils.getScaledSize(context, 1),
          label: "Pháp lý",
          hint: 'Chọn Pháp lý',
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT,
              top: Dimensions.PADDING_SIZE_DEFAULT),
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
          SizedBox(
            height: DeviceUtils.getScaledSize(context, 0.382),
            width: DeviceUtils.getScaledSize(context, 0.509),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                GestureDetector(
                  onTap: () {
                    _onShowBottomSheet(
                      context,
                      cameraTap: () {
                        controller.onAvatarPicker(true);
                      },
                      imagePicker: () {
                        controller.onAvatarPicker(false);
                      },
                    );
                  },
                  child: Container(
                    height: DeviceUtils.getScaledSize(context, 0.382),
                    width: DeviceUtils.getScaledSize(context, 0.509),
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context,
                            controller.avatarFile != null ? 0 : 0.101)),
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
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.onAvatarPicker(true);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        )),
                    const SizedBox(width: 10),
                    // GestureDetector(
                    //     onTap: (){
                    //     controller.onAvatarPicker(false);
                    //   },
                    //   child: const Icon(Icons.photo)
                    // )
                  ],
                )
              ],
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
          GestureDetector(
            onTap: () => controller.onFacePicker(),
            child: Container(
              height: DeviceUtils.getScaledSize(context, 0.382),
              width: DeviceUtils.getScaledSize(context, 0.509),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledSize(
                      context, controller.faceFile != null ? 0 : 0.101)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: controller.faceFile != null
                    ? null
                    : Border.all(width: 2, color: Colors.grey),
              ),
              child: controller.faceFile != null
                  ? Image.file(
                      controller.faceFile!,
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
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _onShowBottomSheet(
                        context,
                        cameraTap: () {
                          controller.onFrontCMNDPicker(true);
                        },
                        imagePicker: () {
                          controller.onFrontCMNDPicker(false);
                        },
                      );
                    },
                    child: Container(
                      height: DeviceUtils.getScaledSize(context, 0.382),
                      width: DeviceUtils.getScaledSize(context, 0.509 * 0.8),
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context,
                              controller.frontCMND != null ? 0 : 0.101)),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: controller.frontCMND != null
                            ? null
                            : Border.all(width: 2, color: Colors.grey),
                      ),
                      child: controller.frontCMND != null
                          ? Image.file(
                              controller.frontCMND!,
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
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.onFrontCMNDPicker(true);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          )),
                      const SizedBox(width: 10),
                      // GestureDetector(
                      //    onTap: (){
                      //     controller.onFrontCMNDPicker(false);
                      //   },
                      //   child: const Icon(Icons.photo)
                      // )
                    ],
                  )
                ],
              ),

              // mặt sau
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _onShowBottomSheet(
                        context,
                        cameraTap: () {
                          controller.onbackSideCMNDPicker(true);
                        },
                        imagePicker: () {
                          controller.onbackSideCMNDPicker(false);
                        },
                      );
                    },
                    child: Container(
                      height: DeviceUtils.getScaledSize(context, 0.382),
                      width: DeviceUtils.getScaledSize(context, 0.509 * 0.8),
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context,
                              controller.backSideCMND != null ? 0 : 0.101)),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: controller.backSideCMND != null
                            ? null
                            : Border.all(width: 2, color: Colors.grey),
                      ),
                      child: controller.backSideCMND != null
                          ? Image.file(
                              controller.backSideCMND!,
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
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            controller.onbackSideCMNDPicker(true);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          )),
                      const SizedBox(width: 10),
                      // GestureDetector(
                      //   onTap: (){
                      //     controller.onbackSideCMNDPicker(false);
                      //   },
                      //   child: const Icon(Icons.photo)
                      // )
                    ],
                  )
                ],
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

  void _onShowBottomSheet(
    BuildContext context, {
    Function()? imagePicker,
    Function()? cameraTap,
  }) {
    // controller.onAvatarPicker(false);
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: ColorResources.WHITE,
          height: 2 * 70,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buttonBottomSheetWidget(
                  "Hình ảnh",
                  const TextStyle(
                    color: ColorResources.BLACK,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                  icon: Icons.image,
                  onTap: imagePicker,
                ),
                _buttonBottomSheetWidget(
                  "Camera",
                  const TextStyle(
                    color: ColorResources.BLACK,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                  icon: Icons.camera,
                  onTap: cameraTap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  /// button
  ///
  Widget _buttonBottomSheetWidget(String label, TextStyle style,
      {Color? backgroundColor, Function()? onTap, IconData? icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorResources.WHITE,
          boxShadow: const [
            BoxShadow(
              color: ColorResources.LIGHT_BLACK,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, size: Dimensions.FONT_SIZE_OVER_LARGE * 1.25),
            const SizedBox(width: Dimensions.MARGIN_SIZE_SMALL),
            Text(label, style: style)
          ],
        ),
      ),
    );
  }
}
