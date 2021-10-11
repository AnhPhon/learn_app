import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/three_image_box.dart';
import 'package:template/view/screen/v2-builder/account/profile/register_and_commit/cam_ket_thue/cam_ket_thue_controller.dart';

class V2CamketThuePage extends GetView<V2CamketThueController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2CamketThueController>(
      init: V2CamketThueController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: const [
                Center(
                  child: Text('Content trong word nhưng nó là dang đơn'),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(color: ColorResources.WHITE),
            height: DeviceUtils.getScaledHeight(context, .3),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(
              children: [
                // three image widget
                _threeImageWidget(context),

                const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                // finish button
                _finishButtonWidget(context)
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///content
  ///
  Widget content() {
    return Text(
      controller.content!,
      textAlign: TextAlign.justify,
      style: Dimensions.fontSizeStyle16(),
    );
  }

  ///
  /// three image widget
  ///
  Widget _threeImageWidget(BuildContext context) {
    return const LabelContent(
      title: "Tải hình ảnh bản cứng (nếu có):",
      content: ThreeImageBox(
        images: [
          Images.location_example,
          Images.location_example,
          Images.location_example,
        ],
        allowPicker: false,
      ),
      isRequired: false,
    );
  }

  ///
  /// finish Button Widget
  ///
  Widget _finishButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: controller.onFinishClick,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        width: DeviceUtils.getScaledWidth(context, 1),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: ColorResources.THEME_DEFAULT,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
          ),
        ),
        child: const Text(
          "Hoàn Thành",
          style: TextStyle(
              color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE),
        ),
      ),
    );
  }
}
