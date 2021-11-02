import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/image_url.dart';

import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/component/image_card_in_work_done_page.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/component/v2_long_button.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_done/work_done_controller.dart';

class V2WorkDonePage extends GetView<V2WorkDoneController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: controller.appTitle,
      ),
      body: GetBuilder<V2WorkDoneController>(
          init: V2WorkDoneController(),
          builder: (V2WorkDoneController controller) {
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

                    //Banner hình ảnh công việc đã làm
                    _bannerWorkInProgress(context),

                    //Tiêu đề việc đã làm
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

                    //Yếu cầu thanh toán khi đã thi công nghiệm thầu
                    _paymentRequest(controller, context),
                    const SizedBox(
                      height: Dimensions.FONT_SIZE_OVER_LARGE * 1.5,
                    ),

                    //Button gửi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _btnSend(),
                      ],
                    ),

                    //line
                    _line(context),

                    //Ý kiến khách hàng
                    _customerReviews(controller, context),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),

                    Text(
                      'Khách hàng thanh toán',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),

                    //Khách hàng thanh toán
                    _radioButtonCustomerPay(),

                    //line
                    _line(context),

                    Text(
                      'Yêu cầu bảo hành',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT,
                    ),

                    //Nội dung yêu cầu bảo hành
                    Text(
                      'Nội dung',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_SMALL,
                    ),

                    // nội dung tình trạng hư hỏng của khách hàng
                    Column(
                      children: List.generate(
                        controller.noiDungYeuCauBaoHanhList.length,
                        (index) => Column(
                          children: [
                            Text(
                              controller.noiDungYeuCauBaoHanhList[index],
                              style: Dimensions.fontSizeStyle14(),
                            ),
                            const SizedBox(
                              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Hình ảnh thực tế
                    ImageCardInWorkPage(
                      title: 'Hình ảnh thực tế',
                      isRequired: false,
                      urlList: controller.yeuCauImages,
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),

                    //Button nhận thông tin và liên hệ khách hàng
                    _contactCustomers(),

                    //line
                    _line(context),

                    Text(
                      'Thực hiện bảo hành',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),

                    //Nội dung yêu cầu bảo hành
                    _warrantyContents(controller, context),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),

                    //Hình ảnh bảo hành
                    _baoHanhImage(),

                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),

                    //Đã thực hiện bảo hành
                    _evaluation(),

                    //line
                    _line(context),

                    Text(
                      'Đánh giá công tác bảo hành',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_DEFAULT,
                    ),

                    //Nội dung yêu cầu bảo hành
                    Text(
                      'Hiển thị từ khách hàng',
                      style: Dimensions.fontSizeStyle16(),
                    ),

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
  Widget _titleWorkInProgress(V2WorkDoneController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: Text(
        controller.title,
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle18w600(),
      ),
    );
  }

  ///
  /// Thành phố
  ///
  Widget _cityWorkInProgress(V2WorkDoneController controller) {
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
  Widget _districtWorkInProgress(V2WorkDoneController controller) {
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
  Widget _timeWorkInProgress(V2WorkDoneController controller) {
    return Row(
      children: [
        const Icon(
          Icons.schedule_outlined,
          color: ColorResources.PRIMARY,
        ),
        Text(
          controller.deadline,
          style: Dimensions.fontSizeStyle16w600(),
        ),
      ],
    );
  }

  ///
  /// Yêu cầu thanh toán khi đã thi công nghiệm thu
  ///
  Widget _paymentRequest(
      V2WorkDoneController controller, BuildContext context) {
    return InputField(
      line: 4,
      label: 'Yêu cầu thanh toán khi đã thi công nghiệm thu',
      holdplacer: "Thợ thầu yêu cầu thanh toán, số tiền bao nhiêu,...",
      controller: controller.paymentRequest!,
      allowEdit: true,
      allowMultiline: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
      hidden: false,
      obligatory: true,
      fontSize: Dimensions.FONT_SIZE_LARGE,
    );
  }

  ///
  /// Button gửi
  ///
  Widget _btnSend() {
    return SmallButton(
      color: ColorResources.PRIMARY,
      onPressed: () {
        controller.onPaymentSubmit();
      },
      title: 'Gửi',
    );
  }

  ///
  /// Ý kiến khách hàng
  ///
  Widget _customerReviews(
      V2WorkDoneController controller, BuildContext context) {
    return InputField(
      line: 4,
      label: 'Ý kiến khách hàng',
      holdplacer: "Hiển thị từ khách hàng",
      controller: controller.customerReviews!,
      allowEdit: controller.isKhachHangDisable == false,
      allowMultiline: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
      hidden: false,
      obligatory: false,
      fontSize: Dimensions.FONT_SIZE_LARGE,
    );
  }

  ///
  ///Khách hàng thanh toán
  ///
  Widget _radioButtonCustomerPay() {
    return Column(
      children: [
        RadioButton(
          title: "Đồng ý thanh toán 100%",
          groupValue: 1,
          value: controller.radioIndex,
          onChanged: (value) {
            if (!controller.isKhachHangDisable) {
              controller.onKhachHangThanhToanChange(1);
            }
          },
          active: controller.isKhachHangDisable == false,
        ),
        RadioButton(
          title: "Đồng ý thanh toán theo thỏa thuận\n(có chứng từ thỏa thuận)",
          groupValue: 2,
          value: controller.radioIndex,
          onChanged: (value) {
            if (!controller.isKhachHangDisable) {
              controller.onKhachHangThanhToanChange(2);
            }
          },
          active: controller.isKhachHangDisable == false,
        ),
        RadioButton(
          title: "Chưa có đồng ý thanh toán",
          groupValue: 3,
          value: controller.radioIndex,
          onChanged: (value) {
            if (!controller.isKhachHangDisable) {
              controller.onKhachHangThanhToanChange(3);
            }
          },
          active: controller.isKhachHangDisable == false,
        ),
      ],
    );
  }

  ///
  ///Line
  ///
  Widget _line(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
      ),
      child: Container(
        width: DeviceUtils.getScaledWidth(context, 1),
        height: DeviceUtils.getScaledHeight(context, 0.002),
        color: ColorResources.LIGHT_BLACK,
      ),
    );
  }

  ///
  ///Button nhận thông tin và liên hệ khách hàng
  ///
  Widget _contactCustomers() {
    // return V2LongButton(
    //   color: (controller.isKhachHangDisable)
    //       ? ColorResources.LIGHT_GREY
    //       : ColorResources.THEME_DEFAULT,
    //   onPressed: () {
    //     if (!controller.isKhachHangDisable) {
    //       controller.onCustomerReviewSubmit();
    //     }
    //   },
    //   title: 'Nhận thông tin và liên hệ khách hàng',
    // );

    return V2LongButton(
      color: ColorResources.THEME_DEFAULT,
      onPressed: () {
        controller.onCustomerReviewSubmit();
      },
      title: 'Nhận thông tin và liên hệ khách hàng',
    );
  }

  ///
  /// Nội dung yêu cầu bảo hành
  ///
  Widget _warrantyContents(
      V2WorkDoneController controller, BuildContext context) {
    return InputField(
      line: 4,
      label: 'Nội dung',
      holdplacer: "Thợ thầu nhập nội dung đã bảo hành",
      controller: controller.warrantyContents!,
      allowEdit: controller.isBaoHanhDisable == false,
      allowMultiline: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
      hidden: false,
      obligatory: true,
      fontSize: Dimensions.FONT_SIZE_LARGE,
    );
  }

  ///
  /// hỉnh ảnh bảo hành
  ///
  Widget _baoHanhImage() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
          child: const Text(
            "Hình ảnh bảo hành (nếu có)",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(
            images: controller.images,
            isAddImage: controller.isBaoHanhDisable == false,
            onPress: () => controller.pickerMuilFile(files: controller.images),
            onDelete: (File? file, List<File> files) =>
                controller.onDeleteImage(file: file!, files: files),
          ),
        )
      ],
    );
  }

  ///
  ///Đã thực hiện bảo hành
  ///
  Widget _evaluation() {
    return V2LongButton(
      color: (controller.isBaoHanhDisable)
          ? ColorResources.LIGHT_GREY
          : ColorResources.THEME_DEFAULT,
      onPressed: () {
        if (!controller.isBaoHanhDisable) controller.onWarrantyContentSubmit();
      },
      title: 'Đã thực hiện bảo hành',
    );
  }
}
