import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/tax/tax_controller.dart';

class V1TaxPage extends GetView<V1TaxController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1TaxController>(
      init: V1TaxController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Column(
            children: [
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
              ),

              //input
              InputWidget(
                label: "Mã số thuế",
                labelBold: true,
                obligatory: true,
                width: .9,
                textEditingController: controller.taxController,
                hintText: "Nhập mã số thuế",
                allowEdit: controller.isUpdate == true,
                fillColor: ColorResources.WHITE,
                padding: const EdgeInsets.only(
                  bottom: Dimensions.PADDING_SIZE_DEFAULT,
                ),
              ),

              //upload image
              _uploadImage(context, controller),

              const Spacer(),

              //btn
              if (controller.isUpdate == true)
                BtnCustom(
                  onTap: () => controller.onBtnDoneClick(),
                  color: ColorResources.PRIMARY,
                  text: "Hoàn thành",
                  width: DeviceUtils.getScaledWidth(context, .9),
                )
              else
                BtnCustom(
                  onTap: () => controller.onBtnUpdate(),
                  color: ColorResources.PRIMARY,
                  text: "Chỉnh sửa",
                  width: DeviceUtils.getScaledWidth(context, .9),
                ),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(BuildContext context, V1TaxController controller) {
    return ImageListHorizontalAdd(
      pickImage:
          controller.isUpdate == true ? () => controller.pickImages() : () {},
      label: "Tải hình ảnh bản cứng",
      labelBold: true,
      obligatory: true,
      imageFileList: controller.dangKyThueRequest.hinhAnhs ?? [],
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
    );
  }
}
