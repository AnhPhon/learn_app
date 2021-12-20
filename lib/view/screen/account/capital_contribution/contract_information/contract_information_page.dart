import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/account/capital_contribution/contract_information/contract_information_controller.dart';

class ContractInformationPage extends GetView<ContractInformationController> {
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
        builder: (ContractInformationController controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title(),
              input(),
            ],
          );
        },
      ),
    );
  }

  Widget title() {
    return Container(
      margin: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_4X,
      ),
      width: IZIDimensions.iziSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IZIText(
            text: "Thông tin hợp đồng",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H5,
              fontWeight: FontWeight.bold,
            ),
          ),
          // IZIText(
          //   text: "Điền các thông tin bên dưới cho người được ủy quyền",
          //   style: TextStyle(
          //     fontSize: IZIDimensions.FONT_SIZE_SPAN,
          //     color: ColorResources.RED,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget input() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          contractType(),
          contractTypeName(),
          numberOfContracts(),
          month(),
          value(),
          interestRate(),
          profitAmount(),
          button(controller),
        ],
      ),
    );
  }

  // Tên
  // Widget name() {
  //   return IZIInput(
  //     type: IZIInputType.TEXT,
  //     placeHolder: "nhập họ và tên",
  //     isRequired: true,
  //     label: "Họ và tên",
  //     borderRadius: IZIDimensions.BLUR_RADIUS_3X,
  //   );
  // }

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

  // quan hệ
  Widget contractTypeName() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Tên loại hợp đồng",
      isRequired: true,
      label: "Tên loại hợp đồng",
      allowEdit: false,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Số lượng hợp đồng
  Widget numberOfContracts() {
    return IZIInput(
      type: IZIInputType.NUMBER,
      isRequired: true,
      placeHolder: "Nhập số lượng hợp đồng",
      label: "Nhập số lượng hợp đồng",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Tháng
  Widget month() {
    return IZIInput(
      type: IZIInputType.NUMBER,
      isRequired: true,
      placeHolder: "12 tháng",
      label: "Tháng",
      allowEdit: false,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Giá trị
  Widget value() {
    return IZIInput(
      type: IZIInputType.PRICE,
      isRequired: true,
      placeHolder: "422.322.000",
      label: "Giá trị",
      allowEdit: false,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Lãi suất
  Widget interestRate() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "0.5",
      isRequired: true,
      label: "Lãi/suất",
      allowEdit: false,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Số tiền lãi
  Widget profitAmount() {
    return IZIInput(
      type: IZIInputType.PRICE,
      placeHolder: "100.000",
      isRequired: true,
      allowEdit: false,
      label: "Số tiền lãi",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget button(ContractInformationController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onToContractTerm();
      },
      label: 'Tiếp tục',
    );
  }
}
