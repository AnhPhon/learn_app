import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v3-agent/store_infomation/store_infomation_controller.dart';

class V3StoreInfomationPage extends GetView<V3StoreInfomationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3StoreInfomationController>(
        init: V3StoreInfomationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //name company
                  _titleTextField(
                    title: "Tên doanh nghiệp (hoặc tên cá nhân)",
                    textController: controller.nameController,
                    isRequired: true,
                  ),

                  //legal Representative
                  _titleTextField(
                    title: "Người đại diện pháp lý (chủ doanh nghiệp/cá nhân)",
                    textController: controller.legalRepresentativeController,
                    isRequired: true,
                  ),

                  //phone
                  _titleTextField(
                    title: "SĐT Zalo",
                    textController: controller.phoneController,
                    isRequired: true,
                  ),

                  //email
                  _titleTextField(
                    title: "Email",
                    textController: controller.emailController,
                    isRequired: false,
                  ),

                  //store group
                  DropDownButton<StoreGroup>(
                    hint: "Chọn nhóm cửa hàng",
                    value: controller.storeGroup!,
                    onChanged: controller.onSelectedStoreGroup,
                    data: controller.storeGroupList,
                    width: double.infinity,
                    label: "Chọn nhóm cửa hàng",
                    obligatory: true,
                    isColorFieldWhite: true,
                  ),

                  //product special
                  DropDownButton<ProductSpecial>(
                    hint: "Chọn nhóm cửa hàng",
                    value: controller.productSpecial!,
                    onChanged: (value) =>
                        controller.onProductSpecialGroup(value!),
                    data: controller.productSpecialList,
                    width: double.infinity,
                    label: "Chọn mặt hàng đặc trưng",
                    obligatory: true,
                    isColorFieldWhite: true,
                  ),

                  //address
                  _titleTextField(
                    title: "Địa chỉ cụ thể(số nhà, tên đường)",
                    textController: controller.addressController,
                    isRequired: false,
                  ),

                  //working hours in day
                  _workingHours(
                    context,
                    title: "Thời gian lam việc trong ngày",
                    isRequired: true,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///title and textfield
  ///
  Widget _titleTextField(
      {required String title,
      required TextEditingController textController,
      required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(
              text: title,
              style: Dimensions.fontSizeStyle16().copyWith(
                color: ColorResources.BLACK,
              ),
              children: isRequired == true
                  ? [
                      const TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: ColorResources.RED,
                        ),
                      )
                    ]
                  : [],
            )),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          InputWidget(
            textEditingController: textController,
            isColorFieldWhite: true,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),
        ],
      ),
    );
  }

  ///
  ///working hours in day
  ///
  Widget _workingHours(BuildContext context,
      {required String title, required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          //title
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(
              text: title,
              style: Dimensions.fontSizeStyle16().copyWith(
                color: ColorResources.BLACK,
              ),
              children: isRequired == true
                  ? [
                      const TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: ColorResources.RED,
                        ),
                      )
                    ]
                  : [],
            )),
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          // time range

          Row(
            children: [
              //start
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Text(
                      "Từ",
                      style: Dimensions.fontSizeStyle16(),
                    ),
                    const SizedBox(
                      width: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .3),
                      child: InputWidget(
                        textEditingController: controller.startController,
                        isTime: true,
                        allowEdit: false,
                      ),
                    )
                  ],
                ),
              ),

              //end
              Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Đến",
                        style: Dimensions.fontSizeStyle16(),
                      ),
                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),
                      SizedBox(
                        width: DeviceUtils.getScaledWidth(context, .3),
                        child: InputWidget(
                          textEditingController: controller.startController,
                          isTime: true,
                          allowEdit: false,
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
