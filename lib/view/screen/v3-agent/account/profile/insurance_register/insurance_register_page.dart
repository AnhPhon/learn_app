import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/screen/v3-agent/account/profile/insurance_register/insurance_register_controller.dart';

class V3InsuranceRegisterPage extends GetView<V3InsuranceRegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3InsuranceRegisterController>(
      init: V3InsuranceRegisterController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(
            title: (controller.currentIndex == 0)
                ? controller.title0
                : controller.title1,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //tab bar
              _tabBarWidget(context: context, controller: controller),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_SMALL,
              ),

              if (controller.currentIndex == 0)
                Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    enablePullUp: controller.dangKyBaoHiemResponse.isNotEmpty,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    footer: const ClassicFooter(
                      loadingText: "Đang tải...",
                      noDataText: "Không có dữ liệu",
                      canLoadingText: "Kéo lên để tải thêm dữ liệu",
                    ),
                    child: (controller.dangKyBaoHiemResponse.isEmpty)
                        ? const Padding(
                            padding: EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                            ),
                            child: Center(
                              child: Text("Bạn chưa mua bảo hiểm"),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.dangKyBaoHiemResponse.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                child: ItemListWidget(
                                  onTap: () {},
                                  urlImage: controller
                                      .dangKyBaoHiemResponse[index]
                                      .idBaoHiem!
                                      .hinhAnh,
                                  title: controller.dangKyBaoHiemResponse[index]
                                      .idBaoHiem!.ten!,
                                  subTitle: (controller
                                              .dangKyBaoHiemResponse[index]
                                              .phi ==
                                          "null")
                                      ? ""
                                      : "${PriceConverter.convertPrice(context, double.parse(controller.dangKyBaoHiemResponse[index].phi.toString()))}vnđ",
                                  colorSubTitle: ColorResources.RED,
                                  rowText2: (controller
                                              .dangKyBaoHiemResponse[index]
                                              .ngayHetHan ==
                                          "null")
                                      ? ""
                                      : "Ngày hết hạn: ${DateConverter.formatDateTime(controller.dangKyBaoHiemResponse[index].ngayHetHan.toString())}",
                                  isSpaceBetween: true,
                                ),
                              );
                            }),
                  ),
                )
              else
                Expanded(
                  child: Column(
                    children: [
                      //title
                      _textTitle(context,
                          title: "Bạn vui lòng chọn mức phí phù hợp"),

                      //red fee list
                      _radFeeList(context, controller: controller),
                    ],
                  ),
                ),
            ],
          ),
          bottomNavigationBar: (controller.currentIndex == 0)
              ? null
              : _btnBottom(context, controller: controller),
        );
      },
    );
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V3InsuranceRegisterController controller}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .07),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.titleTabBar.length,
        itemBuilder: (BuildContext context, int index) {
          return TabBarWidget(
              onTap: () => controller.onChangeTab(index),
              index: index,
              currentIndex: controller.currentIndex,
              title: controller.titleTabBar[index].toString());
        },
      ),
    );
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle20w600(),
      ),
    );
  }

  ///
  ///fee List
  ///
  Widget _radFeeList(BuildContext context,
      {required V3InsuranceRegisterController controller}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.baoHiemResponse!.phis!.length,
      itemBuilder: (BuildContext ctx, int index) {
        return RadioListTile(
          title: Text(
            "Phí ${PriceConverter.convertPrice(
              context,
              double.parse(
                controller.baoHiemResponse!.phis![index].toString(),
              ),
            )} vnđ. STBH: ${PriceConverter.convertPrice(
              context,
              double.parse(
                controller.baoHiemResponse!.soTienBaoHiems![index].toString(),
              ),
            )} vnđ",
          ),
          value: index,
          activeColor: ColorResources.PRIMARY,
          groupValue: controller.indexFee,
          onChanged: controller.setSelectedIndexFee,
        );
      },
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context,
      {required V3InsuranceRegisterController controller}) {
    return Padding(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: BtnCustom(
        onTap: () => controller.onCheckoutClick(context),
        color: ColorResources.PRIMARY,
        text: "Thanh toán",
        width: double.infinity,
      ),
    );
  }
}
