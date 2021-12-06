import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group4/shorthanded_group4_conroller.dart';

class V2ShorthandedGroup4Page extends GetView<V2ShorthandedGroup4Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedGroup4Controller>(
      init: V2ShorthandedGroup4Controller(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Column(
              children: [

                // Tieu de nhom dich vu
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idNhomDichVu) == false && Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idNhomDichVu!.tenDichVu) == false)
                  ContentWidget(
                    label: controller.donDichVuResponse.idNhomDichVu!.tenDichVu!.toString(),
                    center: true,
                    centerLabel: true,
                  )
                else
                  const SizedBox(),

                // Tieu de cong viec
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.tieuDe) == false)
                  ContentWidget(
                    label: "Tiêu đề công việc ",
                    content: controller.donDichVuResponse.tieuDe.toString(),
                  )
                else
                  const SizedBox(),

                // Gioi tinh
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.gioiTinh) == false)
                  ContentWidget(
                    label: "Giới tính: ",
                    content: controller.donDichVuResponse.gioiTinh.toString() == "1" ? "Nam" : "Nữ",
                  )
                else
                  const SizedBox(),

                // Thoi gian lamv iec trong 1 ngay
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idThoiGianLamViecs) == false)
                  ContentWidget(
                    label: "Thời gian làm trong ngày ",
                    content: controller.donDichVuResponse.idThoiGianLamViecs!.map((e) => e.toString()).join('\n'),
                  )
                else
                  const SizedBox(),

                // Ngay bat dau
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.ngayBatDau) == false)
                  ContentWidget(
                    label: "Ngày bắt đầu: ",
                    content: controller.getDateOutput(controller.donDichVuResponse.ngayBatDau.toString()),
                  )
                else
                  const SizedBox(),

                // Ngay ket thuc
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.ngayKetThuc) == false)
                  ContentWidget(
                    label: "Ngày kết thúc: ",
                    content: controller.getDateOutput(controller.donDichVuResponse.ngayKetThuc.toString()),
                  )
                else
                  const SizedBox(),

                // Gia tri khach hang de xuat
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.giaTriKhachDeXuat) == false)
                  ContentWidget(
                    label: "Giá trị khách hàng đề xuất ",
                    content: controller.donDichVuResponse.giaTriKhachDeXuat.toString(),
                  )
                else
                  const SizedBox(),

                // Dia chi lam viec
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idTinhTp) == false || Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idQuanHuyen) == false)
                  ContentWidget(
                    label: "Địa điểm làm việc: ",
                    content: ((Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idQuanHuyen) == false ? '${controller.donDichVuResponse.idQuanHuyen}, ' : '') + (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idTinhTp) == false ? controller.donDichVuResponse.idTinhTp.toString() : '')).toString(),
                  )
                else
                  const SizedBox(),

                //job title
                // Nhom 4 la lay gia tien tu gia cong viec trong loai cong viec
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idNhomDichVu) == false)
                  Column(
                    children: [
                      const ContentWidget(
                        label: "Bảng giá dịch vụ từng loại",
                        padding: EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                          top: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                      ),

                      if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idLoaiCongViec) == false)
                        ContentWidget(
                          label: "Loại dịch vụ: ",
                          content: controller.donDichVuResponse.idLoaiCongViec!.tenCongViec.toString(),
                        )
                      else
                        const SizedBox(),
                      if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idLoaiCongViec) == false)
                        ContentWidget(
                          label: "Giá tiền dịch vụ: ",
                          content: "${PriceConverter.convertPrice(context, double.parse(controller.donDichVuResponse.idLoaiCongViec!.giaCongViec.toString()))} VND",
                        )
                      else
                        const SizedBox(),
                    ],
                  )
                else
                  const SizedBox(),

                // Label so luong thoi gian
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.soNgay) == false)
                  ContentWidget(
                    label: "Số lượng thời gian:",
                    content: controller.donDichVuResponse.soNgay,
                  )
                else
                  const SizedBox(),

                // Label so luong
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.soLuongYeuCau) == false)
                  ContentWidget(
                    label: "Số lượng: ",
                    content: controller.donDichVuResponse.soLuongYeuCau.toString(),
                  )
                else
                  const SizedBox(),

                // Mo ta cong viec
                if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.moTa) == false)
                  ContentWidget(
                    label: "Mô tả, yêu cầu công việc: ",
                    content: controller.donDichVuResponse.moTa.toString(),
                  )
                else
                  const SizedBox(),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),

                // Show btn nhan viec
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

                // Show btn thanh toan ngay
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
              ],
            ),
          ),
        );
      },
    );
  }
}
