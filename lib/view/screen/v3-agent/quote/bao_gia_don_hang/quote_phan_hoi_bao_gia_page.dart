import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/card/bao_gia_card.dart';
import 'package:template/view/screen/v3-agent/quote/bao_gia_don_hang/quote_phan_hoi_bao_gia_controller.dart';

class V3QuotePhanHoiBaoGiaPage extends GetView<V3QuotePhanHoiBaoGiaController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3QuotePhanHoiBaoGiaController>(
        init: V3QuotePhanHoiBaoGiaController(),
        builder: (V3QuotePhanHoiBaoGiaController controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                //tab
                tabBarWidget(context: context),

                //item list
                ...List.generate(
                  controller.danhSachBaoGiaDonDichVuResponse.length,
                  (index) => _itemList(
                    context,
                    controller
                        .danhSachBaoGiaDonDichVuResponse[index].idDonDichVu!,
                        index,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// item list
  ///
  Widget _itemList(BuildContext context, DonDichVuResponse donDichVu, int index) {
    return BaoGiaCard(
      donHangName: donDichVu.tieuDe.toString(),
      donHangId: "",
      // controller.quanHuyenNameList[index]
      time: donDichVu.ngayKetThuc.toString().substring(11, 16),
      date: donDichVu.ngayKetThuc.toString().substring(0, 10),
      label: "Thợ ốp lát",
      content: "Công trình khách 5 sao",
      locationName: donDichVu.diaDiemBocHang.toString(),
      image: Images.location_example,
      onTap: controller.toReponse,
    );
  }

  ///
  /// selected tab
  ///
  Widget onSelectedTab(BuildContext context,
      {required String title, required int index, required bool isRight}) {
    return GestureDetector(
      onTap: () {
        controller.onChangeTab(index);
      },
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: DeviceUtils.getScaledWidth(context, .9).roundToDouble() / 2,
        decoration: BoxDecoration(
          borderRadius: isRight == false
              ? const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomRight:
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                ),
          color: controller.currentIndex == index
              ? ColorResources.PRIMARY
              : ColorResources.WHITE,
          border: controller.currentIndex == index
              ? null
              : Border.all(color: ColorResources.PRIMARY),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: controller.currentIndex == index
                ? ColorResources.WHITE
                : ColorResources.BLACK,
          ),
        ),
      ),
    );
  }

  ///
  /// tab
  ///
  Widget tabBarWidget({required BuildContext context}) {
    return Container(
      alignment: Alignment.center,
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, .1),
      child: Container(
        alignment: Alignment.center,
        width: DeviceUtils.getScaledWidth(context, .9).roundToDouble(),
        height: DeviceUtils.getScaledHeight(context, .07),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            onSelectedTab(context,
                title: controller.titleTabBar['DPH']!,
                index: 0,
                isRight: false),
            onSelectedTab(
              context,
              title: controller.titleTabBar['CPH']!,
              index: 1,
              isRight: true,
            ),
          ],
        ),
      ),
    );
  }
}
