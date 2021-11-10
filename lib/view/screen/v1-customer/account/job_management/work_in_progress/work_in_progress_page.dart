import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/account/job_management/work_in_progress/work_in_progress_controller.dart';

class V1WorkInProgressPage extends GetView<V1WorkInProgressController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1WorkInProgressController>(
      init: V1WorkInProgressController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //image
                _image(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_SMALL,
                ),

                //title
                _title(controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_SMALL,
                ),

                //content
                _content(controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //customers opinion
                _customersOpinion(controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //agents opinion
                _agentsOpinion(controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),

                //btn send
                _btnSend(context, controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///image
  ///
  Widget _image() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Dimensions.BORDER_RADIUS_DEFAULT,
      ),
      child: const FadeInImageCustom(
        urlImage: "",
        height: .4,
        width: .95,
      ),
    );
  }

  ///
  ///title
  ///
  Widget _title({required V1WorkInProgressController controller}) {
    return GroupTitle(
      title: controller.donDichVuResponse.tieuDe.toString(),
    );
  }

  ///
  ///item
  ///
  Widget _item({required Icon icon, required String title}) {
    return Row(
      children: [
        icon,
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  ///
  ///content
  ///
  Widget _content({required V1WorkInProgressController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _item(
            icon: const Icon(
              Icons.location_city_rounded,
              color: ColorResources.PRIMARY,
            ),
            title: controller.donDichVuResponse.idTinhTp.toString(),
          ),
          _item(
              icon: const Icon(
                Icons.location_on,
                color: ColorResources.PRIMARY,
              ),
              title: controller.donDichVuResponse.idQuanHuyen.toString()),
          _item(
            icon: const Icon(
              Icons.access_time_outlined,
              color: ColorResources.PRIMARY,
            ),
            title: controller.donDichVuResponse.ngayKetThuc == "null"
                ? ""
                : controller.getDeadline(
                    controller.donDichVuResponse.ngayKetThuc.toString(),
                  ),
          ),
        ],
      ),
    );
  }

  ///
  ///customer's opinion
  ///
  Widget _customersOpinion({required V1WorkInProgressController controller}) {
    return InputWidget(
      label: "Khách hàng đánh giá ý kiến",
      hintText:
          "Khách hàng đánh giá nội dụng vào đây chất lượng/tiến độ/ tác phong làm việc",
      textEditingController: controller.customerOpinionController,
      fillColor: ColorResources.WHITE,
      width: .95,
      maxLine: 5,
    );
  }

  ///
  ///customer's opinion
  ///
  Widget _agentsOpinion({required V1WorkInProgressController controller}) {
    return InputWidget(
      label: "Ý kiến thợ thầu",
      hintText: "Thợ thầu ý kiến tại đây",
      textEditingController: controller.agentsOpinionController,
      fillColor: ColorResources.WHITE,
      allowEdit: false,
      width: .95,
      maxLine: 5,
    );
  }

  ///
  ///btn send
  ///
  Widget _btnSend(
    BuildContext context, {
    required V1WorkInProgressController controller,
  }) {
    return BtnCustom(
      onTap: () {},
      color: ColorResources.PRIMARY,
      text: "Gửi",
      width: DeviceUtils.getScaledWidth(context, .95),
    );
  }
}
