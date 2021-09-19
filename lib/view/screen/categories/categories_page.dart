import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/view/screen/categories/categories_controller.dart';
import 'package:template/view/screen/categories/component/category_item.dart';

class CategoriesPage extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(
        init: CategoriesController(),
        builder: (CategoriesController value) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Danh mục",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: double.infinity,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: const BoxDecoration(
                    color: Color(0xffF5F5FA),
                  ),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: controller.categoriesName.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              controller.changeSelectedIndex(index);
                            },
                            child: CategoryItem(
                              title: controller.categoriesName[index],
                              icon: const Icon(Icons.person),
                              isSelected:
                                  controller.categorySelectedIndex == index,
                            ));
                      }),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledWidth(context, 0.05),
                        vertical: DeviceUtils.getScaledWidth(context, 0.05)),
                    alignment: Alignment.center,
                    height: DeviceUtils.getScaledHeight(context, 0.5),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: ColorResources.GREY),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        SizedBox(
                            height: DeviceUtils.getScaledHeight(context, 0.02)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledHeight(context, 0.03),
                              vertical:
                                  DeviceUtils.getScaledWidth(context, 0.04)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Chi tiết",
                                style: TextStyle(fontSize: 20),
                              ),
                              GestureDetector(
                                onTap: () => controller.onBtnDetailClick(),
                                child: const Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: controller.myCategories.length,
                              itemBuilder: (BuildContext context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/Untitled.png")),
                                      ),
                                    ),
                                    SizedBox(
                                        height: DeviceUtils.getScaledHeight(
                                            context, 0.01)),
                                    Text(controller.categoriesName[
                                            controller.categorySelectedIndex] +
                                        controller.myCategories[index]['name']
                                            .toString()),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
