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
                const ContentWidget(
                  label: "Tiêu đề công việc ",
                  content: "Bảo vệ công ty (bảo vệ chuyên nghiệp)",
                ),

                //sex
                const ContentWidget(
                  label: "Giới tính: ",
                  content: "Nam",
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
                  label: "Ngày bắt đầu: ",
                  content: "12/09/2021",
                ),

                //end
                const ContentWidget(
                  label: "Ngày kết thúc: ",
                  content: "12/09/2021",
                ),

                //value of customer idea
                const ContentWidget(
                  label: "Giá trị khách hàng đề xuất (nếu có) ",
                  content:
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                ),

                //working address
                const ContentWidget(
                  label: "Địa điểm làm việc: ",
                  content: "Quận Hải Châu",
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
