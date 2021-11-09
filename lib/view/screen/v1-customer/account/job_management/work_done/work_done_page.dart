import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/account/job_management/work_done/work_done_controller.dart';

class V1WorkDonePage extends GetView<V1WorkDoneController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1WorkDoneController>(
      init: V1WorkDoneController(),
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

                //opinion
                _opinion(context),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL),
                  child: Divider(
                    color: ColorResources.BLACK.withOpacity(.3),
                    thickness: 2,
                  ),
                ),

                //warrantyClaims
                _warrantyClaims(context, controller: controller),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL),
                  child: Divider(
                    color: ColorResources.BLACK.withOpacity(.3),
                    thickness: 2,
                  ),
                ),

                //warranty
                _warranty(context, controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                )
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
  Widget _title({required V1WorkDoneController controller}) {
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
  Widget _content({required V1WorkDoneController controller}) {
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
              Icons.calendar_today,
              color: ColorResources.PRIMARY,
            ),
            title: (controller.donDichVuResponse.ngayKetThuc == "null")
                ? ""
                : DateConverter.formatDateTime(
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
  Widget _agentsOpinion({required V1WorkDoneController controller}) {
    return InputWidget(
      label: "Ý kiến thợ thầu",
      hintText: "Thợ thầu ý kiến tại đây",
      textEditingController: controller.agentsOpinionController,
      allowEdit: false,
      fillColor: ColorResources.WHITE,
      width: .95,
      maxLine: 5,
    );
  }

  ///
  ///fee List
  ///
  Widget _radList(
    BuildContext context, {
    required V1WorkDoneController controller,
  }) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: TINH_TRANG_THANH_TOAN_PHAN_HOI.values.toList().length,
      itemBuilder: (BuildContext ctx, int index) {
        final tinhTrang = TINH_TRANG_THANH_TOAN_PHAN_HOI.values.toList();
        return RadioListTile(
          title: Text(tinhTrang[index]),
          value: index,
          activeColor: ColorResources.PRIMARY,
          groupValue: controller.indexTinhTrang,
          onChanged: controller.setSelectedIndexFee,
        );
      },
    );
  }

  ///
  ///customer's opinion
  ///
  Widget _customersOpinion({required V1WorkDoneController controller}) {
    return InputWidget(
      label: "Khách hàng đánh giá ý kiến",
      hintText: "Khách hàng nêu lý do bằng chứng chứng minh",
      textEditingController: controller.customerOpinionController,
      fillColor: ColorResources.WHITE,
      width: .95,
      maxLine: 5,
    );
  }

  ///
  ///btn send
  ///
  Widget _btnSend(
    BuildContext context, {
    required V1WorkDoneController controller,
  }) {
    return BtnCustom(
      onTap: () {},
      color: ColorResources.PRIMARY,
      text: "Gửi",
      width: DeviceUtils.getScaledWidth(context, .95),
    );
  }

  ///
  ///opinion
  ///
  Widget _opinion(BuildContext context) {
    return Column(
      children: [
        //agents opinion
        _agentsOpinion(controller: controller),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        const Label(
          label: "Khách hàng thanh toán",
          obligatory: false,
          topPadding: 0,
        ),

        //rad list
        _radList(context, controller: controller),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),

        //customers opinion
        _customersOpinion(controller: controller),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_LARGE,
        ),

        //btn send
        _btnSend(context, controller: controller),
      ],
    );
  }

  ///
  ///warranty claims
  ///
  Widget _warrantyClaims(BuildContext context,
      {required V1WorkDoneController controller}) {
    return Column(
      children: [
        const GroupTitle(
          title: "Yêu cầu bảo hành",
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //content input
        InputWidget(
          label: "Nội dung",
          hintText: "Nhập tình trạng hư hỏng",
          textEditingController: controller.warrantyClaimsContentController,
          allowEdit: false,
          fillColor: ColorResources.WHITE,
          width: .95,
          maxLine: 5,
          padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ),

        //image
        ImageListHorizontalAdd(
          label: "Hình ảnh thực tế",
          labelBold: true,
          pickImage: () {},
          imageFileList: [],
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT,
            horizontal: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //btn
        BtnCustom(
          onTap: () {},
          color: ColorResources.GREY,
          text: "Gửi",
          width: DeviceUtils.getScaledWidth(context, .95),
        ),
      ],
    );
  }

  ///
  ///warranty claims
  ///
  Widget _warranty(BuildContext context,
      {required V1WorkDoneController controller}) {
    return Column(
      children: [
        const GroupTitle(
          title: "Thực hiện bảo hành",
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //content input
        InputWidget(
          label: "Nội dung",
          labelBold: true,
          obligatory: true,
          hintText: "Nhập tình trạng hư hỏng",
          textEditingController: controller.warrantyContentController,
          allowEdit: false,
          fillColor: ColorResources.WHITE,
          width: .95,
          maxLine: 5,
          padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ),

        //image
        ImageListHorizontalAdd(
          label: "Hình ảnh thực tế",
          labelBold: true,
          pickImage: () {},
          imageFileList: [],
          padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //evaluate input
        InputWidget(
          label: "Đánh giá công tác bảo hành",
          labelBold: true,
          obligatory: true,
          hintText: "Đánh giá",
          textEditingController: controller.warrantyContentController,
          allowEdit: false,
          fillColor: ColorResources.WHITE,
          width: .95,
          maxLine: 5,
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT,
            horizontal: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //btn
        BtnCustom(
          onTap: () {},
          color: ColorResources.GREY,
          text: "Gửi",
          width: DeviceUtils.getScaledWidth(context, .95),
        ),
      ],
    );
  }
}
