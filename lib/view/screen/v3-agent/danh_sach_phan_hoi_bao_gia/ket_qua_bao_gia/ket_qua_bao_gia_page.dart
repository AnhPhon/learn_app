import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/ket_qua_bao_gia/ket_qua_bao_gia_controller.dart';

class V3KetQuaBaoGiaPage extends GetView<V3KetQuaBaoGiaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3KetQuaBaoGiaController>(
        init: V3KetQuaBaoGiaController(),
        builder: (V3KetQuaBaoGiaController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Tiêu đề",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                        ),
                        InputField(
                          padding: EdgeInsets.zero,
                          paddingTop: 0,
                          label: controller.titleController.text,
                          holdplacer: "Tiêu đề",
                          controller: controller.titleController,
                          allowEdit: true,
                          allowMultiline: false,
                          typeInput: TextInputType.text,
                          width: DeviceUtils.getScaledWidth(context, 1),
                          hidden: false,
                          obligatory: false,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Nội dung báo giá",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                        ),
                        InputField(
                          padding: EdgeInsets.zero,
                          paddingTop: 0,
                          label: controller.noiDungController.text,
                          holdplacer: "Nội dung báo giá",
                          controller: controller.noiDungController,
                          allowEdit: true,
                          allowMultiline: true,
                          textInputAction: TextInputAction.newline,
                          typeInput: TextInputType.multiline,
                          width: DeviceUtils.getScaledWidth(context, 1),
                          hidden: false,
                          obligatory: false,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
