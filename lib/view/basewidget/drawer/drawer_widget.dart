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


  @override
  Widget build(BuildContext context) {
    return GetBuilder<dr.DrawerController>(
      init: dr.DrawerController(),
      builder: (dr.DrawerController controller) {
        return Stack(
          children: [
            Container(
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
                        ...menuList(context,controller.menu),
                      ],
                    ),
                    const Divider(
                      color: ColorResources.GREY,
                    ),
                    // Thông tin liên hệ
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...contact(context,controller.contact),
                      ],
                    ),
                    const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: IconButton(onPressed: (){
                Get.back();
              }, icon: const Icon(
                Icons.cancel,
                color: ColorResources.RED,
              )),
            ),
          ],
        );
      },
    );
  }

  ///
  /// Menu
  ///
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

  /// 
  /// Thông tin liên hệ
  /// 
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

  /// 
  /// Header
  /// 
  Widget header(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
      height: DeviceUtils.getScaledHeight(context, 0.25),
      decoration: const BoxDecoration(
        color: ColorResources.GREEN,
        image: DecorationImage(image: AssetImage(Images.background_draw),fit: BoxFit.fill)
      ),
      child: Row(
        children: [
          SizedBox(
            height: Dimensions.AVATAR_SQUARE_SIZE_DEFAULT,
            width:  Dimensions.AVATAR_SQUARE_SIZE_DEFAULT,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(Images.logo_fss, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
            child: Stack(
              children: [
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
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
                      Text("Five Star System "),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.w500,
                    color: ColorResources.BLACK
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Five Star System "),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  
}





