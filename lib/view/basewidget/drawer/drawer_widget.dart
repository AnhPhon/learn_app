import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/menu.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/drawer/drawer_controller.dart' as dr;

class DrawerWidget extends GetView<dr.DrawerController> {
  const DrawerWidget({Key? key}) : super(key: key);

  /// Menu
  List<Widget> menuList(BuildContext context, List<Menu> menu){
      final menuList = menu.map((item){
      return GestureDetector(
        onTap: ()=> item.onPress(),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text(item.title, style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE
            ),),
          )
      );
      }).toList(); 
      return menuList;
  }

  /// Thông tin liên hệ
  List<Widget> contact(BuildContext context, List<String> menu){
      final menuList = menu.map((item){
      return GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Text(item, style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w700
            ),),
          )
      );
      }).toList(); 
      return menuList;
  }


  Widget header(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
      height: DeviceUtils.getScaledHeight(context, 0.25),
      decoration: const BoxDecoration(
        color: ColorResources.GREEN,
        image: DecorationImage(image: AssetImage(Images.admin_background),fit: BoxFit.fill)
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 10),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(Images.logo_image),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
              child: Stack(
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w500,
                      foreground: Paint()
                        ..strokeWidth = 3
                        ..color = ColorResources.WHITE
                        ..style = PaintingStyle.stroke,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("KH, Phạm Văn Tuấn"),
                        Text("MS: 0987321223"),
                        Text("Ceo: Công ty tiến lợi")
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w500,
                      color: ColorResources.BLACK
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("KH, Phạm Văn Tuấn"),
                        Text("MS: 0987321223"),
                        Text("Ceo: Công ty tiến lợi")
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<dr.DrawerController>(
      init: dr.DrawerController(),
      builder: (dr.DrawerController controller) {
        return Container(
          alignment: Alignment.topLeft,
          height: DeviceUtils.getScaledHeight(context,1),
          width: DeviceUtils.getScaledWidth(context,0.8),
          decoration: const BoxDecoration(
            color: ColorResources.WHITE
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //header
                header(context),

                // Menu 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...menuList(context,controller.menu1),
                  ],
                ),
                const Divider(
                  color: ColorResources.GREY,
                ),
                // Thông tin liên hệ
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...contact(context,controller.menu2),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}





