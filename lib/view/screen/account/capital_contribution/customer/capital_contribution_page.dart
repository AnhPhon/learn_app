import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/account/capital_contribution/customer/capital_contribution_controller.dart';

class CapitalContributionPage extends GetView<CapitalContributionController> {
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
        builder: (CapitalContributionController controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_4X,
                ),
                width: IZIDimensions.iziSize.width,
                child: IZIText(
                  text: "Khách hàng",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              input(),
            ],
          );
        },
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
          name(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              identityCardNumber(),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              dateOfIssuanceOfIdentityCard(),
            ],
          ),

          issuedBy(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              birthday(),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              gender(),
            ],
          ),
          phone(),
          // email(),
          permanentAddress(),
          accommodationToday(),
          bank(),
          bankAccount(),
          button(controller),
        ],
      ),
    );
  }

  Widget name() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "nhập họ và tên",
      isRequired: true,
      label: "Họ và tên",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget identityCardNumber() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "12-12-2012",
      label: "\nCMND/CCCD",
      width: IZIDimensions.iziSize.width * 0.43,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget dateOfIssuanceOfIdentityCard() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "12-12-2012",
      label: "Ngày cấp CMND/CCCD",
      isDatePicker: true,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      width: IZIDimensions.iziSize.width * 0.45,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget issuedBy() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Nhập nơi cấp",
      label: "Nơi cấp",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget birthday() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Ngày sinh",
      isRequired: true,
      label: "Ngày sinh",
      isDatePicker: true,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      width: IZIDimensions.iziSize.width * 0.52,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget gender() {
    return DropDownButton<String>(
      isRequired: true,
      hint: "Giới tính",
      label: "Giới tính",
      width: IZIDimensions.iziSize.width * 0.35,
      data: controller.genders,
      value: controller.gender,
      onChanged: (val) {
        controller.onChangedGender(val!);
      },
    );
  }

  Widget phone() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Số điện thoại",
      isRequired: true,
      label: "Số điện thoại",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Widget email() {
  //   return IZIInput(
  //     type: IZIInputType.TEXT,
  //     isRequired: true,
  //     placeHolder: "example@gmail.com",
  //     label: "Email (nếu có)",
  //     borderRadius: IZIDimensions.BLUR_RADIUS_3X,
  //   );
  // }
  // Địa điểm thường trú
  Widget permanentAddress() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Địa điểm thường trú",
      label: "Địa điểm thường trú",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Nơi ở hiện tại
  Widget accommodationToday() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Nơi ở hiện tại",
      label: "Nơi ở hiện tại",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Ngân hàng
  Widget bank() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Đông Á",
      label: "Ngân hàng",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Tài khoản ngân hàng
  Widget bankAccount() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "099999999",
      label: "Tài khoản ngân hàng",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget button(CapitalContributionController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onToCapitalContributionCustomer();
      },
      label: 'Tiếp tục',
    );
  }
}
