import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/dang_ky_viec_moi_model.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/work_register/preview/work_preview_controller.dart';

class V2WorkPreviewPage extends GetView<V2WorkPreviewController> {
  DangKyViecMoiModel? dangKyModel;
  @override
  V2WorkPreviewController controller = Get.put(V2WorkPreviewController());

  V2WorkPreviewPage({this.dangKyModel});
  @override
  Widget build(BuildContext context) {
    print(dangKyModel);
    return Scaffold(
      appBar: const AppBarWidget(title: "Hồ sơ ứng tuyển"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Thông tin người
            // CandidateCard(),

            // Nội dung hồ sơ
            content(context),
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: LongButton(
                  title: "Hoàn thiện và lưu trữ ứng tuyển",
                  color: ColorResources.PRIMARYCOLOR,
                  onPressed: () {
                    controller.toDonePage();
                  }),
            )
          ],
        ),
      ),
    );
  }

  ///
  ///Nội dung hồ sơ
  ///

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nội dung hồ sơ
          const TextHighlight(
            title: "Mục tiêu nghề ngiệp: ",
            content:
                "\nĐược làm việc trong môi trường chuyên nghiệp, có chế độ tốt.Nâng cao được trình độ, kỹ năng chuyên môn.Cống hiến năng lực bản thân và mong có cơ hội thăng tiến.",
          ),
          const TextHighlight(
            title: "Bằng cấp và trình độ: ",
            content:
                "\nTrình độ học vấn: Đại học\nChuyên ngành: Kiến trúc sư\nTốt nghiệp loại: Khá\nĐơn vị đào tạo: Đại học Duy Tân",
          ),
          const TextHighlight(
            title: "Chọn chức vụ, kinh nghiệm, mức lương,...: ",
            content:
                "\nChức vụ hiện tại: Nhân viên\nChức vụ mong muốn: Nhân viên\nSố năm kinh nghiệm: 2 năm\nMức lương đề xuất tối thiểu: 8.000.000 vnđ/tháng\nNơi làm việc mong muốn nhất:  Đà Nẵng, Quảng Nam\nNgành nghề mong muốn ứng tuyển: Thiết kế/ Kiến trúc/ \nNội thất xây dựng dân dụng và công nghiệp",
          ),
          const TextHighlight(
            title: "Kê khai kinh nghiệm (kê khai rõ - cơ hội tuyển dụng lớn)",
            content: "",
            titleStyle: TextStyle(
                decoration: TextDecoration.underline,
                color: ColorResources.BLACK,
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                fontWeight: FontWeight.bold),
          ),
          const TextHighlight(
            title: "Kết quả, thành tích đạt được: ",
            content:
                "\n+Hoàn thành tất cả công việc đươc giao\n+Được tăng lương cho thành tích vượt trội\nTừ 10/2020 đến 08/2021\n-Đơn vị: Công ty TNHH Danahome\n-Chức vụ: Nhân viên\n-Mức lương: 11.000.000vnđ/tháng\nCông việc phụ trách:\n+Phụ trách công tác thiết kế nội thất các công trình nhà dân.\n+Tìm hiểu các mẫu vật liệu mới để dưa vào thiết kế 3d\nKết quả, thành tích đạt được:\n+Hoàn thành tất cả công việc được giao",
          ),
          const TextHighlight(
            title: "Kỹ năng và sở trường làm việc: ",
            content:
                "-Kỹ năng giao tiếp tốt, làm việc độc lập, làm việc theo nhó, giải quyết vấn đề, linh hoạt.\n-Sở trường chuyên thiết kế nội thất",
          ),
          const TextHighlight(
            title: "Ngoại ngữ: ",
            content:
                " -Ngôn ngữ: Tiếng Anh\n+Nghe: Khá\n+Đọc: Khá\n+Nói: Khá\n+Viết: Khá\n-Trình độ: Bằng C",
          ),
          const TextHighlight(
            title: "Tin học: ",
            content: "\n+Word: Khá\n+Excel: Khá\n+Internet: Khá",
          ),
          const TextHighlight(
            title: "Sở thích: ",
            content:
                "\n-Đọc sách, làm thơ, lập trình \n-Ca hát, văn nghệ\n-Thể thao, du lịch",
          ),
          const TextHighlight(
            title: "Ảnh bằng cấp (nếu có) ",
            content: "",
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: SizedBox(
              height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
              width: DeviceUtils.getScaledWidth(context, 1),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  child: Image.asset(
                    Images.admin_background,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          const Label(
            label: "Ảnh hồ sơ xin việc (nếu có)",
            obligatory: false,
            horizontalPadding: 0,
          ),
          SizedBox(
            height: Dimensions.AVATAR_SQUARE_SIZE_LARGE,
            width: DeviceUtils.getScaledWidth(context, 1),
            child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                child: Image.asset(
                  Images.admin_background,
                  fit: BoxFit.cover,
                )),
          ),
          const Label(
            label: "File hồ sơ xin việc (nếu có)",
            obligatory: false,
            horizontalPadding: 0,
          ),
          GetBuilder(
            builder: (V2WorkPreviewController controller) {
              return fileCv();
            },
          ),
          // Tạo 1 khoảng trắng dưới khỏi ẩn 1 widget
          const SizedBox(
            height: Dimensions.AVATAR_SQUARE_SIZE_EXTRA_SMALL,
          )
        ],
      ),
    );
  }

  Widget fileCv() {
    return const Text(
      "Nguyễn_Văn_A_LÁI_XE_BEN.pdf",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      ),
    );
  }
}
