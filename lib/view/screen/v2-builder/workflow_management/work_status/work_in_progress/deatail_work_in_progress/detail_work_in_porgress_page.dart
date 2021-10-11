import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/component/image_card_in_work_done_page.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_in_progress/deatail_work_in_progress/detail_work_in_porgress_controller.dart';

class V2DetailWorkInProgresspage
    extends GetView<V2DetailWorkInProgressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Chi tiết dự án"),
      body: GetBuilder<V2DetailWorkInProgressController>(
          init: V2DetailWorkInProgressController(),
          builder: (V2DetailWorkInProgressController controller) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE,
                vertical: Dimensions.PADDING_SIZE_LARGE,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          "Công việc xây dựng toàn diện",
                          style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Tên dự án
                    Text(
                      'Tiêu đề công việc',
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

                    //Mô tả công việc
                    Text(
                      'Mô tả công việc',
                      style: Dimensions.fontSizeStyle18w600(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    Text(
                      controller.description,
                      style: Dimensions.fontSizeStyle18(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Địa điểm làm việc
                    Text(
                      'Địa điểm làm việc',
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

                    //Thời gian bắt đầu dự kiến
                    Row(
                      children: [
                        Text(
                          'Thời gian bắt đầu dự kiến: ',
                          style: Dimensions.fontSizeStyle18w600(),
                        ),
                        Text(
                          controller.startTime,
                          style: Dimensions.fontSizeStyle18(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Thời gian kết thúc dự kiến
                    Row(
                      children: [
                        Text(
                          'Thời gian kết thúc dự kiến: ',
                          style: Dimensions.fontSizeStyle18w600(),
                        ),
                        Text(
                          controller.endTime,
                          style: Dimensions.fontSizeStyle18(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE * 2,
                    ),

                    //Bảng khối lượng công việc cần báo giá
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Expanded(
                          child: Text(
                            "Bảng khối lượng công việc cần báo giá\n(Chỉ báo giá phần nhân công)",
                            style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Bảng khối lượng công việc
                    _amountOfWork(controller),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Xem thêm>>',
                            style: Dimensions.fontSizeStyle18w600(),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    //File khối lương
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'File khối lượng: ',
                          style: Dimensions.fontSizeStyle16w600(),
                        ),
                        Text(
                          'Filebaogiakhoiluong.doc',
                          style: Dimensions.fontSizeStyle16w600(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Hình ảnh bảng khố lượng
                    const ImageCardInWorkDonePage(
                      isRequired: false,
                      title: 'Hình ảnh bảng khố lượng',
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Hình ảnh bảng vẽ
                    const ImageCardInWorkDonePage(
                      isRequired: false,
                      title: 'Hình ảnh bảng vẽ',
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    Text(
                      'Quyền lợi',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),

                    //Quyền lợi
                    _benefit(),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE * 2,
                    ),

                    //Button quay lại
                    _btnBack(),

                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE * 2,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///
  ///Bảng khối lượng công việc
  ///
  Widget _amountOfWork(V2DetailWorkInProgressController controller) {
    return Container(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_LARGE,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          Dimensions.BORDER_RADIUS_DEFAULT,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: ColorResources.BLACK.withAlpha(40),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Tên công việc
          Row(
            children: [
              Text(
                'Tên công việc: ',
                style: Dimensions.fontSizeStyle16w600(),
              ),
              Expanded(
                child: Text(
                  controller.nameJob,
                  style: Dimensions.fontSizeStyle16w600(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),

          //Quy cách
          Row(
            children: [
              Text(
                'Quy cách: ',
                style: Dimensions.fontSizeStyle16w600(),
              ),
              Expanded(
                child: Text(
                  controller.ruleJob,
                  style: Dimensions.fontSizeStyle16w600(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),

          //Khối lượng
          Row(
            children: [
              Text(
                'Khối lượng: ',
                style: Dimensions.fontSizeStyle16w600(),
              ),
              Expanded(
                child: Text(
                  controller.mass,
                  style: Dimensions.fontSizeStyle16w600(),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          ),

          //Đơn vị
          Row(
            children: [
              Text(
                'Đơn vị: ',
                style: Dimensions.fontSizeStyle16w600(),
              ),
              Expanded(
                child: Text(
                  controller.unit,
                  style: Dimensions.fontSizeStyle16w600(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///Quyền lợi
  ///
  Widget _benefit() {
    return Container(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_LARGE,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          Dimensions.BORDER_RADIUS_DEFAULT,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: ColorResources.BLACK.withAlpha(40),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Bạn sẽ được bố trí công việc thường xuyên nếu làm tốt, được khách hàng đánh giá trong và sau khi kết thúc công việc + thời gian bảo hành",
            style: Dimensions.fontSizeStyle16(),
          ),
        ],
      ),
    );
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
}
