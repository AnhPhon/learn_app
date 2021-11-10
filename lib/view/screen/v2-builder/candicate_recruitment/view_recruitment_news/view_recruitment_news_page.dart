import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/view_recruitment_news/view_recruitment_news_controller.dart';

class V2ViewRecruitmentNewsPage
    extends GetView<V2ViewRecruitmentNewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: "Tin tuyển dụng"),
        body: SingleChildScrollView(
          child: GetBuilder(
              init: V2ViewRecruitmentNewsController(),
              builder: (V2ViewRecruitmentNewsController controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      content(controller: controller),
                      // Button tiếp tục
                      if (controller.isUngTuyen) Container(),
                      if (!controller.isUngTuyen)
                        postButton(context: context, controller: controller)
                    ],
                  ),
                );
              }),
        ));
  }

  ///
  /// Nội dung đơn
  ///
  Widget content({required V2ViewRecruitmentNewsController controller}) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          bottom: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Tiêu đề: ",
                    content: controller.titleController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Công ty: ",
                    content: controller.companyController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Địa chỉ: ",
                    content: controller.addressController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Giới tính: ",
                    content: controller.chooseSex == 1 ? 'Nam' : 'Nữ'),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Số lượng tuyển: ",
                    content: controller.amountController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Hình thức làm việc: ",
                    content: controller.hinhThucLamViecController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Trình độ học vấn: ",
                    content: controller.trinhDoHocVanController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Chuyên ngành chính: ",
                    content: controller.chuyenNganhChinhController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Chuyên ngành phụ: ",
                    content: controller.chuyenNganhPhuController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Số năm kinh nghiệm: ",
                    content: controller.soNamKinhNghiemController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Mức lương ban đầu dự kiến: ",
                    content: controller.mucLuongDuKienController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Nơi làm việc: ",
                    content: controller.noiLamViecController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Thời gian thử việc: ",
                    content: controller.thoiGianThucTapController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Mô tả công việc: ",
                    content: controller.descController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Yêu cầu công việc: ",
                    content: controller.requiredController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Chế độ quyền lợi: ",
                    content: controller.benifitController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Ưu tiên: ",
                    content: controller.prioritizedController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Hạn nộp hết ngày: ",
                    content: controller.hanNopHoSo.toString()),
              ),
              const Padding(
                padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                  title: "Liên hệ nộp hồ sơ: ",
                  content: "",
                  titleStyle: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: ColorResources.BLACK),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Tên: ", content: controller.nameController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Số điện thoại: ",
                    content: controller.phoneController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Địa chỉ: ",
                    content: controller.contactAddressController.text),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextHighlight(
                    title: "Email: ", content: controller.emailController.text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Nút tiếp tục
  ///

  Widget postButton(
      {required BuildContext context,
      required V2ViewRecruitmentNewsController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SmallButton(
            title: 'Lưu',
            color: ColorResources.PRIMARY,
            onPressed: controller.onBtnLuuTinTuyenDung,
          ),
          SmallButton(
            title: 'Ứng tuyển',
            color: ColorResources.RED,
            onPressed: controller.onClickRecuitmentButton,
          )
        ],
      ),
    );
  }
}
