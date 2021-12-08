import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/background/background_four.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/background/background_one.dart';
import 'package:template/base_widget/background/background_otp.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundFour(),
      body: GetBuilder(
        init: SplashController(),
        builder: (SplashController controller) {
          // return SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       ListView.builder(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         itemCount: 10,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Container(
          //             margin: const EdgeInsets.symmetric(
          //               horizontal: IZIDimensions.SPACE_SIZE_1X,
          //               vertical: IZIDimensions.SPACE_SIZE_1X,
          //             ),
          //             padding: const EdgeInsets.symmetric(
          //               vertical: IZIDimensions.SPACE_SIZE_1X,
          //               horizontal: IZIDimensions.SPACE_SIZE_1X,
          //             ),
          //             height: IZIDevice.getScaledHeight(context, .12),
          //             width: IZIDevice.getScaledWidth(context, 1),
          //             decoration: BoxDecoration(
          //               border: Border.all(
          //                 color: ColorResources.GREY,
          //                 width: 2,
          //               ),
          //               boxShadow: [
          //                 BoxShadow(
          //                   offset: const Offset(0, 2),
          //                   color: ColorResources.BLACK.withAlpha(50),
          //                   blurRadius: IZIDimensions.BLUR_RADIUS_2X,
          //                 )
          //               ],
          //               color: ColorResources.WHITE,
          //               borderRadius: BorderRadius.circular(
          //                 IZIDimensions.BORDER_RADIUS_2X,
          //               ),
          //             ),
          //             child: Row(
          //               children: [
          //                 Expanded(
          //                   flex: 2,
          //                   child: Container(
          //                     padding: const EdgeInsets.all(
          //                       IZIDimensions.BLUR_RADIUS_1X,
          //                     ),
          //                     child: SvgPicture.asset(
          //                       "assets/svg/ExportMoney.svg",
          //                       height: 30,
          //                       color: ColorResources.RED,
          //                     ),
          //                   ),
          //                 ),
          //                 Expanded(
          //                   flex: 14,
          //                   child: Container(
          //                     padding: const EdgeInsets.all(
          //                       IZIDimensions.SPACE_SIZE_2X,
          //                     ),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: [
          //                             const Expanded(
          //                               child: Text(
          //                                 "2123123FGS4312",
          //                                 style: TextStyle(
          //                                   fontWeight: FontWeight.w700,
          //                                   fontSize: IZIDimensions.FONT_SIZE_H6,
          //                                 ),
          //                                 maxLines: 1,
          //                                 overflow: TextOverflow.ellipsis,
          //                               ),
          //                             ),
          //                             RichText(
          //                               text: const TextSpan(
          //                                 style: TextStyle(
          //                                   fontSize: IZIDimensions.FONT_SIZE_H6,
          //                                   color: ColorResources.RED,
          //                                 ),
          //                                 children: [
          //                                   TextSpan(
          //                                     text: "20.000",
          //                                   ),
          //                                   TextSpan(text: " VNĐ"),
          //                                 ],
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                         const Expanded(
          //                           child: Text(
          //                             "Nạp tiền thành công",
          //                             style: TextStyle(
          //                               fontSize: IZIDimensions.FONT_SIZE_H6,
          //                             ),
          //                             maxLines: 1,
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                         ),
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                           children: const [
          //                             Expanded(
          //                               child: Text(
          //                                 "26/09/2021 15:30",
          //                                 style: TextStyle(
          //                                   fontSize: IZIDimensions.FONT_SIZE_H6,
          //                                 ),
          //                                 maxLines: 1,
          //                                 overflow: TextOverflow.ellipsis,
          //                               ),
          //                             ),
          //                             Text(
          //                               "Thất bại",
          //                               style: TextStyle(
          //                                 fontSize: IZIDimensions.FONT_SIZE_H6,
          //                                 color: ColorResources.RED,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // );

          return Column(
            children: [
              IconButton(
                onPressed: () => controller.getImage(),
                icon: Icon(
                  Icons.file_upload,
                ),
              ),
              if (controller.fileImage != null)
                Container(
                  height: 200,
                  width: 200,
                  child: Image.file(
                    controller.fileImage!,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const SizedBox(),
              Text(controller.fileImage.toString().replaceAll("null", "Không có")),
            ],
          );
        },
      ),
    );
  }
}
