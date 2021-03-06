import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account/account_information.dart/account_information_controller.dart';

class AccountInfomationPage extends GetView<AccountInfomationController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      body: GetBuilder(
        builder: (AccountInfomationController controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_3X,
                ),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).padding.top + kToolbarHeight,
                child: GestureDetector(
                  onTap: () {
                    controller.onBack();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.iziSize.width,
                child: avatar(),
              ),
              input(),
            ],
          );
        },
      ),
    );
  }

  Widget avatar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: IZIDimensions.ONE_UNIT_SIZE * 90,
              child: IZIImage(
                ImagesPath.nature,
              ),
            ),
            GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorResources.WHITE,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(
                  IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
                child: const Icon(
                  Icons.camera_alt,
                ),
              ),
            )
          ],
        ),
        userInfo(),
      ],
    );
  }

  Widget userInfo() {
    return Container(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: Column(
        children: [
          IZIText(
            text: "????? Thanh Nh??n",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H4,
              fontWeight: FontWeight.w500,
            ),
          ),
          IZIText(
            text: "01029999999",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w400,
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
      placeHolder: "Nh???p h??? v?? t??n",
      isRequired: true,
      label: "H??? v?? t??n",
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
      allowEdit: false,
    );
  }

  Widget dateOfIssuanceOfIdentityCard() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "12-12-2012",
      label: "Ng??y c???p CMND/CCCD",
      isDatePicker: false,
      width: IZIDimensions.iziSize.width * 0.45,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
      allowEdit: false,
    );
  }

  Widget issuedBy() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Nh???p n??i c???p",
      allowEdit: false,
      label: "N??i c???p",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget birthday() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Ng??y sinh",
      isRequired: true,
      label: "Ng??y sinh",
      isDatePicker: true,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      width: IZIDimensions.iziSize.width * 0.52,
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget gender() {
    return DropDownButton<String>(
      isRequired: true,
      hint: "Gi???i t??nh",
      label: "Gi???i t??nh",
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
      placeHolder: "S??? ??i???n tho???i",
      isRequired: true,
      label: "S??? ??i???n tho???i",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Widget email() {
  //   return IZIInput(
  //     type: IZIInputType.TEXT,
  //     isRequired: true,
  //     placeHolder: "example@gmail.com",
  //     label: "Email (n???u c??)",
  //     borderRadius: IZIDimensions.BLUR_RADIUS_3X,
  //   );
  // }
  // ?????a ??i???m th?????ng tr??
  Widget permanentAddress() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "?????a ??i???m th?????ng tr??",
      label: "?????a ??i???m th?????ng tr??",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // N??i ??? hi???n t???i
  Widget accommodationToday() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "N??i ??? hi???n t???i",
      label: "N??i ??? hi???n t???i",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // Ng??n h??ng
  Widget bank() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "????ng ??",
      label: "Ng??n h??ng",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  // T??i kho???n ng??n h??ng
  Widget bankAccount() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "099999999",
      label: "T??i kho???n ng??n h??ng",
      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
    );
  }

  Widget button(AccountInfomationController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {},
      label: 'C???p nh???p',
    );
  }
}
