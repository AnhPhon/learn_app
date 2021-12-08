import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/background/background_auth.dart';
import 'package:template/base_widget/background/background_four.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Thanh toán",
        callbackSearch: (val) {
          print("Search: ${val}");
        },
      ),
      body: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          return Column(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return IZICard(
                    title: "Sâm dây để làm mới",
                    subtitle: "đ100.000",
                    urlImage: 'https://i.pinimg.com/originals/32/b8/36/32b836c010f35024aa63c8a7d7d97d58.jpg',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("đ50.000"),
                        Text("đã bán 180"),
                      ],
                    ),
                    titleStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: IZIDimensions.FONT_SIZE_H4,
                    ),
                  );
                },
                itemCount: 2,
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
                width: IZIDimensions.SPACE_SIZE_3X,
                onTap: () {},
              ),
              IZIButton(
                icon: Icons.ac_unit,
                label: "Đồng ý thanh toán",
                width: IZIDimensions.SPACE_SIZE_3X,
                onTap: () {},
                type: IZIButtonType.DEFAULT,
                isEnabled: false,
              ),
              IZIButton(
                icon: Icons.ac_unit,
                label: "Tài khoản",
                width: IZIDimensions.SPACE_SIZE_3X,
                onTap: () {},
                type: IZIButtonType.OUTLINE,
                isEnabled: true,
              ),
              IZIButton(
                icon: Icons.home,
                label: "Trang chủ",
                width: IZIDimensions.SPACE_SIZE_3X,
                onTap: () {
                  controller.pickImages();
                },
                type: IZIButtonType.OUTLINE,
                isEnabled: controller.isButtonActive,
                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                margin: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
              ),
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 400,
                width: IZIDimensions.ONE_UNIT_SIZE * 400,
                child: IZIImage.file(controller.file),
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
