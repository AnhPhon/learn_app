import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v1-customer/account/personal_info/personal_info_controller.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';

class V1PersonalInfoPage extends GetView<V1PersonalInfoController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1PersonalInfoController>(
        init: V1PersonalInfoController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                onTap: () => controller.onBtnBackClick(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorResources.PRIMARY,
                ),
              ),
            ),
            body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //avatar
                    _avatar(context, controller),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),

                    //title
                    Text(
                      "Thông tin cá nhân",
                      style: Dimensions.fontSizeStyle22w600(),
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),

                    //company name
                    InputWidget(
                      label: "Tên doanh nghiệp/đội trưởng/cá nhân",
                      labelBold: true,
                      textEditingController: controller.nameController,
                      suffixIcon: const Icon(
                        Icons.edit,
                        size: Dimensions.ICON_SIZE_DEFAULT,
                        color: ColorResources.BLACK,
                      ),
                      width: 1,
                      isShadow: true,
                      isColorFieldWhite: true,
                      isBorder: false,
                    ),

                    //row name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //first name
                        InputWidget(
                          label: "Họ",
                          labelBold: true,
                          textEditingController: controller.nameController,
                          suffixIcon: const Icon(
                            Icons.edit,
                            size: Dimensions.ICON_SIZE_DEFAULT,
                            color: ColorResources.BLACK,
                          ),
                          width: .35,
                          isShadow: true,
                          isColorFieldWhite: true,
                          isBorder: false,
                        ),

                        //last name
                        InputWidget(
                          label: "Tên",
                          labelBold: true,
                          textEditingController: controller.nameController,
                          suffixIcon: const Icon(
                            Icons.edit,
                            size: Dimensions.ICON_SIZE_DEFAULT,
                            color: ColorResources.BLACK,
                          ),
                          width: .45,
                          isShadow: true,
                          isColorFieldWhite: true,
                          isBorder: false,
                        ),
                      ],
                    ),

                    //born and sex
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //born
                        InputWidget(
                          label: "Ngày sinh",
                          labelBold: true,
                          textEditingController: controller.nameController,
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            size: Dimensions.ICON_SIZE_DEFAULT,
                            color: ColorResources.BLACK,
                          ),
                          width: .45,
                          isShadow: true,
                          isColorFieldWhite: true,
                          isDate: true,
                          isBorder: false,
                        ),

                        //sex
                        DropDownButton1(
                          hint: " ",
                          label: "Giới tính",
                          onChanged: (val) {},
                          data: const ["Nam", "Nữ"],
                          isColorFieldWhite: true,
                          isBorder: false,
                          width: .35,
                          isShadow: true,
                        )
                      ],
                    ),

                    //CMND va ngay cap
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //CMND
                        InputWidget(
                          label: "Số CMND/Căn cước",
                          labelBold: true,
                          textEditingController: controller.nameController,
                          suffixIcon: const Icon(
                            Icons.edit,
                            size: Dimensions.ICON_SIZE_DEFAULT,
                            color: ColorResources.BLACK,
                          ),
                          width: .45,
                          isShadow: true,
                          isColorFieldWhite: true,
                          isBorder: false,
                        ),

                        //ngay cap
                        InputWidget(
                          label: "Ngày cấp",
                          labelBold: true,
                          textEditingController: controller.nameController,
                          suffixIcon: const Icon(
                            Icons.edit,
                            size: Dimensions.ICON_SIZE_DEFAULT,
                            color: ColorResources.BLACK,
                          ),
                          width: .38,
                          isShadow: true,
                          isColorFieldWhite: true,
                          isBorder: false,
                        ),
                      ],
                    ),

                    //phone
                    InputWidget(
                      label: "Số điện thoại",
                      labelBold: true,
                      textEditingController: controller.nameController,
                      width: 1,
                      isShadow: true,
                      obligatory: true,
                      isColorFieldWhite: true,
                      isBorder: false,
                    ),

                    //company name
                    InputWidget(
                      label: "Email (nếu có)",
                      labelBold: true,
                      textEditingController: controller.nameController,
                      suffixIcon: const Icon(
                        Icons.edit,
                        size: Dimensions.ICON_SIZE_DEFAULT,
                        color: ColorResources.BLACK,
                      ),
                      width: 1,
                      isShadow: true,
                      isColorFieldWhite: true,
                      isBorder: false,
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),

                    BtnCustom(
                      onTap: () {},
                      color: ColorResources.PRIMARY,
                      text: "Cập nhật",
                      width: DeviceUtils.getScaledWidth(context, .9),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///
  ///avatar
  ///
  Widget _avatar(BuildContext context, V1PersonalInfoController controller) {
    return Stack(
      children: [
        //image
        Container(
          margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
          height: DeviceUtils.getScaledSize(context, .2),
          width: DeviceUtils.getScaledSize(context, .2),
          child: ClipOval(
            child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                image: controller.urlImage,
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
            onTap: () {
              // controller.onEditInfoClick();
            },
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