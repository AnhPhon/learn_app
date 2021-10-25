import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v1-customer/account/mail/mail_controller.dart';

class V1MailPage extends GetView<V1MailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1MailController>(
      init: V1MailController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: BoxShadowWidget(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            margin: const EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  Text(
                    "liên hệ tư vấn".toUpperCase(),
                    style: Dimensions.fontSizeStyle20w600(),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //name
                  InputWidget(
                    hintText: "Họ và tên của bạn",
                    textEditingController: controller.nameController,
                    width: 1,
                    textInputAction: TextInputAction.next,
                  ),

                  //phone
                  InputWidget(
                    hintText: "Số điện thoại",
                    textEditingController: controller.phoneController,
                    width: 1,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),

                  //content
                  InputWidget(
                    hintText: "Nội dung cần tư vấn",
                    textEditingController: controller.contentController,
                    width: 1,
                    maxLine: 5,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  BtnCustom(
                    onTap: () => controller.onBtnSendClick(context),
                    color: ColorResources.PRIMARY,
                    text: "Gửi liên hệ",
                    width: DeviceUtils.getScaledWidth(context, .8),
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
}
