import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/candicate_card.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/preview/preview_controller.dart';

class V2PreviewPage extends GetView<V2PreviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tin tuyển dụng"),
      body: GetBuilder(
          init: V2PreviewController(),
          builder: (V2PreviewController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  V2CandidateCard(
                    dangKyViecMoiResponse: controller.dangKyViecMoiResponse,
                  ),
                  content(context, controller),
                  button(controller: controller),
                  const SizedBox(
                    height: Dimensions.SIZE_LARGE,
                  )
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Nội dung
  ///
  Widget content(BuildContext context, V2PreviewController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(label: "Mục tiêu nghê nghiệp", obligatory: true),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: TextHighlight(
              title: "",
              content: controller.dangKyViecMoiResponse.mucTieuNgheNghiep
                  .toString()),
        ),

        // file hô so xin việc
        const Label(label: "File hồ sơ xin việc", obligatory: true),
        // Cập nhật Preview đầy đủ thông tin
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: SizedBox(
            width: DeviceUtils.getScaledWidth(context, 1),
            child: GestureDetector(
              onTap: () => controller.onBtnDownloadCv(
                  url: controller.dangKyViecMoiResponse.fileHoSoXinViec
                      .toString()),
              child: BoxShadowWidget(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(controller.tenFile.toString(),
                    style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customButton(
      {required String title,
      double? verticalPadding,
      required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: verticalPadding ?? 0),
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.SIZE_OVER_LARGE,
          decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
              boxShadow: boxShadow),
          child: Text(title,
              style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  color: ColorResources.BLACK)),
        ),
      ),
    );
  }

  ///
  /// Button
  ///
  Widget button({required V2PreviewController controller}) {
    return Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: LongButton(
          title: "Nộp hồ sơ ứng tuyển",
          onPressed: () => controller.onBtnSummit(),
          color: ColorResources.PRIMARYCOLOR,
        ));
  }
}
