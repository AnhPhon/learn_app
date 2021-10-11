import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/content_widget.dart';
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
                  const ContentWidget(
                    label: "Tiêu đề công việc",
                    content: "Dịch vụ nấu nướng (đám cưới hỏi, giỗ,…)",
                  ),

                  //Specification
                  const ContentWidget(
                    label: "Thông số kỹ thuật: ",
                    content: "Thông số 1\nThông số 2",
                  ),

                  //The amount of people
                  const ContentWidget(
                    label: "Số lượng người yêu cầu: ",
                    content: "50 người",
                  ),

                  //working time in day
                  const ContentWidget(
                    label: "Thời gian làm trong ngày ",
                    content:
                        "Sáng: Từ  ??h?? đến ??h??\nChiều: Từ ??h?? đến ??h??\nTối: Từ ??h?? đến ??h??",
                  ),

                  //start
                  const ContentWidget(
                    label: "Ngày làm việc: ",
                    content: "12/09/2021",
                  ),

                  //Place of receipt
                  const ContentWidget(
                    label: "Địa điểm bốc hàng dự kiến ",
                    content: "120 QUách Thị Trang, TP Đà Nẵng",
                  ),

                  //shipping adress
                  const ContentWidget(
                    label: "Địa điểm trả hàng dự kiến ",
                    content: "120 QUách Thị Trang, TP Đà Nẵng",
                  ),

                  //haulage distance
                  const ContentWidget(
                    label: "Cự ly vận chuyển tương đối: ",
                    content: "xxx",
                  ),

                  //road bed width
                  const ContentWidget(
                    label: "Bề rộng mặt đường nhận hàng: ",
                    content: "xxx",
                  ),

                  //road bed width
                  const ContentWidget(
                    label: "Bề rộng mặt đường trả hàng: ",
                    content: "xxx",
                  ),

                  //job description
                  const ContentWidget(
                    label: "Mô tả, yêu cầu công việc ",
                    content:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
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
