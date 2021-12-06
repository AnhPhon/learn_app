import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/button/drop_down_map_data_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/screen/v1-customer/account/personal_info/personal_info_controller.dart';

class V1PersonalInfoPage extends GetView<V1PersonalInfoController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1PersonalInfoController>(
      init: V1PersonalInfoController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorResources.PRIMARY,
                  )),
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //avatar
                  _avatar(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //title
                  Text(
                    "Thông tin cá nhân",
                    style: Dimensions.fontSizeStyle22w600(),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //company name
                  InputWidget(
                    label: "Tên doanh nghiệp/đội trưởng/cá nhân",
                    labelBold: true,
                    textEditingController: controller.nameCompanyController,
                    suffixIcon: const Icon(
                      Icons.edit,
                      size: Dimensions.ICON_SIZE_DEFAULT,
                      color: ColorResources.BLACK,
                    ),
                    width: .9,
                    fillColor: ColorResources.WHITE,
                    isShadow: true,
                    isBorder: false,
                    obligatory: true,
                    textInputAction: TextInputAction.next,
                  ),

                  //full name
                  InputWidget(
                    label: "Họ và tên",
                    labelBold: true,
                    textEditingController: controller.fullNameController,
                    suffixIcon: const Icon(
                      Icons.edit,
                      size: Dimensions.ICON_SIZE_DEFAULT,
                      color: ColorResources.BLACK,
                    ),
                    width: .9,
                    fillColor: ColorResources.WHITE,
                    isShadow: true,
                    isBorder: false,
                    obligatory: true,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),

                  //born and sex
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                      right: Dimensions.PADDING_SIZE_LARGE,
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //born
                        InputWidget(
                          label: "Ngày sinh",
                          labelBold: true,
                          textEditingController: controller.bornController,
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            size: Dimensions.ICON_SIZE_DEFAULT,
                            color: ColorResources.BLACK,
                          ),
                          width: .45,
                          fillColor: ColorResources.WHITE,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1800),
                          lastDate: DateTime(DateTime.now().year - 18),
                          isShadow: true,
                          isDate: true,
                          allowEdit: false,
                          isBorder: false,
                          obligatory: true,
                          isddMMyyyy: true,
                          textInputAction: TextInputAction.next,
                        ),

                        //sex
                        DropDownMapButton<String>(
                          hint: "Giới tính",
                          label: "Giới tính",
                          obligatory: true,
                          labelBold: true,
                          value: controller.sex,
                          onChanged: controller.onChangedSex,
                          data: controller.sexMap,
                          width: .35,
                          isShadow: true,
                          isBorder: false,
                          fillColor: ColorResources.WHITE,
                        )
                      ],
                    ),
                  ),

                  //CMND va ngay cap
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //CMND
                      InputWidget(
                        label: "Số CMND/Căn cước",
                        labelBold: true,
                        textEditingController: controller.cMNDController,
                        width: .45,
                        fillColor: ColorResources.GREY.withOpacity(.3),
                        isBorder: false,
                        allowEdit: false,
                        padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_LARGE,
                          top: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                      ),

                      //ngay cap
                      InputWidget(
                        label: "Ngày cấp",
                        labelBold: true,
                        textEditingController: controller.ngayCapController,
                        width: .38,
                        fillColor: ColorResources.GREY.withOpacity(.3),
                        isBorder: false,
                        allowEdit: false,
                        padding: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_LARGE,
                          top: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                      ),
                    ],
                  ),

                  //phone
                  InputWidget(
                    label: "Số điện thoại",
                    labelBold: true,
                    textEditingController: controller.phoneController,
                    width: .9,
                    fillColor: ColorResources.GREY.withOpacity(.3),
                    isBorder: false,
                    allowEdit: false,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),

                  //company name
                  InputWidget(
                    label: "Email",
                    labelBold: true,
                    textEditingController: controller.emailController,
                    suffixIcon: const Icon(
                      Icons.edit,
                      size: Dimensions.ICON_SIZE_DEFAULT,
                      color: ColorResources.BLACK,
                    ),
                    width: .9,
                    fillColor: ColorResources.WHITE,
                    isShadow: true,
                    isBorder: false,
                    textInputType: TextInputType.emailAddress,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  BtnCustom(
                    onTap: () => controller.updateAccount(context),
                    color: ColorResources.PRIMARY,
                    text: "Cập nhật",
                    width: DeviceUtils.getScaledWidth(context, .9),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  ///avatar
  ///
  Widget _avatar(BuildContext context,
      {required V1PersonalInfoController controller}) {
    return Stack(
      children: [
        //image
        Container(
          margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
          height: DeviceUtils.getScaledSize(context, .2),
          width: DeviceUtils.getScaledSize(context, .2),
          child: ClipOval(
            child: controller.image != null
                ? Image.file(
                    controller.image!,
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    image: controller.taiKhoanResponse.hinhDaiDien.toString(),
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
