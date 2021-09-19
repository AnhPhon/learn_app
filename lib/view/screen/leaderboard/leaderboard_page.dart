import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/home_page/info.dart';
// template
import 'package:template/data/template/categories.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'leaderboard_controller.dart';

class LeaderBoardPage extends GetView<LeaderBoardController> {
  @override
  Widget build(BuildContext context) {
    const String title = "Bảng xếp hạng";

    return GetBuilder<LeaderBoardController>(
        init: LeaderBoardController(),
        builder: (LeaderBoardController value) {
          return Scaffold(
              backgroundColor: ColorResources.WHITE,
              appBar: AppBar(
                title: const Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF27272A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                centerTitle: true,
                shadowColor: const Color(0x3F000000),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledSize(context, 0.05)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: DeviceUtils.getScaledSize(context, 0.1)),
                      ...List.generate(
                        10,
                        (index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.onChartsClick();
                              },
                              child: Container(
                                height:
                                    DeviceUtils.getScaledSize(context, 0.25),
                                padding: EdgeInsets.all(
                                    DeviceUtils.getScaledSize(context, 0.025)),
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ColorResources.GREY),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Title ${index + 1}",
                                                style: Dimensions
                                                    .fontSizeStyle18w600()),
                                            Text("subtitle ${index + 1}",
                                                style: Dimensions
                                                        .fontSizeStyle16w600()
                                                    .copyWith(
                                                        color: ColorResources
                                                            .GREY)),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: Image.asset(
                                            "assets/images/trang.png",
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    DeviceUtils.getScaledSize(context, 0.04)),
                          ],
                        ),
                      ).toList(),
                    ],
                  ),
                ),
              ));
        });
  }
}
