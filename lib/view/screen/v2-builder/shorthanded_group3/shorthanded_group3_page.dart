import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group3/shorthanded_group3_conroller.dart';

class V2ShorthandedGroup3Page extends GetView<V2ShorthandedGroup3Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedGroup3Controller>(
      init: V2ShorthandedGroup3Controller(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
              child: Column(
            children: [
              //title
              if (Validate.nullOrEmpty(controller.donDichVuResponse.idNhomDichVu) == false && Validate.nullOrEmpty(controller.donDichVuResponse.idNhomDichVu!.tenDichVu) == false)
                ContentWidget(
                  label: controller.donDichVuResponse.idNhomDichVu!.tenDichVu!.toString(),
                  center: true,
                  centerLabel: true,
                )
              else
                const SizedBox(),

              //job title
              if (Validate.nullOrEmpty(controller.donDichVuResponse.tieuDe) == false)
                ContentWidget(
                  label: "Tiêu đề công việc ",
                  content: controller.donDichVuResponse.tieuDe.toString(),
                )
              else
                const SizedBox(),

              //sex
              if (Validate.nullOrEmpty(controller.donDichVuResponse.gioiTinh) == false)
                ContentWidget(
                  label: "Giới tính: ",
                  content: controller.donDichVuResponse.gioiTinh.toString() == "1" ? "Nam" : "Nữ",
                )
              else
                const SizedBox(),

              //working time in day
              if (Validate.nullOrEmpty(controller.donDichVuResponse.idThoiGianLamViecs) == false)
                ContentWidget(
                  label: "Thời gian làm trong ngày ",
                  content: controller.donDichVuResponse.idThoiGianLamViecs!.map((e) => e.toString()).join('\n'),
                )
              else
                const SizedBox(),

              //start
              if (Validate.nullOrEmpty(controller.donDichVuResponse.ngayBatDau) == false)
                ContentWidget(
                  label: "Ngày bắt đầu: ",
                  content: controller.getDateOutput(controller.donDichVuResponse.ngayBatDau.toString()),
                )
              else
                const SizedBox(),

              //end
              if (Validate.nullOrEmpty(controller.donDichVuResponse.ngayKetThuc) == false)
                ContentWidget(
                  label: "Ngày kết thúc: ",
                  content: controller.getDateOutput(controller.donDichVuResponse.ngayKetThuc.toString()),
                )
              else
                const SizedBox(),

              //working address
              if (Validate.nullOrEmpty(controller.donDichVuResponse.idTinhTp) == false || Validate.nullOrEmpty(controller.donDichVuResponse.idQuanHuyen) == false)
                ContentWidget(
                  label: "Địa điểm làm việc: ",
                  content: ((Validate.nullOrEmpty(controller.donDichVuResponse.idQuanHuyen) == false ? '${controller.donDichVuResponse.idQuanHuyen}, ' : '') + (Validate.nullOrEmpty(controller.donDichVuResponse.idTinhTp) == false ? controller.donDichVuResponse.idTinhTp.toString() : '')).toString(),
                )
              else
                const SizedBox(),

              //job title
              if (Validate.nullOrEmpty(controller.donDichVuResponse.idBangGiaDonHang) == false)
                Column(
                  children: [
                    const ContentWidget(
                      label: "Bảng giá dịch vụ từng loại",
                      padding: EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //  TODO: LOai cong viec ben trong bang gia gia don hang
                    if (Validate.nullOrEmpty(controller.donDichVuResponse.idBangGiaDonHang) == false && Validate.nullOrEmpty(controller.donDichVuResponse.idBangGiaDonHang!.idLoaiCongViec) == false)
                      ContentWidget(
                        label: "Loại dịch vụ:",
                        content: controller.donDichVuResponse.idBangGiaDonHang!.idLoaiCongViec!.toString(),
                      )
                    else
                      const SizedBox(),
                    if (Validate.nullOrEmpty(controller.donDichVuResponse.idBangGiaDonHang) == false)
                      ContentWidget(
                        label: "Chi tiết dịch vụ: ",
                        content: controller.donDichVuResponse.idBangGiaDonHang!.tieuDe.toString(),
                      )
                    else
                      const SizedBox(),
                    if (Validate.nullOrEmpty(controller.donDichVuResponse.idBangGiaDonHang) == false)
                      ContentWidget(
                        label: "Giá tiền dịch vụ:",
                        content: "${PriceConverter.convertPrice(context, double.parse(controller.donDichVuResponse.idBangGiaDonHang!.giaTien.toString()))} VND",
                      )
                    else
                      const SizedBox(),
                  ],
                )
              else
                const SizedBox(),

              //The amount of people
              if (Validate.nullOrEmpty(controller.donDichVuResponse.soLuongYeuCau) == false)
                ContentWidget(
                  label: "Số lượng:",
                  content: controller.donDichVuResponse.soLuongYeuCau.toString(),
                )
              else
                const SizedBox(),

              //job description
              if (Validate.nullOrEmpty(controller.donDichVuResponse.moTa) == false)
                ContentWidget(
                  label: "Mô tả dịch vụ yêu cầu của khách hàng:",
                  content: controller.donDichVuResponse.moTa.toString(),
                )
              else
                const SizedBox(),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
              ),

              //btn
              if (controller.checkShowButtonNhanViec() == true)
                BtnCustom(
                  onTap: () => controller.onAcceptClick(),
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                    vertical: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                  color: ColorResources.PRIMARY,
                  text: "Nhận việc",
                  width: double.infinity,
                ),

              //btn
              if (controller.checkShowButtonThanhToan() == true)
                BtnCustom(
                  onTap: () => controller.onAcceptThanhToanClick(),
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                    vertical: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                  color: ColorResources.PRIMARY,
                  text: "Thanh toán ngay",
                  width: double.infinity,
                ),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
              ),
            ],
          )),
        );
      },
    );
  }
}
