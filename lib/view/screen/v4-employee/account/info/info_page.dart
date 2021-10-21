import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';

import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Ngày sinh
                          Padding(
                            padding: const EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_SMALL - 2,
                            ),
                            child: _birthday(controller, context),
                          ),

                          //Giới tính
                          _sex(context),
                        ],
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
    return InputWidget(
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
Widget _sex(BuildContext context) {
  return DropDownButton1<String>(
    isBorder: false,
    isShadow: true,
    isColorFieldWhite: true,
    labelBold: true,
    hint: '',
    label: 'Giới tính',
    data: const ["Nam", "Nữ"],
    obligatory: true,
    onChanged: (value) {},
    value: "Nam",
    width: 0.3,
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
  return InputField(
    allowEdit: false,
    allowMultiline: false,
    controller: controller.phoneNumberController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: "0899461113",
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
    holdplacer: "ngotrananhphon.flutter.dev@gmail.com",
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
    holdplacer: "Hòa Thọ Đông, Cẩm Lệ, Đà Nẵng",
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
