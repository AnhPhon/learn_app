import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';

import 'package:template/view/screen/v4-employee/account/component/drop_dow_map_button.dart';
import 'info_controller.dart';

class V4InfoPage extends GetView<V4InfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Thông tin cá nhân"),
      body: SingleChildScrollView(
          child: GetBuilder<V4InfoController>(
              init: V4InfoController(),
              builder: (V4InfoController controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _avatar(controller, context),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      //Họ và tên
                      _name(controller, context),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Ngày sinh
                          _birthday(controller, context),

                          //Giới tính
                          _sex(controller, context),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //CMND/Căn cước
                          _identityCard(controller, context),

                          // Ngày cấp
                          _dateIndentityCard(controller, context),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),

                      // nơi cấp CMND/Căn cước
                      _addresssIndentityCard(controller, context),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),

                      //Số điện thoại
                      _phoneNumber(controller, context),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),

                      // Email
                      _email(controller, context),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),

                      // địa chỉ thường trú hiện tại
                      _addresss(controller, context),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Tinhr /Tp
                          _city(controller, context),

                          //Quận/Huyện
                          _district(controller, context),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),

                      //Phường/ xã
                      _ward(controller, context),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Hình ảnh mặt trước và mặt sau của CMND/Căn cước',
                                  style: TextStyle(
                                    color: ColorResources.BLACK,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: ColorResources.RED,
                                  ),
                                ),
                              ]),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE * 1.5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            //Thêm CMND/Căn cước mặt trước
                            _indetityCardFront(context, controller),

                            //Thêm CMND/Căn cước mặt sau
                            _indentiryCardAfter(context, controller),
                          ],
                        ),
                      ),

                      Container(
                        height: DeviceUtils.getScaledHeight(context, 0.05),
                      ),

                      //Button cập nhập
                      _btnUpdate(),

                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),
                    ],
                  ),
                );
              })),
    );
  }

  ///
  ///Birthday
  ///
  Widget _birthday(V4InfoController controller, BuildContext context) {
    return InputWidget(
      suffixIcon: const Icon(
        Icons.date_range,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
      isBorder: false,
      isShadow: true,
      isColorFieldWhite: true,
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: false,
      label: "Ngày sinh",
      obligatory: true,
      width: 0.5,
      textEditingController: controller.birthdayController,
    );
  }

  ///
  /// Giới tính
  ///
  Widget _sex(V4InfoController controller, BuildContext context) {
    return V4DropDownMapButton<String>(
      label: "Giới tính",
      obligatory: true,
      colorText: ColorResources.BLACK,
      fillColor: ColorResources.WHITE,
      onChanged: controller.onChangedSex,
      data: controller.sexMap,
      width: 0.3,
      value: controller.sex!,
    );
  }

  ///
  /// CMND
  ///
  Widget _identityCard(V4InfoController controller, BuildContext context) {
    return InputWidget(
      isBorder: false,
      isShadow: true,
      allowEdit: false,
      label: 'Số CMND/Căn cước',
      obligatory: true,
      width: 0.4,
      textEditingController: controller.indentityCardController,
    );
  }

  ///
  ///Ngày cấp
  ///
  Widget _dateIndentityCard(V4InfoController controller, BuildContext context) {
    return InputWidget(
      isShadow: true,
      isBorder: false,
      isDate: true,
      allowEdit: false,
      label: "Ngày cấp",
      obligatory: true,
      width: 0.4,
      textEditingController: controller.dateIndentityController,
    );
  }

  ///
  /// Nơi cấp CMND / Căn cước
  ///
  Widget _addresssIndentityCard(
      V4InfoController controller, BuildContext context) {
    return InputWidget(
      textInputType: TextInputType.streetAddress,
      suffixIcon: const Icon(
        Icons.edit_outlined,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
      isShadow: true,
      isBorder: false,
      isColorFieldWhite: true,
      label: 'Nơi cấp CMND/Căn cước',
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.addressIndentityController,
    );
  }

  ///
  /// Số điện thoại
  ///
  Widget _phoneNumber(V4InfoController controller, BuildContext context) {
    return InputWidget(
      suffixIcon: const Icon(
        Icons.edit_outlined,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
      textInputType: TextInputType.number,
      isShadow: true,
      isBorder: false,
      isColorFieldWhite: true,
      label: 'Số điện thoại',
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 0.5),
      textEditingController: controller.phoneNumberController,
    );
  }

  ///
  /// Email
  ///
  Widget _email(V4InfoController controller, BuildContext context) {
    return InputWidget(
      textInputType: TextInputType.emailAddress,
      suffixIcon: const Icon(
        Icons.edit_outlined,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
      isShadow: true,
      isBorder: false,
      isColorFieldWhite: true,
      label: 'Email(nếu có)',
      width: DeviceUtils.getScaledWidth(context, 0.5),
      textEditingController: controller.emailController,
    );
  }

  ///
  /// địa chỉ thường trú hiện tại
  ///
  Widget _addresss(V4InfoController controller, BuildContext context) {
    return InputWidget(
      suffixIcon: const Icon(
        Icons.edit_outlined,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
      isShadow: true,
      isBorder: false,
      isColorFieldWhite: true,
      label: 'Địa chỉ thường trú hiện tại',
      obligatory: true,
      textInputType: TextInputType.streetAddress,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.addressController,
    );
  }

  ///
  /// Tỉnh /TP
  ///
  Widget _city(V4InfoController controller, BuildContext context) {
    return DropDownButton1<TinhTpResponse>(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        0,
        0,
      ),
      isColorFieldWhite: true,
      isBorder: false,
      isShadow: true,
      hint: controller.hintTextTinhTp,
      label: 'Tỉnh/Tp',
      data: controller.tinhTpList,
      obligatory: true,
      onChanged: (value) => controller.onChangedTinhThanh(value!),
      value: controller.tinhTp,
      width: 0.4,
    );
  }

  ///
  /// Quận / Huyện
  ///
  Widget _district(V4InfoController controller, BuildContext context) {
    return DropDownButton1<QuanHuyenResponse>(
      padding: const EdgeInsets.fromLTRB(
        0,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      isColorFieldWhite: true,
      isBorder: false,
      isShadow: true,
      hint: '',
      label: 'Quận/Huyện',
      data: controller.quanHuyenList,
      obligatory: true,
      onChanged: (value) => controller.onChangedQuanHuyen(value!),
      value: controller.quanHuyen,
      width: 0.4,
    );
  }

  ///
  /// Phường / xã
  ///
  Widget _ward(V4InfoController controller, BuildContext context) {
    return DropDownButton1<PhuongXaResponse>(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        0,
        0,
      ),
      isColorFieldWhite: true,
      isBorder: false,
      isShadow: true,
      hint: '',
      label: 'Phường/Xã',
      data: controller.phuongXaList,
      obligatory: true,
      onChanged: (value) => controller.onChangedPhuongXa(value!),
      value: controller.phuongXa,
      width: 0.4,
    );
  }

  ///
  /// Button cập nhập
  ///
  Widget _btnUpdate() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: LongButton(
        color: ColorResources.PRIMARY,
        onPressed: () {},
        title: 'Cập nhập',
      ),
    );
  }

  ///
  /// CMND mặt trước
  ///
  Widget _indetityCardFront(BuildContext context, V4InfoController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.16),
      width: DeviceUtils.getScaledWidth(context, 0.38),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          Dimensions.BORDER_RADIUS_EXTRA_SMALL,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorResources.BLACK.withAlpha(40),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(
            controller.nhanVienResponse.anhMTCMND.toString(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_photo_alternate_outlined,
              size: Dimensions.ICON_SIZE_EXTRA_LARGE,
            ),
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          Text(
            'Mặt trước',
            style: Dimensions.fontSizeStyle16w600(),
          ),
        ],
      ),
    );
  }

  ///
  ///CMND mặt sau
  ///
  Widget _indentiryCardAfter(
      BuildContext context, V4InfoController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.16),
      width: DeviceUtils.getScaledWidth(context, 0.38),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          Dimensions.BORDER_RADIUS_EXTRA_SMALL,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorResources.BLACK.withAlpha(40),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(
            controller.nhanVienResponse.anhMSCMND.toString(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add_photo_alternate_outlined,
              size: Dimensions.ICON_SIZE_EXTRA_LARGE,
            ),
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          Text(
            'Mặt sau',
            style: Dimensions.fontSizeStyle16w600(),
          ),
        ],
      ),
    );
  }

  ///
  /// Avatar
  ///
  Widget _avatar(V4InfoController controller, BuildContext context) {
    if (controller.isLoadingImage) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.3),
      height: DeviceUtils.getScaledHeight(context, 0.14),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: Dimensions.BORDER_RADIUS_EXTRA_LARGE,
              backgroundColor: ColorResources.WHITE,
              child: CircleAvatar(
                radius: Dimensions.BORDER_RADIUS_EXTRA_LARGE - 2,
                backgroundImage: NetworkImage(
                    controller.nhanVienResponse.hinhDaiDien.toString()),
              ),
            ),
          ),
          Positioned(
            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 0.1),
              height: DeviceUtils.getScaledWidth(context, 0.1),
              decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      // ignore: prefer_const_constructors
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: ColorResources.BLACK.withAlpha(20),
                    )
                  ]),
              child: IconButton(
                onPressed: () {
                  controller.pickImage();
                },
                icon: const Icon(
                  Icons.add_a_photo_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Full name
  ///
  Widget _name(V4InfoController controller, BuildContext context) {
    return InputWidget(
      textInputType: TextInputType.name,
      isShadow: true,
      isColorFieldWhite: true,
      labelBold: true,
      isBorder: false,
      label: 'Họ và tên',
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.nameController,
      suffixIcon: const Icon(
        Icons.edit_outlined,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
    );
  }
}
