import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group6/shorthanded_group6_conroller.dart';

class V2ShorthandedGroup6Page extends GetView<V2ShorthandedGroup6Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedGroup6Controller>(
        init: V2ShorthandedGroup6Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  const ContentWidget(
                    label: "Dịch vụ xe đào, cẩu nặng, máy móc khác",
                    center: true,
                  ),

                  //job title
                  ContentWidget(
                    label: "Tiêu đề công việc",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.tieuDe.toString(),
                  ),

                  //Specification
                  ContentWidget(
                    label: "Thông số kỹ thuật: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.idThongSoKyThuats!
                        .map((e) => e.tieuDe.toString())
                        .join('\n'),
                  ),

                  //The amount of people
                  ContentWidget(
                    label: "Số lượng người yêu cầu: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.soLuongYeuCau
                        .toString(),
                  ),

                  //working time in day
                  ContentWidget(
                    label: "Thời gian làm trong ngày ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.idThoiGianLamViecs!
                        .map((e) => e.toString())
                        .join('\n'),
                  ),

                  //start
                  ContentWidget(
                    label: "Ngày làm việc: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.soNgay.toString(),
                  ),

                  //end
                  ContentWidget(
                    label: "Ngày kết thúc: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.getDateOutput(controller
                        .donDichVuResponse!.ngayKetThuc
                        .toString()),
                  ),

                  //road bed width
                  ContentWidget(
                    label: "Bề rộng mặt đường làm việc (m): ",
                    // content: controller.donDichVuResponse == null
                    //     ? ''
                    //     : controller.donDichVuResponse!.beRongDiemTra.toString(),
                  ),

                  //job description
                  ContentWidget(
                    label: "Mô tả, yêu cầu công việc ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.moTaChiTiet.toString(),
                  ),

                  //image
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse == null || controller.donDichVuResponse!.hinhAnhChiTiet == null || controller.donDichVuResponse!.hinhAnhChiTiet!.isEmpty
                        ? []
                        : [controller.donDichVuResponse!.hinhAnhChiTiet!],
                    label: "Hình ảnh chi tiết nếu có (hình ảnh thực tế)",
                    labelBold: true,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //btn
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BtnCustom(
                          onTap: () => controller.onBtnEditClick(),
                          color: ColorResources.GREY,
                          text: "Quay lại",
                          width: DeviceUtils.getScaledWidth(context, .4),
                        ),
                        BtnCustom(
                          onTap: () => controller.onBtnQuotationClick(),
                          color: ColorResources.PRIMARY,
                          text: "Báo giá",
                          width: DeviceUtils.getScaledWidth(context, .4),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
