import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/detail_work_done/detail_work_done_binding.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/detail_work_done/detail_work_done_controller.dart';

class V2DetailWorkDonePage extends GetView<V2DetailWorkDoneBinding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Chi tiết dự án"),
      body: GetBuilder<V2DetailWorkDoneController>(
        init: V2DetailWorkDoneController(),
        builder: (V2DetailWorkDoneController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE,
              vertical: Dimensions.PADDING_SIZE_LARGE,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Tên dự án
                  Text(
                    'Tên dự án',
                    style: Dimensions.fontSizeStyle18w600(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  Text(
                    controller.nameProject,
                    style: Dimensions.fontSizeStyle18w600(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  //Thành phố
                  Text(
                    'Thành phố',
                    style: Dimensions.fontSizeStyle18w600(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  Text(
                    controller.city,
                    style: Dimensions.fontSizeStyle18w600(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  //Địa điểm chi tiết
                  Text(
                    'Địa điểm',
                    style: Dimensions.fontSizeStyle18w600(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  Text(
                    controller.address,
                    style: Dimensions.fontSizeStyle18(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  //Giới thiệu
                  Text(
                    'Giới thiệu',
                    style: Dimensions.fontSizeStyle18w600(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  ),
                  Text(
                    controller.introduce,
                    style: Dimensions.fontSizeStyle18(),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  Text(
                    'Các hạng mục đang triển khai',
                    style: Dimensions.fontSizeStyle18w600(),
                  ),

                  //ChoiceChip các hạng mục đang triển khai
                  _choiceChip(controller),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),

                  //Button quay lại
                  _btnBack(),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  ///ChoiceChip các hạng mục đang triển khai
  ///
  Widget _choiceChip(V2DetailWorkDoneController controller) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: List<Widget>.generate(
              controller.deploymentItems!.length,
              (int index) {
                return ChoiceChip(
                  backgroundColor: Colors.amber,
                  elevation: 3,
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_SMALL,
                  ),
                  label: Text(
                    controller.deploymentItems![index]['title'].toString(),
                  ),
                  selected: true,
                  onSelected: (bool selected) {},
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

///
///Button quay lại
///
Widget _btnBack() {
  return LongButton(
    color: ColorResources.PRIMARY,
    onPressed: () {},
    title: 'Quay lại',
  );
}
