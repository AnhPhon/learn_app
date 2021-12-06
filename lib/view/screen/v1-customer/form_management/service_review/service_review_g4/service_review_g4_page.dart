import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/sharedpref/constants/enum_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/form_management/service_review/service_review_g4/service_review_g4_controller.dart';

class V1ServiceReviewG4Page extends GetView<V1ServiceReviewG4Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ServiceReviewG4Controller>(
      init: V1ServiceReviewG4Controller(),
      builder: (controller) {
        return Scaffold(
          appBar: const AppBarWidget(title: "Xem đơn công việc"),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiêu đề nhóm công việc
                const GroupTitle(title: "Dịch vụ lao động phổ thông"),

                //tieu de cong viec
                tieuDeCongViec(controller: controller),

                //gioi tinh check box
                gioiTinh(),

                //thoigian lam viec
                thoiGianLamViec(controller: controller),

                //content
                content(context, controller: controller),

                if (controller.status == '0')
                  const Align(
                    child: Text(
                      "Chúng tôi đã sắp xếp người cung cấp dịch vụ cho bạn!",
                      maxLines: 2,
                      style: TextStyle(
                        color: ColorResources.RED,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: DeviceUtils.getScaledHeight(context, .15),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
                topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RowText(
                  text1: "Tổng tiền",
                  text2: "${PriceConverter.convertPrice(
                    context,
                    double.parse(
                      controller.donDichVuResponse.tongDon.toString(),
                    ),
                  )} vnđ",
                  colorRed: true,
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_SMALL,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///tieu de cong viec
  ///
  Widget tieuDeCongViec({required V1ServiceReviewG4Controller controller}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: TextHighlight(
        title: "Tiêu đề công việc: ",
        content: controller.donDichVuResponse.tieuDe.toString(),
      ),
    );
  }

  ///
  ///gioi tinh
  ///
  Widget gioiTinh() {
    return Column(
      children: [
        // Giới tính
        const Label(
          label: "Giới tính",
          obligatory: false,
          paddingTitle: 0,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE * 2),
          child: GetBuilder(
            builder: (V1ServiceReviewG4Controller controller) {
              return Row(
                children: [
                  RadioButton<GENDER>(
                      title: "Nam",
                      onChanged: (val) {},
                      value: GENDER.Nam,
                      groupValue: controller.gender),
                  RadioButton<GENDER>(
                      title: "Nữ",
                      onChanged: (val) {},
                      value: GENDER.Nu,
                      groupValue: controller.gender),
                  RadioButton<GENDER>(
                      title: "Không yêu cầu",
                      onChanged: (val) {},
                      value: GENDER.Khac,
                      groupValue: controller.gender),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  ///
  ///Thời gian làm việc trong ngày
  ///
  Widget thoiGianLamViec({required V1ServiceReviewG4Controller controller}) {
    return Column(
      children: [
        const Label(
          label: "Thời gian làm trong ngày",
          obligatory: false,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_LARGE * 2,
          ),
          child: Column(
            children: [
              CheckBoxCustom(
                title: "Sáng: từ 7h30 - 11h30",
                onChanged: (val) {},
                status: controller.tommorow,
              ),
              CheckBoxCustom(
                title: "Chiều: từ 11h30 - 17h30",
                onChanged: (val) {},
                status: controller.afternoon,
              ),
              CheckBoxCustom(
                title: "Tối: từ 18h30 - 22h30",
                onChanged: (val) {},
                status: controller.tonight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///content
  ///
  Widget content(BuildContext context,
      {required V1ServiceReviewG4Controller controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: TextHighlight(
              title: "Ngày bắt đầu: ",
              content: controller.donDichVuResponse.ngayBatDau == null
                  ? ""
                  : DateConverter.formatDateTimeGlobal(
                      controller.donDichVuResponse.ngayBatDau.toString(),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: TextHighlight(
              title: "Ngày kết thúc: ",
              content: controller.donDichVuResponse.ngayKetThuc == null
                  ? ""
                  : DateConverter.formatDateTimeGlobal(
                      controller.donDichVuResponse.ngayKetThuc.toString(),
                    ),
            ),
          ),

          if (controller.donDichVuResponse.idLoaiCongViec != null)
            Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.PADDING_SIZE_SMALL,
              ),
              child: TextHighlight(
                title: "Loại dịch vụ: ",
                content: controller.donDichVuResponse.idLoaiCongViec!.tenCongViec.toString(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: TextHighlight(
              title: "Đơn giá: ",
              content: controller.donDichVuResponse.soTien == null
                  ? ""
                  : "${PriceConverter.convertPrice(context, double.parse(controller.donDichVuResponse.soTien.toString()))} vnđ",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: TextHighlight(
              title: "Số lượng thời gian: ",
              content: controller.donDichVuResponse.soNgay.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: TextHighlight(
              title: "Số lượng người: ",
              content: controller.donDichVuResponse.soLuongYeuCau.toString(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: TextHighlight(
              title: "Miêu tả yêu cầu công việc cụ thể: ",
              content: controller.donDichVuResponse.moTa.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
