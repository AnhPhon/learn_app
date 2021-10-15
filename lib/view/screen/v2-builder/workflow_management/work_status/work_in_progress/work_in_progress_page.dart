import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/image_url.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_in_progress/work_in_progress_controller.dart';

class V2WorkInProgressPage extends GetView<V2WorkInProgressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Việc đang làm",
        action: [
          IconButton(
            onPressed: () {
              controller.onClickToDetialWorkInProgressPage();
            },
            icon: const Icon(
              Icons.read_more_outlined,
              color: ColorResources.WHITE,
              size: Dimensions.ICON_SIZE_LARGE,
            ),
          ),
        ],
      ),
      body: GetBuilder<V2WorkInProgressController>(
          init: V2WorkInProgressController(),
          builder: (V2WorkInProgressController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Banner hình ảnh công việc đang làm
                    _bannerWorkInProgress(context),

                    //Tiêu đề việc đang làm
                    _titleWorkInProgress(controller),

                    //thông tin công việc, địa điểm, thời gia
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Thành phố
                        _cityWorkInProgress(controller),

                        //quận/huyện
                        _districtWorkInProgress(controller),

                        //thời gian
                        _timeWorkInProgress(controller),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),

                    //Trạng thái công việc đang làm
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trạng thái",
                          style: Dimensions.fontSizeStyle16w600(),
                        ),

                        //chọn trạng thái công việc
                        _statusWorkInProgress(context)
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),

                    //Tiêu đề đánh giá của khách hàng
                    Text(
                      'Khách hàng đánh giá',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),

                    //Đánh giá
                    Text(
                      controller.rate,
                      style: Dimensions.fontSizeStyle14(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),

                    //Ý kiến của thợ thầu
                    _contentOpinion(controller, context),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                    ),

                    //Button gửi
                    _btnSend(),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///
  ///Banner hình ảnh công việc đang làm
  ///
  Widget _bannerWorkInProgress(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: DeviceUtils.getScaledHeight(context, 0.2),
          width: DeviceUtils.getScaledWidth(context, 0.85),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(
              Dimensions.BORDER_RADIUS_DEFAULT,
            ),
            image: const DecorationImage(
              image: NetworkImage(
                ImageURL.V2_IMAGE_WORK_IN_PROGRESS,
              ),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 2,
                color: ColorResources.BLACK.withAlpha(90),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///Tiêu đề việc đang làm
  ///
  Widget _titleWorkInProgress(V2WorkInProgressController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Text(
        '${controller.job}: ${controller.title}',
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle18w600(),
      ),
    );
  }

  ///
  /// Thành phố
  ///
  Widget _cityWorkInProgress(V2WorkInProgressController controller) {
    return Row(
      children: [
        const Icon(
          Icons.location_city_outlined,
          color: ColorResources.PRIMARY,
        ),
        Text(
          controller.city,
          style: Dimensions.fontSizeStyle16w600(),
        ),
      ],
    );
  }

  ///
  /// quận/huyện
  ///
  Widget _districtWorkInProgress(V2WorkInProgressController controller) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: ColorResources.PRIMARY,
        ),
        Text(
          controller.address,
          style: Dimensions.fontSizeStyle16w600(),
        ),
      ],
    );
  }

  ///
  /// thời gian
  ///
  Widget _timeWorkInProgress(V2WorkInProgressController controller) {
    return Row(
      children: [
        const Icon(
          Icons.schedule_outlined,
          color: ColorResources.PRIMARY,
        ),
        Text(
          controller.status,
          style: Dimensions.fontSizeStyle16w600(),
        ),
      ],
    );
  }

  ///
  /// Trạng thái công việc
  ///
  Widget _statusWorkInProgress(BuildContext context) {
    return DropDownButton<String>(
      data: const ["Hoàn thành", "Đang làm"],
      obligatory: false,
      onChanged: (value) {},
      value: "Hoàn thành",
      width: DeviceUtils.getScaledWidth(context, 0.4),
    );
  }

  ///
  /// Ý kiến của thợ thầu
  ///
  Widget _contentOpinion(
      V2WorkInProgressController controller, BuildContext context) {
    return InputField(
      line: 4,
      allowEdit: true,
      allowMultiline: true,
      controller: controller.rateBuilder,
      fontSize: Dimensions.FONT_SIZE_LARGE,
      hidden: false,
      holdplacer: 'Thầu/Thợ ý kiến tại đây',
      label: 'Ý kiến thầu thợ',
      obligatory: false,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }

  ///
  /// Button Send
  ///
  Widget _btnSend() {
    return LongButton(
      color: ColorResources.PRIMARY,
      onPressed: () {
        controller.submit();
      },
      title: 'Gửi',
    );
  }
}
