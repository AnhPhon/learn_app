import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';

import 'package:template/view/screen/v4-employee/account/salary/salary_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class V4SalaryPage extends GetView<V4SalaryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Bảng lương",
        leading: IconButton(
            onPressed: () {
              Get.back(result: true);
            },
            icon:
                const Icon(Icons.arrow_back_ios, color: ColorResources.WHITE)),
      ),
      body: GetBuilder<V4SalaryController>(
          init: V4SalaryController(),
          builder: (V4SalaryController controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text file tính toán bảng lương
                const Padding(
                  padding: EdgeInsets.all(
                    Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Text(
                    'File tính toán bảng lương:',
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //Button Xem
                _btnXem(),
              ],
            );
          }),
    );
  }

  ///
  ///Button xem
  ///
  Widget _btnXem() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: LongButton(
        color: ColorResources.PRIMARY,
        onPressed: () async => {
          await launch(
            controller.bangLuongResponse.file.toString(),
          ),
        },
        title: 'Xem',
      ),
    );
  }
}
