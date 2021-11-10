import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v2-builder/account/profile/safety_paper/safety_paper_controller.dart';

class V2SafetyPaperPage extends GetView<V2SafetyPaperController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2SafetyPaperController>(
      init: V2SafetyPaperController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //content
                Specification(
                  specification:
                      controller.thongTinFSSResponse.giayKhamSucKhoe.toString(),
                ),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                ),

                //upload file
                if (controller.isUpdate)
                  GestureDetector(
                    onTap: (controller.isUpdate)
                        ? () => controller.pickFiles()
                        : () {},
                    child: BoxShadowWidget(
                      margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),
                      boxShadowCustom: boxShadowALitle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const GroupTitle(
                            title: "Tải bản giấy khám sức khoẻ",
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.PADDING_SIZE_DEFAULT,
                            ),
                          ),
                          if (controller.giayChungNhanSucKhoeRequest.file !=
                              null)
                            const Icon(
                              Icons.check,
                              color: ColorResources.GREEN,
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: BtnCustom(
            onTap: (controller.isUpdate)
                ? () => controller.onBtnDone()
                : () => controller.onBtnUpdate(),
            color: ColorResources.PRIMARY,
            text: (controller.isUpdate) ? "Hoàn thành" : "Chỉnh sửa",
            width: double.infinity,
            height: .07,
            margin: const EdgeInsets.all(
              Dimensions.MARGIN_SIZE_DEFAULT,
            ),
          ),
        );
      },
    );
  }
}
