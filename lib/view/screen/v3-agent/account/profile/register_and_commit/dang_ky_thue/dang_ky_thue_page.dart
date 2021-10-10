import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/label_input.dart';
import 'package:template/view/basewidget/widgets/three_image_box.dart';
import 'package:template/view/screen/v3-agent/account/profile/register_and_commit/dang_ky_thue/dang_ky_thue_controller.dart';

class V3DangKyThuePage extends GetView<V3DangKyThueController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3DangKyThueController>(
      init: V3DangKyThueController(),
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
            height: DeviceUtils.getScaledHeight(context, .45),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(
              children: [
                // input widget 
                _inputWidget(context),

                const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

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
  Widget _content() {
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
    return LabelContent(
      title: "Tải hình ảnh bản cứng (nếu có):",
      content: ThreeImageBox(
        images: const [
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
  Widget _inputWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          LabelInput(
            label: "Cập nhật mã số thuế (nếu đã đăng ký)",
            labelText: "Cập nhật mã số thuế (nếu đã đăng ký)",
            controller: controller.updateController!,
            isRequire: false,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(
              context,
              Dimensions.SCALE_DEFAULT,
            ),
          )
        ],
      ),
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
