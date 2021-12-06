import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
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
                    label: "Tiêu đề công việc",
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
                    label: "Số lượng người yêu cầu: ",
                    content: controller.donDichVuResponse.soLuongYeuCau.toString(),
                  )
                else
                  const SizedBox(),

                //working time in day
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idThoiGianLamViecs) == false)
                  ContentWidget(
                    label: "Thời gian làm trong ngày ",
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

                //end
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.ngayKetThuc) == false)
                  ContentWidget(
                    label: "Ngày kết thúc: ",
                    content: controller.getDateOutput(controller.donDichVuResponse.ngayKetThuc.toString()),
                  )
                else
                  const SizedBox(),

                //working address
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idTinhTp) == false || Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idQuanHuyen) == false)
                  ContentWidget(
                    label: "Địa điểm làm việc: ",
                    content: ((Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idQuanHuyen) == false ? '${controller.donDichVuResponse.idQuanHuyen}, ' : '') + (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idTinhTp) == false ? controller.donDichVuResponse.idTinhTp.toString() : '')).toString(),
                  )
                else
                  const SizedBox(),

                //road bed width
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.beRongMatDuong) == false)
                  ContentWidget(
                    label: "Bề rộng mặt đường làm việc (m): ",
                    content: controller.donDichVuResponse.beRongMatDuong.toString(),
                  )
                else
                  const SizedBox(),

                //job description
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.moTaChiTiet) == false)
                  ContentWidget(
                    label: "Mô tả, yêu cầu công việc ",
                    content: controller.donDichVuResponse.moTaChiTiet.toString(),
                  )
                else
                  const SizedBox(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),

                //image
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.hinhAnhBanVes) == false)
                  ImageListHorizontal(
                    imageList: controller.donDichVuResponse.hinhAnhBanVes == null || controller.donDichVuResponse.hinhAnhBanVes!.isEmpty ? [] : controller.donDichVuResponse.hinhAnhBanVes!,
                    label: "Hình ảnh, bản vẽ móng hoặc khác (nếu có)",
                    labelBold: true,
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
