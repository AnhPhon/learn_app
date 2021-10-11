import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/profile/register_and_commit/cam_ket_thue/cam_ket_thue_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/register_and_commit/dang_ky_thue/dang_ky_thue_page.dart';
import 'package:template/view/screen/v3-agent/account/profile/register_and_commit/register_and_commit_controller.dart';

class V3RegisterAndCommitPage extends GetView<V3RegisterAndCommitController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3RegisterAndCommitController>(
        init: V3RegisterAndCommitController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
                      color: Colors.white,
                    ),
                    child: TabBar(
                      controller: controller.tabController,
                      indicator: const BoxDecoration(
                        color: ColorResources.THEME_DEFAULT,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        // first tab
                        Tab(text: 'Giới thiệu'),

                        // second tab
                        Tab(text: 'Đăng ký thuế'),

                        // third tab
                        Tab(text: 'Cam kết thuế'),
                      ],
                    ),
                  ),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: DeviceUtils.getScaledHeight(context, .8),
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          // content
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_DEFAULT),
                            child: _content(),
                          ),
                          // V3DangKyThuePage
                          V3DangKyThuePage(),
                          //content
                          V3CamketThuePage(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  ///
  ///text title
  ///
  Widget table(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE + 2,
      ),
      child: Text(
        title,
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///text title
  ///
  Widget textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE + 2,
      ),
      child: Text(
        title,
        style: Dimensions.fontSizeStyle22w600(),
      ),
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
}
