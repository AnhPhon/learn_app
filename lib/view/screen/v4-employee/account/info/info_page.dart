import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';

import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/account/component/add_indentity_card.dart';
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
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Họ và tên
                      _name(controller, context),

                      Row(
                        children: [
                          //Ngày sinh
                          Padding(
                            padding: const EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            child: _birthday(controller, context),
                          ),

                          //Giới tính
                          _sex(controller, context),
                        ],
                      ),
                      Row(
                        children: [
                          //CMND/Căn cước
                          _identityCard(controller, context),

                          // Ngày cấp
                          Padding(
                            padding: const EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                            child: _dateIndentityCard(controller, context),
                          ),
                        ],
                      ),

                      // nơi cấp CMND/Căn cước
                      _addresssIndentityCard(controller, context),
                      Row(
                        children: [
                          //Số điện thoại
                          _phoneNumber(controller, context),

                          // Email
                          _email(controller, context),
                        ],
                      ),

                      // địa chỉ thường trú hiện tại
                      _addresss(controller, context),

                      Row(
                        children: [
                          // Tinhr /Tp
                          _city(context),

                          //Quận/Huyện
                          _district(context),
                        ],
                      ),

                      //Phường/ xã
                      _ward(context),

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
                            const AddIndentityCard(
                              label: 'Mặt trước',
                            ),

                            //Thêm CMND/Căn cước mặt sau
                            const AddIndentityCard(
                              label: 'Mặt sau',
                            ),
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
  /// Full name
  ///
  Widget _name(V4InfoController controller, BuildContext context) {
    return InputField(
      allowEdit: false,
      allowMultiline: false,
      controller: controller.nameController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: controller.fullname,
      label: 'Họ và tên',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }
}

///
///Birthday
///
Widget _birthday(V4InfoController controller, BuildContext context) {
  return TextFieldDate(
    paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
    isDate: true,
    allowEdit: true,
    controller: controller.birthdayController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    holdplacer: controller.birthday,
    label: "Ngày",
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// Giới tính
///
Widget _sex(V4InfoController controller, BuildContext context) {
  return DropDownButton<String>(
    label: 'Giới tính',
    data: const ["Nam", "Nữ"],
    obligatory: true,
    onChanged: (value) {},
    value: "Nam",
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// CMND
///
Widget _identityCard(V4InfoController controller, BuildContext context) {
  return InputField(
    allowEdit: false,
    allowMultiline: false,
    controller: controller.indentityCardController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: controller.indentityCard,
    label: 'Số CMND/Căn cước',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 0.52),
  );
}

///
///Ngày cấp
///
Widget _dateIndentityCard(V4InfoController controller, BuildContext context) {
  return TextFieldDate(
    paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
    isDate: true,
    allowEdit: true,
    controller: controller.dateIndentityController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    holdplacer: controller.dateIndentityCard,
    label: "Ngày cấp",
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 0.48),
  );
}

///
/// Nơi cấp CMND / Căn cước
///
Widget _addresssIndentityCard(
    V4InfoController controller, BuildContext context) {
  return InputField(
    allowEdit: false,
    allowMultiline: false,
    controller: controller.addressIndentityController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: controller.addresssIndentityCard,
    label: 'Nơi cấp',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Số điện thoại
///
Widget _phoneNumber(V4InfoController controller, BuildContext context) {
  return InputField(
    allowEdit: false,
    allowMultiline: false,
    controller: controller.phoneNumberController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: controller.phoneNumber,
    label: 'Số điện thoại',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// Email
///
Widget _email(V4InfoController controller, BuildContext context) {
  return InputField(
    allowEdit: false,
    allowMultiline: false,
    controller: controller.emailController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: controller.email,
    label: 'Email(nếu có)',
    obligatory: false,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// địa chỉ thường trú hiện tại
///
Widget _addresss(V4InfoController controller, BuildContext context) {
  return InputField(
    allowEdit: false,
    allowMultiline: false,
    controller: controller.addressController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: controller.addresss,
    label: 'Địa chỉ thường trú hiện tại',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Tỉnh /TP
///
Widget _city(BuildContext context) {
  return DropDownButton<String>(
    label: 'Tỉnh/Tp',
    data: const ["Đà Nẵng", "Huế"],
    obligatory: true,
    onChanged: (value) {},
    value: "Đà Nẵng",
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// Quận / Huyện
///
Widget _district(BuildContext context) {
  return DropDownButton<String>(
    label: 'Quận/Huyện',
    data: const ["Cẩm Lệ", "Hải Châu"],
    obligatory: true,
    onChanged: (value) {},
    value: "Cẩm Lệ",
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// Phường / xã
///
Widget _ward(BuildContext context) {
  return DropDownButton<String>(
    label: 'Phường/Xã',
    data: const ["Hòa Thọ Đông", "Thanh Khê"],
    obligatory: true,
    onChanged: (value) {},
    value: "Hòa Thọ Đông",
    width: DeviceUtils.getScaledWidth(context, 0.5),
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
