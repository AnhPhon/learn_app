import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/background/background_auth.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_file.dart';
import 'package:template/base_widget/izi_glass.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/signup/signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GetBuilder(
        init: SignUpController(),
        builder: (SignUpController controller) {
          return Container(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IZIGlass(
                  width: IZIDimensions.iziSize.width * 0.9,
                  height: IZIDimensions.iziSize.height * 0.8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          label(),
                          phone(),
                          accountInput(),
                          email(),
                          password(),
                          address(),
                          identityCardNumber(),
                          dateOfIssuanceOfIdentityCard(),
                          issuedBy(),
                          avatar(),
                          citizenID(),
                          other(
                            controller,
                          ),
                          button(
                            controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget label() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: IZIText(
        text: "????ng k??",
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H4,
          fontWeight: FontWeight.bold,
          color: ColorResources.WHITE,
        ),
      ),
    );
  }

  Widget phone() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: "S??? ??i???n tho???i",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        Icons.phone,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget accountInput() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Nh???p h??? v?? t??n",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        CupertinoIcons.person_crop_circle,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget email() {
    return IZIInput(
      type: IZIInputType.EMAIL,
      placeHolder: "Email",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.next,
      prefixIcon: Icon(
        CupertinoIcons.mail,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget address() {
    return IZIInput(
      type: IZIInputType.TEXT,
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.next,
      placeHolder: "Nh???p ?????a ch???",
      prefixIcon: Icon(
        Icons.location_city,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  // CMND
  Widget identityCardNumber() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "CCCD/CMND",
      textInputAction: TextInputAction.next,
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      prefixIcon: Icon(
        CupertinoIcons.person_crop_rectangle,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  // NG??y c???p CMND
  Widget dateOfIssuanceOfIdentityCard() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Ng??y c???p CMND/CCCD",
      textInputAction: TextInputAction.next,
      isDatePicker: true,
      iziPickerDate: IZIPickerDate.CUPERTINO,
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      prefixIcon: Icon(
        CupertinoIcons.calendar,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
      suffixIcon: const SizedBox(),
    );
  }

  // N??i c??ps
  Widget issuedBy() {
    return IZIInput(
      type: IZIInputType.TEXT,
      isRequired: true,
      placeHolder: "Nh???p n??i c???p",
      textInputAction: TextInputAction.next,
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      prefixIcon: Icon(
        Icons.place,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget password() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: "Nh???p m???t kh???u",
      borderRadius: IZIDimensions.BLUR_RADIUS_4X,
      textInputAction: TextInputAction.done,
      prefixIcon: Icon(
        Icons.lock,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
      suffixIcon: Icon(
        Icons.fingerprint,
        size: IZIDimensions.ONE_UNIT_SIZE * 40,
        color: ColorResources.GREEN,
      ),
    );
  }

  Widget button(SignUpController controller) {
    return IZIButton(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_3X,
      ),
      onTap: () {
        controller.onToPageVerify();
      },
      label: '????ng k??',
    );
  }

  Widget avatar() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IZIFile(
            width: IZIDimensions.iziSize.width * 0.24,
            height: IZIDimensions.iziSize.width * 0.24,
            imageSource: ImageSource.camera,
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IZIText(
                text: "Ch???p ???nh khu??n m???t ?????i di???n  c???a b???n ",
              ),
              IZIText(
                text: "*",
                style: TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget citizenID() {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              IZIFile(
                width: IZIDimensions.iziSize.width * 0.24,
                height: IZIDimensions.iziSize.width * 0.24,
                imageSource: ImageSource.camera,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              IZIFile(
                width: IZIDimensions.iziSize.width * 0.24,
                height: IZIDimensions.iziSize.width * 0.24,
                imageSource: ImageSource.camera,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IZIText(
                text: " Ch???p CMND/CCCD m???t tr?????c/ m???t sau",
              ),
              IZIText(
                text: "*",
                style: TextStyle(
                  color: ColorResources.RED,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget other(SignUpController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: const IZIText(
                text: "???? c?? t??i kho???n?",
              ),
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_1X,
            ),
            GestureDetector(
              onTap: () {
                controller.onToPageLogin();
              },
              child: const IZIText(
                text: "????ng nh???p",
                style: TextStyle(
                  color: ColorResources.CIRCLE_COLOR_BG3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
