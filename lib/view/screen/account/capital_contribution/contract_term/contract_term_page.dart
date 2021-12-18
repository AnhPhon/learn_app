import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/account/capital_contribution/contract_term/contract_term_controller.dart';

class ContractTermPage extends GetView<ContractTermController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Góp vốn",
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
      ),
      body: GetBuilder(
        builder: (ContractTermController controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title(),
              input(context, controller: controller),
            ],
          );
        },
      ),
    );
  }

  Widget title({String? lable, EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin ??
          EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_4X,
          ),
      width: IZIDimensions.iziSize.width,
      child: IZIText(
        text: lable ?? "Thời hạn hợp đồng",
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget input(BuildContext context, {required ContractTermController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          startDate(),
          title(
            lable: "Đối ứng",
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_4X,
            ),
          ),
          contractType(),
          reciprocalAmount(),

          sign(context, controller: controller),

          button(controller),
        ],
      ),
    );
  }

  // quan hệ
  Widget startDate() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Chọn ngày bắt đầu",
      isRequired: true,
      isDatePicker: true,
      label: "Ngày bắt đầu",
      allowEdit: true,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // loại hợp đồng
  Widget contractType() {
    return DropDownButton<String>(
      isRequired: true,
      hint: "Chọn loại hợp đồng",
      label: "Loại hợp đồng",
      data: controller.contractTypes,
      value: controller.contractType,
      onChanged: (val) {
        controller.onChangedContractType(val!);
      },
    );
  }

  // số tiền đối ứng
  Widget reciprocalAmount() {
    return IZIInput(
      type: IZIInputType.NUMBER,
      isRequired: true,
      placeHolder: "2.000.000",
      label: "Số tiền đối ứng",
      allowEdit: false,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Ký tên
  Widget sign(BuildContext context, {required ContractTermController controller}) {
    return Container(
      height: IZIDimensions.ONE_UNIT_SIZE * 300,
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_3X,
        ),
        boxShadow: IZIOther().boxShadow,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              IZIDimensions.BLUR_RADIUS_3X,
            ),
            child: Signature(
              height: IZIDimensions.ONE_UNIT_SIZE * 300,
              controller: controller.controllerSign,
              backgroundColor: ColorResources.WHITE,
            ),
          ),
          Container(
            margin: EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_1X,
            ),
            padding: EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_1X,
            ),
            decoration: BoxDecoration(
              color: ColorResources.GREY,
              borderRadius: BorderRadius.circular(
                IZIDimensions.BLUR_RADIUS_3X,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                controller.onClearSign();
              },
              child: const Icon(
                Icons.sync,
                color: ColorResources.WHITE,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(ContractTermController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onConfirm();
      },
      label: 'Xác nhận',
    );
  }
}
