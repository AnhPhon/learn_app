import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/button_category.dart';

import 'home_controller.dart';

class V2HomePage extends GetView<V2HomeController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<V2HomeController>(
        init: V2HomeController(),
        builder: (V2HomeController controller) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: ColorResources.THEME_DEFAULT,
                ),
                child: Stack(children: [
                  Positioned(
                    top: -20,
                    left: -50,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                            ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -80,
                    right: -20,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                            ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 25,
                    // left: 15,
                    width: size.width,
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                            ),
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_LARGE),
                              child: Image.asset(
                                Images.V4AvatarHome,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                          Text(
                            controller.fullname,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              CupertinoIcons.bell_fill,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10)
                        ],
                      ),
                    ),
                  ),
                ]),
              ),

              // white
              Positioned(
                top: 100,
                child: Container(
                  height: size.height - 180,
                  width: size.width,
                  margin: const EdgeInsets.only(),
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: const BoxDecoration(
                    color: Color(0xffF6F6F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                      topRight: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          // need update widget
                          _needUpdateWidget(),
                          const SizedBox(height: 10),

                          // category box widget
                          _categoryBoxWidget(),

                          // box
                          _box()
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  ///
  /// need update widget
  ///
  Widget _needUpdateWidget() {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x1f000000))]),
      child: Row(
        children: [
          const Text(
            'Bạn cần hoàn thiện hồ sơ',
            style: TextStyle(
              color: Color(0xff4D4D4D),
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
          const Icon(CupertinoIcons.bell, color: Color(0xff4D4D4D)),
          const Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              decoration: const BoxDecoration(
                color: Color(0xff2196F3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text(
                "Cập nhật",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// category box widget
  ///
  Widget _categoryBoxWidget() {
    return SizedBox(
      height: 130,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.contentGrid!.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: controller.contentGrid![index]["onTap"] as Function(),
            child: BtnCategory(
              label: controller.contentGrid![index]["label"].toString(),
              gradient:
                  controller.contentGrid![index]["gradient"] as RadialGradient,
              icon: controller.contentGrid![index]["icon"] as IconData,
            ),
          );
        },
      ),
    );
  }

  ///
  /// box
  ///
  Widget _box() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: const BoxDecoration(
            color: Color(0xff2196F3),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            children: const [
              SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.work,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Text(
                'Kết quả báo giá',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
