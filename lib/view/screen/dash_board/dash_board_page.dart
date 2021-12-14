import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';

class DashBoardPage extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (DashBoardController value) {
        return WillPopScope(
          onWillPop: () => value.onDoubleBack(),
          child: Scaffold(
            backgroundColor: ColorResources.BACKGROUND,
            body: Obx(() => controller.pages[controller.currentIndex.value]['page'] as Widget),
            bottomNavigationBar: bottomNavigator(context),
          ),
        );
      },
    );
  }

  Widget onSelected(BuildContext context, {required String title, required IconData icon, required int index}) {
    return Material(
      child: GestureDetector(
        onTap: () => controller.onChangedPage(index),
        child: SizedBox(
          width: IZIDimensions.iziSize.width / controller.pages.length,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder(
                builder: (DashBoardController controller) => Icon(
                  icon,
                  size: controller.sizeIcon,
                  color: controller.currentIndex.value == index ? ColorResources.CIRCLE_COLOR_BG3 : Colors.grey.withOpacity(0.5),
                ),
              ),
              Obx(
                () => Text(
                  title,
                  style: TextStyle(
                    color: controller.currentIndex.value == index ? ColorResources.CIRCLE_COLOR_BG3 : Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigator(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60,
        width: IZIDimensions.iziSize.width,
        decoration: const BoxDecoration(
          color: ColorResources.BACKGROUND,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List.generate(controller.pages.length, (index) {
              return onSelected(
                context,
                title: controller.pages[index]['label'].toString(),
                icon: controller.pages[index]['icon'] as IconData,
                index: index,
              );
            })
          ],
        ),
      ),
    );
  }
}
