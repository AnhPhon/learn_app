import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
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
                const ContentWidget(
                  label: "Dịch vụ thường xuyên có bảng giá",
                  center: true,
                ),

                //job title
                ContentWidget(
                  label: "Tiêu đề công việc ",
                  content: controller.donDichVuResponse.tieuDe.toString(),
                ),

                //sex
                ContentWidget(
                  label: "Giới tính: ",
                  content: controller.donDichVuResponse.gioiTinh.toString(),
                ),

                //The amount of people
                ContentWidget(
                  label: "Số lượng người yêu cầu: ",
                  content: controller.donDichVuResponse.soLuongYeuCau.toString(),
                ),

                //working time in day
                ContentWidget(
                  label: "Thời gian làm trong ngày ",
                  content: controller.donDichVuResponse.idThoiGianLamViecs!
                      .map((e) => e.toString())
                      .join('\n'),
                ),

                //start
                ContentWidget(
                  label: "Ngày bắt đầu: ",
                  content: controller.getDateOutput(controller
                      .donDichVuResponse.ngayBatDau
                      .toString()),
                ),

                //end
                ContentWidget(
                  label: "Ngày kết thúc: ",
                  content: controller.getDateOutput(controller
                      .donDichVuResponse.ngayKetThuc
                      .toString()),
                ),

                //value of customer idea
                ContentWidget(
                  label: "Giá trị khách hàng đề xuất (nếu có) ",
                  content: controller.donDichVuResponse.giaTriKhachDeXuat.toString(),
                ),

                //working address
                ContentWidget(
                  label: "Địa điểm làm việc: ",
                  content: controller.donDichVuResponse.diaDiemLamViec.toString(),
                ),

                //job description
                ContentWidget(
                  label: "Mô tả, yêu cầu công việc ",
                  content: controller.donDichVuResponse.moTaChiTiet.toString(),
                ),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),

                //btn
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

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                ),
              ],
            )),
          );
        });
  }
}
