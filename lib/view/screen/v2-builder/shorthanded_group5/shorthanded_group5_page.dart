import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group5/shorthanded_group5_conroller.dart';

class V2ShorthandedGroup5Page extends GetView<V2ShorthandedGroup5Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedGroup5Controller>(
        init: V2ShorthandedGroup5Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  const ContentWidget(
                    label: "Dịch vụ xe tải, xe bên, cầu thùng, xe khác",
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

                  //Place of receipt
                  ContentWidget(
                    label: "Địa điểm bốc hàng dự kiến ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.diaDiemBocHang
                            .toString(),
                  ),

                  //shipping adress
                  ContentWidget(
                    label: "Địa điểm trả hàng dự kiến ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.diaDiemTraHang
                            .toString(),
                  ),

                  //haulage distance
                  ContentWidget(
                    label: "Cự ly vận chuyển tương đối: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.cuLyVanChuyen
                            .toString(),
                  ),

                  //road bed width
                  ContentWidget(
                    label: "Bề rộng mặt đường nhận hàng: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.beRongDiemNhan
                            .toString(),
                  ),

                  //road bed width
                  ContentWidget(
                    label: "Bề rộng mặt đường trả hàng: ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.beRongDiemTra
                            .toString(),
                  ),

                  //job description
                  ContentWidget(
                    label: "Mô tả, yêu cầu công việc ",
                    content: controller.donDichVuResponse == null
                        ? ''
                        : controller.donDichVuResponse!.moTaChiTiet.toString(),
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
