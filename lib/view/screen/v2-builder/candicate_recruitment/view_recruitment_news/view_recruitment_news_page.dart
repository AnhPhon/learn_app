

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/view_recruitment_news/view_recruitment_news_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V2ViewRecruitmentNewsPage extends GetView<V2ViewRecruitmentNewsController>{
  final _controller = Get.find<V2ViewRecruitmentNewsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const AppBarWidget(title: "Tin tuyển dụng"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            content(),
            button(),
            const SizedBox(
              height: Dimensions.SIZE_LARGE,
            )
          ],
        ),
      ),
    );
  }

  ///
  /// Nội dung đơn
  ///
  Widget content(){
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: BoxShadowWidget(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Tiêu đề: ", content: "Cần tuyển 02 kiến trúc sư làm việc tại Đà Nẵng"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Công ty:", content: "Công ty TNHH Five Start Building System"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Địa chỉ:", content: "Thôn Trung Đông - Xã Trung Đông - Huyện Trung Đông - Tỉnh Trung Đông"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Giới tính:", content: "Nam"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Số lượng tuyển: ", content: "02"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Hình thức làm việc: ", content: "Nhân viên chính thức"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Trình độ học vấn:", content: "Đại học"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Chuyên ngành chính:", content: "Tập tành lập trình"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Chuyên ngành phụ: ", content: "Xây dựng DD&CN;Xây dựng cầu đường"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Số năm kinh nghiệm: ", content: "3 năm"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Mức lương ban đầu dự kiến:", content: "7 triệu"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Nơi làm việc:", content: "Đà Nẵng"),
                ),
      
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Thời gian thử việc:", content: "1 tháng"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Mô tả công việc: ", content: "\n+ Phụ trách công tác thiết kế nội thất các công trình nhà dân \n+ Quản lý văn phòng đại diện Đà Nẵng"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Yêu cầu công việc: ", content: "\n+ Sử dụng ít nhất một phần mềm thiết kế \n+ Tuân thủ nội dung công ty, làm việc với tinh thần tự giác"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Chế độ quyền lợi:", content: "\n+ Được hưởng đầy đủ các chế độ lao động theo quy định \n+ Được hưởng khi hoàn thành tốt công việc được giao"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Ưu tiên:", content: "\n+ Ưu tiên ứng viên có bằng lái xe B2 \n+ Ưu tiên hồ sơ nộp sơm nhất, đầy đủ nhất"),
                ),
      
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Hạn nộp hết ngày: ", content: "12/11/2021"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Liên hệ nộp hồ sơ:", content: "",titleStyle: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: ColorResources.BLACK
                  ),),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Tên: ", content: "Đoàn Thị Minh Duyên"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Số điện thoại:", content: "0934322343"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Địa chỉ:", content: "51 Tô Hữu, Hải Châu, Thành Phố Đà Nẵng"),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: TextHighlight(title: "Email:", content: "tuyendung5sao@gmail.com"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
    /// Button
    ///
    Widget button(){
      return Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallButton(title: "Lưu", color: ColorResources.GREY, onPressed: (){}),
            SmallButton(title: "Ứng tuyển", color: ColorResources.PRIMARYCOLOR, onPressed: (){}),
            SmallButton(title: "Lưu", color: ColorResources.PRIMARYCOLOR, onPressed: (){}),
            SmallButton(title: "Ứng tuyển", color: ColorResources.RED, onPressed: (){
              _controller.onClickRecuitmentButton();
            }),
          ],
        ),
      );
    }
}