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
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/work_done_controller.dart';

class V2WorkInDonePage extends GetView<V2WorkInDoneController> {
  @override
  Widget build(BuildContext context) {
    return UnFocusTextField(
      widget: Scaffold(
        appBar: AppBarWidget(
          title: controller.appTitle,
        ),
        body: GetBuilder<V2WorkInDoneController>(
          init: V2WorkInDoneController(),
          builder: (V2WorkInDoneController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  //Banner hình ảnh công việc đã làm
                  _image(context, controller: controller),

                  //Tiêu đề việc đã làm
                  _titleWorkInProgress(controller),

                  //thông tin công việc, địa điểm, thời gia
                  _content(controller: controller),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  //Yếu cầu thanh toán khi đã thi công nghiệm thầu
                  _paymentRequest(controller, context),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),

                  //Button gửi
                  _btnSend(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  const Divider(
                    thickness: 2,
                    color: ColorResources.GREY,
                  ),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),

                  //Ý kiến khách hàng
                  _customerReviews(controller, context),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),

                  const Label(
                    label: "Khách hàng thanh toán",
                    obligatory: false,
                    topPadding: 0,
                    horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  //Khách hàng thanh toán
                  _radioButtonCustomerPay(),

                  //line
                  const Divider(
                    thickness: 2,
                    color: ColorResources.GREY,
                  ),

                  if (controller.yeuCauBaoHanhList.isNotEmpty)
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
                              noiDungYeuCau: controller.yeuCauBaoHanhList[index].noiDung,
                              hinhAnhYeuCau: controller.yeuCauBaoHanhList[index].hinhAnhs!,
                              textEditingController: controller.noiDungThucHien[index],
                              hinhAnhBaoHanh: controller.thucHienBaoHanhList[index].hinhAnhs ?? [],
                              danhGiaBaoHanh: controller.thucHienBaoHanhList[index].danhGiaBaoHanh,
                              index: index,
                            ),
                            if (index == controller.yeuCauBaoHanhList.length - 1)
                              const SizedBox.shrink()
                            else
                              const Divider(
                                thickness: 2,
                                color: ColorResources.GREY,
                              ),
                          ],
                        );
                      },
                    )
                  else
                    _itemBaoHanh(
                      context,
                      controller: controller,
                      hinhAnhYeuCau: [],
                      hinhAnhBaoHanh: [],
                      textEditingController: TextEditingController(),
                    ),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  ///image
  ///
  Widget _image(BuildContext context, {required V2WorkInDoneController controller}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Dimensions.BORDER_RADIUS_DEFAULT,
      ),
      child: FadeInImageCustom(
        urlImage: controller.donDichVu!.idNhomDichVu!.hinhAnhDaiDien.toString(),
        height: .45,
        width: .95,
        fit: BoxFit.cover,
      ),
    );
  }

  ///
  ///Tiêu đề việc đang làm
  ///
  Widget _titleWorkInProgress(V2WorkInDoneController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Text(
        controller.donDichVu!.tieuDe.toString(),
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle18w600(),
      ),
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
  Widget _content({required V2WorkInDoneController controller}) {
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
            title: controller.donDichVu!.idTinhTp != null ? controller.donDichVu!.idTinhTp!.ten : null,
          ),
          _item(
            icon: const Icon(
              Icons.location_on,
              color: ColorResources.PRIMARY,
            ),
            title: controller.donDichVu!.idQuanHuyen != null ? controller.donDichVu!.idQuanHuyen!.ten : null,
          ),
          _item(
            icon: const Icon(
              Icons.calendar_today,
              color: ColorResources.PRIMARY,
            ),
            title: DateConverter.formatDateTimeGlobal(
              controller.donDichVu!.ngayKetThuc.toString(),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Yêu cầu thanh toán khi đã thi công nghiệm thu
  ///
  Widget _paymentRequest(V2WorkInDoneController controller, BuildContext context) {
    return InputWidget(
      label: 'Yêu cầu thanh toán khi đã thi công nghiệm thu',
      labelBold: true,
      hintText: "Thợ thầu nhập số tiền yêu cầu thanh toán",
      obligatory: true,
      allowEdit: controller.phanHoiDonDichVuResponse.yKienThoThauViecDaLam == 'null',
      maxLine: 4,
      textEditingController: controller.paymentRequest,
      fillColor: ColorResources.WHITE,
      width: .9,
    );
  }

  ///
  /// Button gửi
  ///
  Widget _btnSend(BuildContext context, {required V2WorkInDoneController controller}) {
    return BtnCustom(
      onTap: controller.phanHoiDonDichVuResponse.yKienThoThauViecDaLam == "null" ? () => controller.onPaymentSubmit() : () {},
      color: controller.phanHoiDonDichVuResponse.yKienThoThauViecDaLam == "null" ? ColorResources.PRIMARY : ColorResources.GREY,
      text: "Gửi",
      width: DeviceUtils.getScaledWidth(context, .5),
    );
  }

  ///
  /// Ý kiến khách hàng
  ///
  Widget _customerReviews(V2WorkInDoneController controller, BuildContext context) {
    return InputWidget(
      label: 'Ý kiến khách hàng',
      labelBold: true,
      maxLine: 4,
      isBorder: false,
      textEditingController: TextEditingController(
        text: controller.phanHoiDonDichVuResponse.khachHangDanhGiaViecDaLam != "null" ? controller.phanHoiDonDichVuResponse.khachHangDanhGiaViecDaLam : null,
      ),
      fillColor: ColorResources.GREY.withOpacity(.2),
      allowEdit: false,
      width: .9,
    );
  }

  ///
  ///Khách hàng thanh toán
  ///
  Widget _radioButtonCustomerPay() {
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
          groupValue: controller.radioIndex,
          toggleable: true,
          onChanged: (val) {},
        );
      },
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
  ///Button nhận thông tin và liên hệ khách hàng
  ///
  Widget _contactCustomers(
    BuildContext context, {
    required V2WorkInDoneController controller,
  }) {
    return BtnCustom(
      onTap: () => controller.onCustomerReviewSubmit(),
      color: ColorResources.PRIMARY,
      text: 'Nhận thông tin và liên hệ khách hàng',
      width: DeviceUtils.getScaledWidth(context, .9),
    );
  }

  ///
  ///noi dung hien thi
  ///
  Widget _noiDungHienThi({String? content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: content == null || content == "null"
            ? const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              )
            : Text(
                content,
                textAlign: TextAlign.justify,
                style: Dimensions.fontSizeStyle16(),
              ),
      ),
    );
  }

  ///
  ///yeu cau bao hanh
  ///
  Widget _yeuCauBaoHanh(
    BuildContext context, {
    required V2WorkInDoneController controller,
    String? noiDungYeuCau,
    required List<String> hinhAnhYeuCau,
    int? index,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        Label(
          label: (index != null) ? 'Yêu cầu bảo hành ${index + 1}' : 'Yêu cầu bảo hành',
          obligatory: false,
          topPadding: 0,
          horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
        ),

        //Nội dung yêu cầu bảo hành
        const Label(
          label: 'Nội dung',
          obligatory: false,
          topPadding: 0,
          horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
          paddingTitle: 0,
        ),

        // nội dung tình trạng hư hỏng của khách hàng
        _noiDungHienThi(content: noiDungYeuCau),

        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),

        //Hình ảnh thực tế
        ImageListHorizontalAdd(
          label: 'Hình ảnh thực tế',
          imageFileList: hinhAnhYeuCau,
          labelBold: true,
          pickImage: () {},
          isAddImage: false,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
          ),
        ),

        const SizedBox(
          height: Dimensions.PADDING_SIZE_LARGE,
        ),

        //Button nhận thông tin và liên hệ khách hàng
        _contactCustomers(
          context,
          controller: controller,
        ),
      ],
    );
  }

  ///
  ///thuc hien bao hanh
  ///
  Widget _thucHienBaoHanh(
    BuildContext context, {
    required V2WorkInDoneController controller,
    required TextEditingController textEditingController,
    required List<String> hinhAnhBaoHanh,
    int? index,
  }) {
    return Column(
      children: [
        Label(
          label: (index != null) ? 'Thực hiện bảo hành ${index + 1}' : 'Thực hiện bảo hành',
          obligatory: false,
          topPadding: 0,
          horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
        ),

        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),

        //Nội dung yêu cầu bảo hành
        InputWidget(
          label: 'Nội dung',
          labelBold: true,
          obligatory: true,
          maxLine: 4,
          hintText: "Thợ thầu nhập nội dung đã bảo hành",
          textEditingController: textEditingController,
          fillColor: ColorResources.WHITE,
          allowEdit: index != null && controller.thucHienBaoHanhList[index].noiDung == null && controller.phanHoiDonDichVuResponse.tinhTrangThanhToan != 'null',
          width: .9,
        ),

        const SizedBox(
          height: Dimensions.PADDING_SIZE_DEFAULT,
        ),

        //Hình ảnh bảo hành
        ImageListHorizontalAdd(
          label: 'Hình ảnh bảo hành (nếu có)',
          imageFileList: hinhAnhBaoHanh,
          labelBold: true,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
          ),
          pickImage: (index != null && controller.thucHienBaoHanhList[index].noiDung == null && controller.phanHoiDonDichVuResponse.tinhTrangThanhToan != 'null') ? () => controller.pickImages(index: index) : () {},
        ),

        const SizedBox(
          height: Dimensions.PADDING_SIZE_DEFAULT,
        ),

        //Đã thực hiện bảo hành
        BtnCustom(
          onTap: (index != null && controller.thucHienBaoHanhList[index].noiDung == null && controller.phanHoiDonDichVuResponse.tinhTrangThanhToan != 'null') ? () => controller.onThucHienBaoHanhClick(index: index) : () {},
          color: (index != null && controller.thucHienBaoHanhList[index].noiDung == null && controller.phanHoiDonDichVuResponse.tinhTrangThanhToan != 'null') ? ColorResources.PRIMARY : ColorResources.GREY,
          text: 'Đã thực hiện bảo hành',
          width: DeviceUtils.getScaledWidth(context, .9),
        )
      ],
    );
  }

  ///
  ///danh gia cong tac bao hanh
  ///
  Widget _danhGiaBaoHanh({
    required V2WorkInDoneController controller,
    String? danhGiaBaoHanh,
    int? index,
  }) {
    return Column(
      children: [
        Label(
          label: (index != null) ? 'Đánh giá công tác bảo hành ${index + 1}' : 'Đánh giá công tác bảo hành',
          obligatory: false,
          topPadding: 0,
          horizontalPadding: Dimensions.PADDING_SIZE_LARGE,
        ),

        //Nội dung yêu cầu bảo hành
        _noiDungHienThi(content: danhGiaBaoHanh),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),
      ],
    );
  }

  ///
  ///item bao hanh
  ///
  Widget _itemBaoHanh(
    BuildContext context, {
    required V2WorkInDoneController controller,
    String? noiDungYeuCau,
    required List<String> hinhAnhYeuCau,
    required TextEditingController textEditingController,
    required List<String> hinhAnhBaoHanh,
    String? danhGiaBaoHanh,
    int? index,
  }) {
    return Column(
      children: [
        _yeuCauBaoHanh(
          context,
          controller: controller,
          noiDungYeuCau: noiDungYeuCau,
          hinhAnhYeuCau: hinhAnhYeuCau,
          index: index,
        ),
        _line(context),
        _thucHienBaoHanh(
          context,
          controller: controller,
          textEditingController: textEditingController,
          hinhAnhBaoHanh: hinhAnhBaoHanh,
          index: index,
        ),
        _line(context),
        _danhGiaBaoHanh(
          controller: controller,
          danhGiaBaoHanh: danhGiaBaoHanh,
          index: index,
        ),
      ],
    );
  }
}
