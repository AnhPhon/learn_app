import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/content_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/image_list_horizontal.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/shorthanded_group2_conroller.dart';

class V2ShorthandedGroup2Page extends GetView<V2ShorthandedGroup2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedGroup2Controller>(
        init: V2ShorthandedGroup2Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  const ContentWidget(
                    label: "Dịch vụ thường xuyên khảo sát chờ báo giá ",
                    center: true,
                  ),

                  //job title
                  const ContentWidget(
                    label: "Tiêu đề công việc ",
                    content: "Bảo vệ công ty (bảo vệ chuyên nghiệp)",
                  ),

                  //working time in day
                  const ContentWidget(
                    label: "Thời gian làm trong ngày ",
                    content:
                        "Sáng: Từ  ??h?? đến ??h??\nChiều: Từ ??h?? đến ??h??\nTối: Từ ??h?? đến ??h??",
                  ),

                  //start
                  const ContentWidget(
                    label: "Thời gian bắt đầu dự kiến: ",
                    content: "12/09/2021",
                  ),

                  //end
                  const ContentWidget(
                    label: "Thời gian kết thúc dự kiến: ",
                    content: "12/09/2021",
                  ),

                  //value of customer idea
                  const ContentWidget(
                    label: "Giá trị khách hàng đề xuất ",
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
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  const ImageListHorizontal(
                    imageList: [],
                    label: "Hình ảnh chi tiết nếu có (hình ảnh thực tế)",
                    labelBold: true,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  const ImageListHorizontal(
                    imageList: [],
                    label: "Hình ảnh sản phẩm mẫu (nếu có)",
                    labelBold: true,
                  ),

                  //job value description
                  const ContentWidget(
                    label:
                        "Mô tả khối lượng công việc thực hiện (sơ bộ tham khảo) ",
                    content:
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ",
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  const ImageListHorizontal(
                    imageList: [],
                    label:
                        "Hình ảnh bảng khối lượng hoặc mô tả công việc (nếu có)",
                    labelBold: true,
                  ),

                  //file
                  const RowText(
                    text1: "File đính kèm",
                    text2: "Nhom2dinhkem.doc",
                  ),

                  //btn
                  BtnCustom(
                    onTap: () => controller.onQuotationG2PageClick(),
                    margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                      vertical: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),
                    color: ColorResources.PRIMARY,
                    text: "Tiếp tục và báo giá",
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///label and content
  ///
  Widget content({
    required String label,
    String? content,
    required bool center,
    bool? centerLabel = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Align(
        alignment: center == false ? Alignment.centerLeft : Alignment.center,
        child: Wrap(
          children: [
            Text(
              label,
              textAlign:
                  centerLabel == true ? TextAlign.center : TextAlign.left,
              style: Dimensions.fontSizeStyle16w600().copyWith(height: 1.5),
            ),
            if (content != null)
              Text(
                content,
                textAlign: TextAlign.justify,
                style: Dimensions.fontSizeStyle16().copyWith(height: 1.5),
              ),
          ],
        ),
      ),
    );
  }
}
