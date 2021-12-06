import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v4-employee/account/rules/rules_controller.dart';

class V4RulesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.HOME_BG,
        appBar: const AppBarWidget(title: "Nội quy, quy chế"),
        body: GetBuilder<V4RulesController>(
            init: V4RulesController(),
            builder: (V4RulesController controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.quyCheCongTyModelList[0].tieuDe.toString(),
                          style: Dimensions.fontSizeStyle20w600(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Html(
                        data: CommonHelper().htmlUnescape(controller
                            .quyCheCongTyModelList[0].noiDung
                            .toString()),
                        style: {
                          "html": Style(
                              textAlign: TextAlign.justify,
                              fontSize: FontSize.medium),
                        })
                    // Text(
                    //   controller.quyCheCongTyModelList[0].noiDung.toString(),
                    //   style: Dimensions.fontSizeStyle16(),
                    // ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
