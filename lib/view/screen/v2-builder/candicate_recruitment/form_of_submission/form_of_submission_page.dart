import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/form_of_submitssion_controller.dart';

class V2FormOfSubmitssionPage extends GetView<V2FormOfSubmitssionController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: V2FormOfSubmitssionController(),
      builder: (V2FormOfSubmitssionController controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: Scaffold(
            appBar: const AppBarWidget(title: "Tin tuyển dụng"),
            body: Column(
              children: [
                const Label(
                    label:
                        "Ứng viên nên tạo hồ sơ ở bước “Đăng ký việc” để có một bộ hồ sơ lưu trữ khi ứng tuyển",
                    obligatory: false),

                const Label(
                    label: "Hồ sơ được nộp đến nhà tuyển dụng 2 cách:  ",
                    obligatory: false),

                const Label(
                    label: "Cách 1:  Vừa đánh thông tin + file (nếu có)",
                    obligatory: false),
                // nut đánh văn bản
                LongButton(
                  title: "Đánh văn bản",
                  color: ColorResources.PRIMARYCOLOR,
                  onPressed: () {
                    controller.onClickTextTyingButton();
                  },
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),

                // Labe hương dẫn
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Label(
                      label:
                          "Cập nhật  hồ sơ ứng tuyển bằng đánh văn bản\nBạn phải đăng ký việc mới trước khi ứng tuyển",
                      obligatory: false,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: ColorResources.RED,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      alignment: Alignment.center,
                    ),
                  ],
                ),

                // label
                const Padding(
                  padding:
                      EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Label(
                      label: "Cách 2:  Nếu bạn chỉ muốn nộp file sẵn có",
                      obligatory: false),
                ),

                // Nút cv
                LongButton(
                  title: "Nộp file CV",
                  color: ColorResources.PRIMARYCOLOR,
                  onPressed: () => controller.onClickCvButton(),
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                ),

                // Label gợi ý
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Label(
                      label: "(Cập nhật file CV đầy đủ và thông tin ứng tuyển)",
                      obligatory: false,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: ColorResources.RED,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
