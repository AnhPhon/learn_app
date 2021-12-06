import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
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
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  _image(context),

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
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Divider(
                      color: ColorResources.BLACK.withOpacity(.3),
                      thickness: 2,
                    ),
                  ),

                  //warrantyClaims
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.yeuCauBaoHanhList.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Column(
                        children: [
                          _itemBaoHanh(
                            context,
                            controller: controller,
                            index: index,
                            textYeuCauController: (controller.yeuCauBaoHanhList[index].noiDung != "null")
                                ? TextEditingController(
                                    text: controller.yeuCauBaoHanhList[index].noiDung,
                                  )
                                : controller.yeuCauControllerList[index],
                            imageYeuCauList: controller.yeuCauBaoHanhList[index].hinhAnhs ?? [],
                            allowEditYeuCau: controller.yeuCauBaoHanhList[index].noiDung == "null",
                            onTapImageYeuCau: () {},
                            onTapYeuCau: () {},
                            colorYeuCau: ColorResources.GREY,
                            noiDungThucHien: controller.thucHienBaoHanhList[index].noiDung,
                            imageThucHienList: controller.thucHienBaoHanhList[index].hinhAnhs ?? [],
                            allowEditDanhGia: index == controller.thucHienBaoHanhList.length - 1 && controller.thucHienBaoHanhList[index].noiDung != "null" && controller.thucHienBaoHanhList[index].danhGiaBaoHanh == "null",
                            textDanhGiaController: (controller.thucHienBaoHanhList[index].danhGiaBaoHanh != "null")
                                ? TextEditingController(
                                    text: controller.thucHienBaoHanhList[index].danhGiaBaoHanh,
                                  )
                                : controller.danhGiaControllerList[index],
                            onTapDanhGia: (index == controller.thucHienBaoHanhList.length - 1 && controller.thucHienBaoHanhList[index].noiDung != "null" && controller.thucHienBaoHanhList[index].danhGiaBaoHanh == "null") ? () => controller.onBtnEvaluateSend(index) : () {},
                            colorDanhGia: (index == controller.thucHienBaoHanhList.length - 1 && controller.thucHienBaoHanhList[index].noiDung != "null" && controller.thucHienBaoHanhList[index].danhGiaBaoHanh == "null") ? ColorResources.PRIMARY : ColorResources.GREY,
                          ),
                          if (index == controller.thucHienBaoHanhList.length - 1 && controller.thucHienBaoHanhList[index].danhGiaBaoHanh == "null")
                            const SizedBox.shrink()
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                              child: Divider(
                                color: ColorResources.BLACK.withOpacity(.3),
                                thickness: 2,
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  if (controller.thucHienBaoHanhList.isEmpty || (controller.thucHienBaoHanhList.last.danhGiaBaoHanh != "null" && controller.thucHienBaoHanhList.last.danhGiaBaoHanh != null))
                    _itemBaoHanh(
                      context,
                      controller: controller,
                      index: controller.yeuCauBaoHanhList.length,
                      textYeuCauController: controller.warrantyClaimsContentController,
                      imageYeuCauList: controller.yeuCauBaoHanhRequest.hinhAnhs ?? [],
                      allowEditYeuCau: controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam != null,
                      onTapImageYeuCau: (controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam != null) ? () => controller.pickImages() : () {},
                      onTapYeuCau: (controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam != null) ? () => controller.onBtnWarrantyClaimsSend() : () {},
                      colorYeuCau: (controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam != null) ? ColorResources.PRIMARY : ColorResources.GREY,
                      imageThucHienList: [],
                      allowEditDanhGia: false,
                      textDanhGiaController: TextEditingController(),
                      onTapDanhGia: () {},
                      colorDanhGia: ColorResources.GREY,
                    ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  ///image
  ///
  Widget _image(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Dimensions.BORDER_RADIUS_DEFAULT,
      ),
      child: FadeInImageCustom(
        urlImage: controller.donDichVuResponse.idNhomDichVu!.hinhAnhDaiDien.toString(),
        height: .45,
        width: .95,
        fit: BoxFit.cover,
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
  Widget _item({required Icon icon, String? title}) {
    return Row(
      children: [
        icon,
        if (title != null)
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
            title: controller.donDichVuResponse.idTinhTp != null ? controller.donDichVuResponse.idTinhTp!.ten : null,
          ),
          _item(
            icon: const Icon(
              Icons.location_on,
              color: ColorResources.PRIMARY,
            ),
            title: controller.donDichVuResponse.idQuanHuyen != null ? controller.donDichVuResponse.idQuanHuyen!.ten : null,
          ),
          _item(
            icon: const Icon(
              Icons.calendar_today,
              color: ColorResources.PRIMARY,
            ),
            title: DateConverter.formatDateTimeGlobal(
              controller.donDichVuResponse.ngayKetThuc != 'null' ? controller.donDichVuResponse.ngayKetThuc! : controller.donDichVuResponse.updatedAt!,
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
      label: "Ý kiến thợ thầu (ý kiến của thợ thầu)",
      labelBold: true,
      textEditingController: TextEditingController(text: controller.phanHoiDonDichVuRequest.yKienThoThauViecDaLam),
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
          onChanged: (controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam == null) ? controller.setSelectedIndexFee : (val) {},
        );
      },
    );
  }

  ///
  ///customer's opinion
  ///
  Widget _customersOpinion({required V1WorkDoneController controller}) {
    return InputWidget(
      label: "Khách hàng đánh giá/ý kiến",
      labelBold: true,
      hintText: "Khách hàng nêu lý do bằng chứng chứng minh",
      textEditingController: controller.customerOpinionController,
      fillColor: ColorResources.WHITE,
      allowEdit: controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam == null && controller.phanHoiDonDichVuRequest.yKienThoThauViecDaLam != null,
      width: .95,
      maxLine: 5,
    );
  }

  ///
  ///Line
  ///
  Widget _line(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE * 3,
        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: Divider(
        thickness: 2,
        color: ColorResources.GREY.withOpacity(.4),
      ),
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
      onTap: (controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam == null && controller.phanHoiDonDichVuRequest.yKienThoThauViecDaLam != null) ? () => controller.onBtnOpinionSend() : () {},
      color: (controller.phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam == null && controller.phanHoiDonDichVuRequest.yKienThoThauViecDaLam != null) ? ColorResources.PRIMARY : ColorResources.GREY,
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
  Widget _warrantyClaims(
    BuildContext context, {
    required V1WorkDoneController controller,
    required bool allowEdit,
    required TextEditingController textController,
    required List<String> imageFileList,
    required Color color,
    required VoidCallback onTapImage,
    required VoidCallback onTap,
    required int index,
  }) {
    return Column(
      children: [
        GroupTitle(
          title: "Yêu cầu bảo hành ${index + 1}",
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //content input
        InputWidget(
          label: "Nội dung",
          labelBold: true,
          hintText: "Nhập nội dung yêu cầu bảo hành",
          textEditingController: textController,
          allowEdit: allowEdit,
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
          pickImage: onTapImage,
          imageFileList: imageFileList,
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_DEFAULT,
            horizontal: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //btn
        BtnCustom(
          onTap: onTap,
          color: color,
          text: "Gửi",
          width: DeviceUtils.getScaledWidth(context, .95),
        ),
      ],
    );
  }

  ///
  ///warranty
  ///
  Widget _warranty(
    BuildContext context, {
    required V1WorkDoneController controller,
    String? content,
    List<String>? imageFileList,
    required int index,
  }) {
    return Column(
      children: [
        GroupTitle(
          title: "Thực hiện bảo hành ${index + 1}",
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),

        //content input
        InputWidget(
          label: "Nội dung",
          labelBold: true,
          hintText: "Nhập tình trạng hư hỏng",
          textEditingController: TextEditingController(text: content),
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
          imageFileList: imageFileList ?? [],
          padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
          ),
        ),
      ],
    );
  }

  ///
  ///
  ///
  Widget _evaluate(
    BuildContext context, {
    required V1WorkDoneController controller,
    required bool allowEdit,
    required TextEditingController textController,
    required VoidCallback onTap,
    required Color color,
    required int index,
  }) {
    return Column(
      children: [
        //evaluate input
        InputWidget(
          label: "Đánh giá công tác bảo hành ${index + 1}",
          labelBold: true,
          obligatory: true,
          hintText: "Đánh giá",
          textEditingController: textController,
          allowEdit: allowEdit,
          fillColor: ColorResources.WHITE,
          width: .95,
          maxLine: 5,
          padding: const EdgeInsets.only(
            // left: Dimensions.PADDING_SIZE_SMALL,
            // right: Dimensions.PADDING_SIZE_SMALL,
            bottom: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ),

        //btn
        BtnCustom(
          onTap: onTap,
          color: color,
          text: "Gửi",
          width: DeviceUtils.getScaledWidth(context, .95),
        ),
      ],
    );
  }

  ///
  ///
  ///
  Widget _itemBaoHanh(
    BuildContext context, {
    required V1WorkDoneController controller,
    required int index,
    required TextEditingController textYeuCauController,
    required List<String> imageYeuCauList,
    required VoidCallback onTapImageYeuCau,
    required VoidCallback onTapYeuCau,
    required Color colorYeuCau,
    required bool allowEditYeuCau,
    String? noiDungThucHien,
    required List<String> imageThucHienList,
    required bool allowEditDanhGia,
    required TextEditingController textDanhGiaController,
    required VoidCallback onTapDanhGia,
    required Color colorDanhGia,
  }) {
    return Column(
      children: [
        _warrantyClaims(
          context,
          index: index,
          controller: controller,
          allowEdit: allowEditYeuCau,
          textController: textYeuCauController,
          imageFileList: imageYeuCauList,
          onTapImage: onTapImageYeuCau,
          onTap: onTapYeuCau,
          color: colorYeuCau,
        ),
        _line(context),
        _warranty(
          context,
          index: index,
          controller: controller,
          content: noiDungThucHien,
          imageFileList: imageThucHienList,
        ),
        _line(context),
        _evaluate(
          context,
          index: index,
          controller: controller,
          allowEdit: allowEditDanhGia,
          textController: textDanhGiaController,
          onTap: onTapDanhGia,
          color: colorDanhGia,
        ),
      ],
    );
  }
}
