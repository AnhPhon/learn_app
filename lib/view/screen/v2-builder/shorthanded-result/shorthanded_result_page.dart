import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/basewidget/getx_smart_refresh/getx_smart_refresh_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded-result/shorthanded_result_controller.dart';

class V2ShorthandedResultPage extends GetView<V2ShorthandedResultController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedResultController>(
        init: V2ShorthandedResultController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(
              title: controller.title,
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //tab bar button
                _tabBarWidget(context: context, controller: controller),

                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),

                //tab view list
                _itemList(controller),
              ],
            ),
          );
        });
  }

  ///
  /// tab bar button
  ///
  Widget _tabBarWidget({required BuildContext context, required V2ShorthandedResultController controller}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .06),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.titleTabBar.length,
        itemBuilder: (BuildContext context, int index) {
          return TabBarWidget(
            onTap: () => controller.onChangeTab(index),
            index: index,
            currentIndex: controller.currentIndex.value,
            title: controller.titleTabBar[index]['tieuDe'].toString(),
          );
        },
      ),
    );
  }

  ///
  ///tab view list
  ///

  Widget _itemList(V2ShorthandedResultController controller) {
    return Expanded(
      child: DefaultTabController(
        length: controller.titleTabBar.length,
        child: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(), // add
            controller: controller.tabController,
            children: List.generate(
              controller.titleTabBar.length,
                  (index) {
                return GetXSmartRefreshPage(
                  key: Key('GetXSmartRefreshPageV2ShorthandedResult_$index'),
                  enablePullUp: true,
                  enablePullDown: true,
                  onLoading: controller.onLoading,
                  onRefresh: controller.onRefresh,
                  child: Obx(
                        () => listViewItemBuilder(controller),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget listViewItemBuilder(V2ShorthandedResultController controller) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.titleTabBar[controller.currentIndex.value]['danhSachBaoGiaDonDichVuResponse'].length as int,
      itemBuilder: (BuildContext ctx, int index) {
        return itemDanhSachBaoGia(controller, index, controller.titleTabBar[controller.currentIndex.value]['danhSachBaoGiaDonDichVuResponse']![index] as DanhSachBaoGiaDonDichVuResponse);
      },
    );
  }

  ItemListWidget itemDanhSachBaoGia(V2ShorthandedResultController controller, int index, DanhSachBaoGiaDonDichVuResponse danhSachBaoGiaDonDichVu) {
    return ItemListWidget(
        urlImage: danhSachBaoGiaDonDichVu.idDonDichVu!.hinhAnhChiTiet
            .toString(),
        onTap: () => controller.onDetailClick(
            danhSachBaoGiaDonDichVu),
        title: danhSachBaoGiaDonDichVu.idDonDichVu!.tieuDe
            .toString(),
        icon1: const Icon(Icons.location_on),
        rowText1: danhSachBaoGiaDonDichVu.idDonDichVu!.diaDiemLamViec !=
                null
            ? danhSachBaoGiaDonDichVu.idDonDichVu!
                .diaDiemLamViec
                .toString()
            : '',
        colorRowText1: ColorResources.GREY,
        // icon2: const Icon(Icons.calendar_today),
        rowText2: controller.currentIndex.value == 0 ? danhSachBaoGiaDonDichVu.idDonDichVu!
        .idTrangThaiThanhToan!.tieuDe
        .toString() : '',
      );
  }
}
