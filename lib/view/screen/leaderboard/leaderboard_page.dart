import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'leaderboard_controller.dart';

class LeaderBoardPage extends GetView<LeaderBoardController> {
  @override
  Widget build(BuildContext context) {
    const String title = "Bảng xếp hạng";

    return Scaffold(
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
        body: GetBuilder<LeaderBoardController>(
            init: LeaderBoardController(),
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return controller.contextList.isEmpty
                  ? const Center(
                      child: Text("Chưa có dữ liệu về bảng xếp hạng!"))
                  : Column(
                      children: [
                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.07)),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.contextList.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.onChartsClick(i);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: DeviceUtils.getScaledSize(
                                              context, 0.035)),
                                      padding: EdgeInsets.all(
                                          DeviceUtils.getScaledSize(
                                              context, 0.025)),
                                      decoration: BoxDecoration(
                                        color: ColorResources.WHITE,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 2,
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2, // Shadow position
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  child:
                                                      FadeInImage.assetNetwork(
                                                    placeholder:
                                                        Images.placeholder,
                                                    image: controller
                                                        .contextList[i]
                                                        .thumbnail!,
                                                    fit: BoxFit.fill,
                                                    imageErrorBuilder:
                                                        (c, o, s) =>
                                                            Image.asset(
                                                      Images.placeholder,
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          Expanded(
                                              flex: 7,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      DeviceUtils.getScaledSize(
                                                          context, 0.025),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        controller
                                                            .contextList[i]
                                                            .name!,
                                                        maxLines: 2,
                                                        style: Dimensions
                                                            .fontSizeStyle18w600()),
                                                    SizedBox(
                                                        height: DeviceUtils
                                                            .getScaledSize(
                                                                context, 0.01)),
                                                    Text(
                                                        controller
                                                            .contextList[i]
                                                            .content!,
                                                        maxLines: 3,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: Dimensions
                                                                .fontSizeStyle16w600()
                                                            .copyWith(
                                                                color:
                                                                    ColorResources
                                                                        .GREY)),
                                                    SizedBox(
                                                        height: DeviceUtils
                                                            .getScaledSize(
                                                                context, 0.01)),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Từ ${DateConverter.isoStringToLocalDateFull(controller.contextList[i].beginContext!)}",
                                                            style: Dimensions
                                                                    .fontSizeStyle14()
                                                                .copyWith()),
                                                        Text(
                                                            "đến ${DateConverter.isoStringToLocalDateFull(controller.contextList[i].endContext!)}",
                                                            style: Dimensions
                                                                    .fontSizeStyle14()
                                                                .copyWith()),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: DeviceUtils.getScaledSize(
                                          context, 0.07)),
                                ],
                              );
                            }),
                      ],
                    );
            }));
  }
}
