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
import 'package:template/view/screen/account/capital_contribution/authorized_person/authorized_person_controller.dart';

class AuthorizedPersonPage extends GetView<AuthorizedPersonController> {
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
        builder: (AuthorizedPersonController controller) {
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
            text: "Người được uỷ quyền",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H5,
              fontWeight: FontWeight.bold,
            ),
          ),
          IZIText(
            text: "Điền các thông tin bên dưới cho người được ủy quyền",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
              color: ColorResources.RED,
            ),
          ),
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
          name(),

          relationship(),

          identityCardNumber(),

          dateOfIssuanceOfIdentityCard(),

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
          // bank(),
          // bankAccount(),
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

   Widget name() {
    return DropDownButton<String>(
      isRequired: true,
      hint: "Chọn người uỷ quyền",
      label: "Họ và tên",
      data: controller.authorizedPersons,
      value: controller.authorizedPerson,
      onChanged: (val) {
        controller.onChangedAuthorizedPerson(val!);
      },
    );
  }

  // quan hệ
  Widget relationship() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Quan hệ",
      isRequired: true,
      label: "Quan hệ",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // CMND
  Widget identityCardNumber() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "12-12-2012",
      label: "CMND/CCCD",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // NGày cấp CMND
  Widget dateOfIssuanceOfIdentityCard() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "12-12-2012",
      label: "Ngày cấp CMND/CCCD",
      isDatePicker: true,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Nơi câps
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
      placeHolder: "Địa chỉ",
      label: "Địa chỉ",
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

  Widget button(AuthorizedPersonController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onToContactInfomation();
      },
      label: 'Tiếp tục',
    );
  }
}
