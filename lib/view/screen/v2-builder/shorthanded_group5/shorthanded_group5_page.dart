import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
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
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idNhomDichVu) == false && Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idNhomDichVu!.tenDichVu) == false)
                  ContentWidget(
                    label: controller.donDichVuResponse.idNhomDichVu!.tenDichVu!.toString(),
                    center: true,
                    centerLabel: true,
                    maxLineLabel: 3,
                  )
                else
                  const SizedBox(),

                //job title
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.tieuDe) == false)
                  ContentWidget(
                    label: "Tiêu đề công việc:",
                    content: controller.donDichVuResponse.tieuDe.toString(),
                  )
                else
                  const SizedBox(),

                //Specification
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idThongSoKyThuats) == false)
                  ContentWidget(
                    label: "Thông số kỹ thuật: ",
                    content: controller.donDichVuResponse.idThongSoKyThuats!.map((e) => e.tieuDe.toString()).join('\n'),
                  )
                else
                  const SizedBox(),

                //The amount of people
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.cuLyVanChuyen) == false)
                  ContentWidget(
                    label: "Cự ly vận chuyển tương đối: ",
                    content: controller.donDichVuResponse.cuLyVanChuyen.toString(),
                  )
                else
                  const SizedBox(),

                //The amount of people
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.soLuongYeuCau) == false)
                  ContentWidget(
                    label: "Số lượng yêu cầu:",
                    content: controller.donDichVuResponse.soLuongYeuCau.toString(),
                  )
                else
                  const SizedBox(),

                //working time in day
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idThoiGianLamViecs) == false)
                  ContentWidget(
                    label: "Thời gian làm trong ngày: ",
                    content: controller.donDichVuResponse.idThoiGianLamViecs!.map((e) => e.toString()).join('\n'),
                  )
                else
                  const SizedBox(),

                //start
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.ngayBatDau) == false)
                  ContentWidget(
                    label: "Ngày làm việc: ",
                    content: controller.getDateOutput(controller.donDichVuResponse.ngayBatDau.toString()),
                  )
                else
                  const SizedBox(),

                //Place of receipt
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.diaDiemBocHang) == false)
                  ContentWidget(
                    label: "Địa điểm bốc hàng dự kiến: ",
                    content: controller.donDichVuResponse.diaDiemBocHang.toString(),
                  )
                else
                  const SizedBox(),

                //shipping adress
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.diaDiemTraHang) == false)
                  ContentWidget(
                    label: "Địa điểm trả hàng dự kiến: ",
                    content: controller.donDichVuResponse.diaDiemTraHang.toString(),
                  )
                else
                  const SizedBox(),

                //haulage distance
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.cuLyVanChuyen) == false)
                  ContentWidget(
                    label: "Cự ly vận chuyển tương đối: ",
                    content: '${controller.donDichVuResponse.cuLyVanChuyen} m',
                  )
                else
                  const SizedBox(),

                //road bed width
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.beRongDiemNhan) == false)
                  ContentWidget(
                    label: "Bề rộng mặt đường nhận hàng (m): ",
                    content: '${controller.donDichVuResponse.beRongDiemNhan} m',
                  )
                else
                  const SizedBox(),

                //road bed width
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.beRongDiemTra) == false)
                  ContentWidget(
                    label: "Bề rộng mặt đường trả hàng (m): ",
                    content: '${controller.donDichVuResponse.beRongDiemTra} m',
                  )
                else
                  const SizedBox(),

                //job description
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.moTaChiTiet) == false)
                  ContentWidget(
                    label: "Mô tả, yêu cầu công việc: ",
                    content: controller.donDichVuResponse.moTaChiTiet.toString(),
                  )
                else
                  const SizedBox(),

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
                      if (controller.coTheBaoGia == true)
                        BtnCustom(
                          onTap: () => controller.onBtnQuotationClick(),
                          color: ColorResources.PRIMARY,
                          text: "Báo giá",
                          width: DeviceUtils.getScaledWidth(context, .4),
                        )
                      else
                        const SizedBox(),
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
      },
    );
  }
}
