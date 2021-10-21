import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_register/insurance_register_controller.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/tab_bar_widget.dart';

class V1InsuranceRegisterPage extends GetView<V1InsuranceRegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1InsuranceRegisterController>(
        init: V1InsuranceRegisterController(),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //tab bar
                  _tabBarWidget(context: context, controller: controller),

                  if (controller.currentIndex == 0)
                    (controller.dangKyBaoHiemResponse.isEmpty)
                        ? const Padding(
                            padding: EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                            ),
                            child: Text("Bạn chưa mua bảo hiểm"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.dangKyBaoHiemResponse.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return ItemListWidget(
                                onTap: () {},
                                urlImage: controller
                                    .dangKyBaoHiemResponse[index]
                                    .idBaoHiem!
                                    .hinhAnh!,
                                title: controller.dangKyBaoHiemResponse[index]
                                    .idBaoHiem!.ten!,
                                rowText1:
                                    "${controller.dangKyBaoHiemResponse[index].idBaoHiem!.phi}vnđ",
                                colorRowText1: ColorResources.RED,
                                rowText2:
                                    "Ngày hết hạn: ${controller.dangKyBaoHiemResponse[index].ngayHetHan}",
                                isSpaceBetween: true,
                              );
                            })
                  else
                    SingleChildScrollView(
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
            ),
            bottomNavigationBar: (controller.currentIndex == 0)
                ? null
                : _btnBottom(context, controller: controller),
          );
        });
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V1InsuranceRegisterController controller}) {
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
          }),
    );
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE + 2,
      ),
      child: Text(
        title,
        style: Dimensions.fontSizeStyle20w600(),
      ),
    );
  }

  ///
  ///fee List
  ///
  Widget _radFeeList(BuildContext context,
      {required V1InsuranceRegisterController controller}) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.baoHiemResponse.length,
        itemBuilder: (BuildContext ctx, int index) {
          return RadioListTile(
            title: Text(
              "${PriceConverter.convertPrice(
                context,
                double.parse(
                  controller.baoHiemResponse[index].phi.toString(),
                ),
              )} vnđ",
            ),
            value: index,
            activeColor: ColorResources.PRIMARY,
            groupValue: controller.indexFee,
            onChanged: controller.setSelectedIndexFee,
          );
        });
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context,
      {required V1InsuranceRegisterController controller}) {
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
