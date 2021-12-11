import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_four.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/base_widget/izi_file.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_otp.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';
import 'package:ticket_material/ticket_material.dart';

class SplashPage extends GetView<SplashController> {
  SplashPage({Key? key}) : super(key: key);
  List<String> data = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "m"];
  final keyList = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundOtp(),
      appBar: const IZIAppBar(
        title: "Splash Page",
      ),
      body: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Column(
            children: [
              IZIFile.file(
                height: 70,
                width: 500,
                onFile:(val){
                  print("abc");
                  print("Url file ${val}");
                }
              ),
              IZIFile(

              ),
              IZIOtp(
                lable: "Xác thực tài khoản",
                content: "Mã xác thực sẽ được gửi đến số điện thoại của bạn",
                codeLength: 4,
                countDown: 10,
                isEnabled: true,
                onTapSendSMS: (){},
              ),
              IZIInput(
                placeHolder: "100",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.INCREMENT,
                isBorder: true,
                max: 50,
                min: 10,
                onChanged: (val) {
                  print(val);
                },
                width: IZIDimensions.ONE_UNIT_SIZE * 500,
                disbleError: true,
              ),
              IZIInput(
                label:"Tiền",
                placeHolder: "Tiền",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.PRICE,
                onChanged: (val) {
                  print(val);
                },
                width: IZIDimensions.ONE_UNIT_SIZE * 500,
                disbleError: true,
              ),
              IZIListView(
                itemCount: 6,
                physics: AlwaysScrollableScrollPhysics(),
                action: Text(
                  "Xem thêm",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                  ),
                ),
                label: "Danh mục",
                scrollDirection: Axis.horizontal,
                padding: IZIDimensions.ONE_UNIT_SIZE * 10,
                builder: (index) {
                  return Container(
                    padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    child: IZICard(
                      urlImage: "https://i.pinimg.com/originals/32/b8/36/32b836c010f35024aa63c8a7d7d97d58.jpg",
                      row1Left: "Đây là cái label label label label",
                      // icon: Icons.access_alarm,
                      colorBG: ColorResources.CIRCLE_COLOR_BG3,
                      cardType: IZICardType.CARD_CIRCLE,
                    ),
                  );
                },
              ),

              IZICard(
                urlImage: ImagesPath.capital_contribution_week,
                row1Left: "1 tuần 1 tuần1 tuần1 tuần1 tuần1 tuần1 tuần1 tuần",
                row2Left: "Lãi suất 12%/năm 1 tuần1 tuần1 tuần1 tuần1 tuần1 tuần1 tuần",
                cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
                valRadio: 1,
                groupValue: controller.groupVal,
                onChanged: (val) {
                  controller.onRadioChanged(1);
                },
              ),
              IZICard(
                urlImage: 'https://i.ytimg.com/vi/XgdHlx0ugRA/maxresdefault.jpg',
                row1Left: "1 tháng",
                row2Left: "Lãi suất 22%/năm",
                cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
                valRadio: 2,
                groupValue: controller.groupVal,
                onChanged: (val) {
                  controller.onRadioChanged(2);
                },
              ),
              IZICard(
                // TODO: Thêm right text
                urlImage: ImagesPath.capital_contribution_year,
                row1Left: "2 năm",
                row1Right: "Lãi suất 42%/năm Lãi suất 42%/năm",
                row2Left: "Lãi suất 42%/năm Lãi suất 42%/năm",
                row2Right: "Lãi suất 42%/năm",
                cardType: IZICardType.CARD_CAPITAL_CONTRIBUTION,
                // valRadio: 3,
                // groupValue: controller.groupVal,
                // onChanged: (val){
                //   controller.onRadioChanged(3);
                // },
              ),

              IZICard(
                urlImage: "",
                row1Left: "Nguyễn Huỳnh Test",
                row2Left: "0123434737433",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.DONE,
                cardType: IZICardType.CARD_CONTACT,
                statusMoney: IZIStatusMoney.DRAW,
                colorBG: ColorResources.GREY,
                title: "A",
                actions: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.message,
                      size: IZIDimensions.ONE_UNIT_SIZE * 50,
                      color: ColorResources.CIRCLE_COLOR_BG4,
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.ONE_UNIT_SIZE * 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.phone_forwarded,
                      size: IZIDimensions.ONE_UNIT_SIZE * 50,
                      color: ColorResources.CIRCLE_COLOR_BG4,
                    ),
                  ),
                ],
              ),
              IZICard(
                urlImage: "",
                row1Left: "Nguyễn Huỳnh Test",
                row2Left: "0123434737433",
                statusPayment: IZIStatusPayment.DONE,
                cardType: IZICardType.CARD_CONTACT,
                statusMoney: IZIStatusMoney.DRAW,
                colorBG: ColorResources.GREY,
                title: "A",
              ),
              // Container(
              //   height: IZIDimensions.ONE_UNIT_SIZE * 400,
              //   width: IZIDimensions.ONE_UNIT_SIZE * 400,
              //   child: IZIImage.icon(Icons.ac_unit_outlined),
              // ),
              IZICard(
                row1Left: "label",
                cardType: IZICardType.CARD_CIRCLE,
                colorBG: ColorResources.CIRCLE_COLOR_BG3,
              ),
              IZICard(
                urlImage: "",
                row1Left: "434323423FĐGJ3434F",
                row1Right: "10000000000000000",
                row2Left: "Thanh toán tháng 12 Thanh toán tháng 12 Thanh toán tháng 12",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.DONE,
                cardType: IZICardType.CARD_PAYMENT,
                statusMoney: IZIStatusMoney.DRAW,
              ),

              IZICard(
                // TODO: Right text maxline 1 line
                // TODO: Chuyển border sang boxShadown
                urlImage: "",
                row1Left: "434323423FĐGJ3434F",
                row1Right: "10000000000000000",
                row2Left: "Thanh toán tháng 12 Thanh toán tháng 12 Thanh toán tháng 12",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.AWAIT,
                cardType: IZICardType.CARD_PAYMENT,
                statusMoney: IZIStatusMoney.RECHARGE,
              ),

              IZICard(
                urlImage: "",
                row1Left: "434323423FĐGJ3434F",
                row1Right: "10000000000000000",
                row2Left: "Thanh toán tháng 12 Thanh toán tháng 12 Thanh toán tháng 12",
                row3Left: "12-12-2021",
                statusPayment: IZIStatusPayment.FAIL,
                cardType: IZICardType.CARD_PAYMENT,
                statusMoney: IZIStatusMoney.DRAW,
              ),

              IZIInput(
                placeHolder: "Double",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.DOUBLE,
              ),
              IZIInput(
                placeHolder: "Email",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.EMAIL,
              ),
              IZIInput(
                placeHolder: "Number",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.NUMBER,
              ),
              IZIInput(
                placeHolder: "Password",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.PASSWORD,
              ),
              IZIInput(
                placeHolder: "Phone",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.PHONE,
              ),
              IZIInput(
                placeHolder: "Price",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.PRICE,
              ),
              IZIInput(
                placeHolder: "Text",
                allowEdit: true,
                isRequired: true,
                type: IZIInputType.TEXT,
              ),
              IZIButton(
                icon: Icons.ac_unit,
                label: "Từ chối",
                onTap: () {
                  IZIDialog.showDialog(lable: "Thông báo", onConfirm: () {}, onCancel: () {}, description: 'Miêu tả');
                },
              ),
              IZIButton(
                icon: Icons.ac_unit,
                label: "Đồng ý thanh toán",
                onTap: () {},
                type: IZIButtonType.DEFAULT,
                isEnabled: false,
              ),
              IZIButton(
                icon: Icons.ac_unit,
                label: "Tài khoản",
                onTap: () {},
                type: IZIButtonType.OUTLINE,
                isEnabled: true,
              ),
              IZIButton(
                icon: Icons.home,
                label: "Trang chủ",
                onTap: () {
                  controller.getImage();
                },
                type: IZIButtonType.OUTLINE,
                isEnabled: controller.isButtonActive,
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
              ),
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 400,
                width: IZIDimensions.ONE_UNIT_SIZE * 400,
                child: IZIImage.file(controller.fileImage),
              ),
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 400,
                width: IZIDimensions.ONE_UNIT_SIZE * 400,
                color: Colors.black,
                child: IZIImage(
                  "https://i.pinimg.com/originals/32/b8/36/32b836c010f35024aa63c8a7d7d97d58.jpg",
                  height: IZIDimensions.ONE_UNIT_SIZE * 100,
                  width: IZIDimensions.ONE_UNIT_SIZE * 100,
                ),
              ),
              IZIImage(
                "",
                fit: BoxFit.fill,
                height: IZIDimensions.ONE_UNIT_SIZE * 300,
                width: IZIDimensions.ONE_UNIT_SIZE * 300,
              ),
              IZIImage("https://raw.githubusercontent.com/dnfield/flutter_svg/7d374d7107561cbd906d7c0ca26fef02cc01e7c8/example/assets/flutter_logo.svg"),
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 500,
                width: IZIDimensions.ONE_UNIT_SIZE * 500,
                color: Colors.red,
                child: IZIImage(
                  "assets/svg/410.svg",
                  // height: IZIDimensions.ONE_UNIT_SIZE * 300,
                  // width: IZIDimensions.ONE_UNIT_SIZE * 300,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
