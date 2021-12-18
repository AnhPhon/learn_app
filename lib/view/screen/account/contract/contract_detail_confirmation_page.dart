import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account/contract/contract_detail_confirmation_controller.dart';

class ContractDetailPage extends GetView<ContractDetailController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: "Xác nhận góp vốn",
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
      ),
      body: GetBuilder(
        builder: (ContractDetailController controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customer(context, controller: controller),
              authorizedPerson(context, controller: controller),
              contractInformation(context, controller: controller),
              contractPeriod(context, controller: controller),
              reciprocal(context, controller: controller),
              signature(context, controller: controller),
              button(controller),
            ],
          );
        },
      ),
    );
  }

  Widget title({String? lable, EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin ??
          EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_4X,
          ),
      width: IZIDimensions.iziSize.width,
      child: IZIText(
        text: lable ?? "Thời hạn hợp đồng",
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget customer(BuildContext context, {required ContractDetailController controller}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          title(
            lable: "Khách hàng",
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
              top: IZIDimensions.SPACE_SIZE_4X,
            ),
          ),
          content(
            lable: 'Tên đầy đủ',
            content: 'Đỗ Thanh Nhàn',
          ),
          content(
            lable: 'Điện thoại',
            content: '0999999999',
          ),
          content(
            lable: 'Điạ chỉ',
            content: 'Đà Nẵng',
          ),
          content(
            lable: 'Nơi ở hiện nay',
            content: 'Cẩm Lệ, TP Đà Nẵng',
          ),
          content(
            lable: 'Số CMND',
            content: '123456789',
          ),
          content(
            lable: 'Ngày cấp CMND',
            content: '12/12/2021',
          ),
          content(
            lable: 'Nơi cấp CMND',
            content: 'CA QUảng Nam',
          ),
          content(
            lable: 'Ngày sinh',
            content: '12/12/1999',
          ),
          content(
            lable: 'Giới tính',
            content: 'Nữ',
          ),
          content(
            lable: 'Ngân hàng',
            content: 'MB Bank',
          ),
          content(
            lable: 'Tài khoản ngân hàng',
            content: '123456678',
          ),
        ],
      ),
    );
  }

  Widget authorizedPerson(BuildContext context, {required ContractDetailController controller}) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          title(
            lable: "Người được ủy quyền",
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
          ),
          content(
            lable: 'Tên đầy đủ',
            content: 'Đỗ Thanh Nhàn',
          ),
          content(
            lable: 'Quan hệ',
            content: 'người nhà',
          ),
          content(
            lable: 'Số CMND',
            content: '123456789',
          ),
          content(
            lable: 'Ngày cấp CMND',
            content: '12/12/2021',
          ),
          content(
            lable: 'Nơi cấp CMND',
            content: 'CA QUảng Nam',
          ),
          content(
            lable: 'Ngày sinh',
            content: '12/12/1999',
          ),
          content(
            lable: 'Giới tính',
            content: 'Nữ',
          ),
          content(
            lable: 'Điện thoại',
            content: '093213213',
          ),
          content(
            lable: 'Điạ chỉ',
            content: 'Đà Nẵng',
          ),
          content(
            lable: 'Nơi ở hiện tại',
            content: 'Cẩm Lệ, TP Đà Nẵng',
          ),
        ],
      ),
    );
  }

  Widget contractInformation(BuildContext context, {required ContractDetailController controller}) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          title(
            lable: "Thông tin hợp đồng",
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
          ),
          content(
            lable: 'Loại hợp đồng',
            content: 'Trải nghiệm 303',
          ),
          content(
            lable: 'Tên loại hợp đồng',
            content: 'Hợp đồng trải nghiệm 303',
          ),
          content(
            lable: 'Số lượng hợp đồng',
            content: '1',
          ),
          content(
            lable: 'Tháng',
            content: '12',
          ),
          content(
            lable: 'Giá trị',
            content: '12.000.000',
          ),
          content(
            lable: 'Lãi / suất',
            content: '0.5',
          ),
          content(
            lable: 'Số tiền lãi',
            content: '60.000',
          ),
        ],
      ),
    );
  }

  Widget contractPeriod(BuildContext context, {required ContractDetailController controller}) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          title(
            lable: "Thời gian hợp đồng",
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
          ),
          content(
            lable: 'Ngày bắt đầu',
            content: '12/12/2021',
          ),
        ],
      ),
    );
  }

  Widget reciprocal(BuildContext context, {required ContractDetailController controller}) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          title(
            lable: "Đối ứng",
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
          ),
          content(
            lable: 'Loại đối ứng',
            content: 'TST 3 triệu 2',
          ),
          content(
            lable: 'Số tiền đối ứng',
            content: '2.000.000',
          ),
        ],
      ),
    );
  }

  Widget signature(BuildContext context, {required ContractDetailController controller}) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          title(
            lable: "Khách hàng ký tên ",
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
          ),
          sign(
            context,
            controller: controller,
          ),
        ],
      ),
    );
  }

  // Ký tên
  Widget sign(BuildContext context, {required ContractDetailController controller}) {
    return Container(
      height: IZIDimensions.ONE_UNIT_SIZE * 300,
      width: IZIDimensions.iziSize.width,
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_3X,
        ),
        boxShadow: IZIOther().boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BLUR_RADIUS_3X,
        ),
        child: Image.asset(
          ImagesPath.logo,
        ),
      ),
    );
  }

  Widget content({required String lable, required String content}) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IZIText(
            text: '$lable: ',
            style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w500),
          ),
          Flexible(
            child: IZIText(
              text: ' $content',
              maxLine: 2,
              style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(ContractDetailController controller) {
    return Row(
      children: [
        IZIButton(
          margin: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_4X,
            vertical: IZIDimensions.SPACE_SIZE_2X,
          ),
          colorBG: ColorResources.GREY,
          width: IZIDimensions.iziSize.width * 0.41,
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_3X,
          ),
          onTap: () {
            controller.onBack();
          },
          label: 'Từ chối',
        ),
        IZIButton(
          margin: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_4X,
            vertical: IZIDimensions.SPACE_SIZE_2X,
          ),
          width: IZIDimensions.iziSize.width * 0.41,
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_3X,
          ),
          onTap: () {
            controller.onConfirm();
          },
          label: 'Rút vốn',
        ),
      ],
    );
  }
}
