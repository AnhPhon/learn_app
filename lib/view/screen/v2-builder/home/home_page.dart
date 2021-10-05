import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

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
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    color: Color(0xffF6F6F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: Column(
                        children: [],
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
}
