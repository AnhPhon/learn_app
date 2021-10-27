import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';

import 'package:template/view/screen/v4-employee/account/component/drop_dow_map_button.dart';
import 'info_controller.dart';

class V4InfoPage extends GetView<V4InfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: IconButton(
          onPressed: () {
            controller.backHome();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Thông tin cá nhân",
      ),
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
                          text: TextSpan(children: [
                            TextSpan(
                                text:
                                    'Hình ảnh mặt trước và mặt sau của CMND/Căn cước',
                                style:
                                    Dimensions.fontSizeStyle16w600().copyWith(
                                  color: ColorResources.BLACK,
                                  fontWeight: FontWeight.w600,
                                )),
                            const TextSpan(
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
                      _btnUpdate(controller, context),

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
      isddMMyyyy: true,
      isBorder: false,
      isShadow: true,
      isColorFieldWhite: true,
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
      value: controller.sex,
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
      allowEdit: false,
      textInputType: TextInputType.streetAddress,
      suffixIcon: const Icon(
        Icons.edit_outlined,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
      isShadow: true,
      isBorder: false,
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
      width: 0.42,
      isBoldHintText: true,
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
      hint: controller.hintTextQuanHuyen,
      label: 'Quận/Huyện',
      data: controller.quanHuyenList,
      obligatory: true,
      onChanged: (value) => controller.onChangedQuanHuyen(value!),
      value: controller.quanHuyen,
      width: 0.42,
      isBoldHintText: true,
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
      hint: controller.hintTextPhuongXa,
      label: 'Phường/Xã',
      data: controller.phuongXaList,
      obligatory: true,
      onChanged: (value) => controller.onChangedPhuongXa(value!),
      value: controller.phuongXa,
      width: 0.42,
      isBoldHintText: true,
    );
  }

  ///
  /// Button cập nhập
  ///
  Widget _btnUpdate(V4InfoController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: LongButton(
        color: ColorResources.PRIMARY,
        onPressed: () {
          controller.updateAccount(context);
        },
        title: 'Cập nhập',
      ),
    );
  }

  ///
  /// CMND mặt trước
  ///
  Widget _indetityCardFront(BuildContext context, V4InfoController controller) {
    if (controller.isLoadingImage) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.pickIndentiryFront();
          },
          child: Container(
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
            ),
            child: controller.imageIndentityFront != null
                ? Image.file(
                    controller.imageIndentityFront!,
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    image: controller.nhanVienResponse.anhMTCMND.toString(),
                    fit: BoxFit.cover,
                    imageErrorBuilder: (c, o, s) => Container(
                      height: DeviceUtils.getScaledHeight(context, 0.16),
                      width: DeviceUtils.getScaledWidth(context, 0.38),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.placeholder),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_SMALL,
        ),
        Text(
          'Mặt trước',
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: ColorResources.BLACK.withOpacity(.6),
          ),
        ),
      ],
    );
  }

  ///
  ///CMND mặt sau
  ///
  Widget _indentiryCardAfter(
      BuildContext context, V4InfoController controller) {
    if (controller.isLoadingImage) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.pickIndentiryAfter();
          },
          child: Container(
            height: DeviceUtils.getScaledHeight(context, 0.16),
            width: DeviceUtils.getScaledWidth(context, 0.38),
            decoration: BoxDecoration(
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
            ),
            child: controller.imageIndentityAfter != null
                ? Image.file(
                    controller.imageIndentityAfter!,
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    image: controller.nhanVienResponse.anhMSCMND.toString(),
                    fit: BoxFit.cover,
                    imageErrorBuilder: (c, o, s) => Container(
                      height: DeviceUtils.getScaledHeight(context, 0.16),
                      width: DeviceUtils.getScaledWidth(context, 0.38),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.placeholder),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_SMALL,
        ),
        Text(
          'Mặt sau',
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            color: ColorResources.BLACK.withOpacity(.6),
          ),
        ),
      ],
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
    return Stack(
      children: [
        //image
        Container(
          height: DeviceUtils.getScaledSize(context, .2),
          width: DeviceUtils.getScaledSize(context, .2),
          child: ClipOval(
            child: controller.avatarFile != null
                ? Image.file(
                    controller.avatarFile!,
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    image: controller.nhanVienResponse.hinhDaiDien.toString(),
                    fit: BoxFit.cover,
                    imageErrorBuilder: (c, o, s) => const CircleAvatar(
                        backgroundImage: AssetImage(Images.placeholder))),
          ),
        ),

        //edit
        Positioned(
          right: 0,
          top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
          child: GestureDetector(
            onTap: () => controller.pickImage(),
            child: Container(
              padding:
                  const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: const BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const Icon(
                Icons.add_a_photo_outlined,
                color: ColorResources.PRIMARY,
                size: Dimensions.ICON_SIZE_SMALL,
              ),
            ),
          ),
        )
      ],
    );
  }
}
