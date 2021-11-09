import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/screen/v3-agent/account/customer_management/customer_detail/customer_detail_controller.dart';

class V3CustomerDetailPage extends GetView<V3CustomerDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3CustomerDetailController>(
      init: V3CustomerDetailController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Column(
            children: [
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //avatar
              _avatar(context),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //tab bar
              _tabBarWidget(context: context, controller: controller),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //list don hang
              _orderList(context),

              //form
              formLienHe(context, controller: controller),
            ],
          ),
          bottomNavigationBar: botomQuaApp(context, controller: controller),
        );
      },
    );
  }

  ///
  ///avatar
  ///
  Widget _avatar(BuildContext context) {
    return GetBuilder<V3CustomerDetailController>(
      builder: (controller) {
        return Column(
          children: [
            //image
            Container(
              margin:
                  const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              height: DeviceUtils.getScaledSize(context, .3),
              width: DeviceUtils.getScaledSize(context, .3),
              child: ClipOval(
                child: FadeInImageCustom(
                  urlImage: controller.taiKhoanResponse.hinhDaiDien.toString(),
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),

            //full name
            Text(
              controller.taiKhoanResponse.hoTen.toString(),
              style: Dimensions.fontSizeStyle16w600(),
            ),
          ],
        );
      },
    );
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V3CustomerDetailController controller}) {
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
            title: controller.titleTabBar[index].toString(),
          );
        },
      ),
    );
  }

  ///
  ///list don hang
  ///
  Widget _orderList(BuildContext context) {
    return GetBuilder<V3CustomerDetailController>(
      builder: (controller) {
        if (controller.isLoadingLienHe) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return (controller.visible && controller.currentIndex == 1)
            ? const SizedBox.shrink()
            : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (controller.currentIndex == 0)
                            ? controller.donDichVuList.length
                            : controller.lienHeRiengList.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              left: Dimensions.PADDING_SIZE_LARGE,
                              right: Dimensions.PADDING_SIZE_LARGE,
                            ),
                            child: ItemListWidget(
                              title: (controller.currentIndex == 0)
                                  ? controller.donDichVuList[index].tieuDe
                                      .toString()
                                  : controller.lienHeRiengList[index].noiDung
                                      .toString(),
                              iconSubTitle: const Icon(
                                Icons.location_on,
                                size: Dimensions.ICON_SIZE_SMALL,
                              ),
                              rowText1:
                                  "${PriceConverter.convertPrice(context, double.parse((controller.currentIndex == 0) ? controller.donDichVuList[index].tongDon.toString() : controller.lienHeRiengList[index].giaTriGiaoDich.toString()))} vnđ",
                              colorRowText1: ColorResources.RED,
                              rowText2: DateConverter.formatDateTime(
                                (controller.currentIndex == 0)
                                    ? controller.donDichVuList[index].createdAt
                                        .toString()
                                    : controller
                                        .lienHeRiengList[index].ngayGiaoDich
                                        .toString(),
                              ),
                              onTap: () {},
                              isSpaceBetween: true,
                              urlImage: controller.taiKhoanResponse.hinhDaiDien
                                  .toString(),
                              boxShadow: boxShadowALitle,
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //create form
                      createForm(),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_SMALL,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }

  ///
  ///create form
  ///
  Widget createForm() {
    return (controller.currentIndex == 1 && controller.visible == false)
        ? GestureDetector(
            onTap: () => controller.visibleOnChanged(),
            child: Container(
              alignment: Alignment.center,
              decoration: const ShapeDecoration(
                color: ColorResources.GREY,
                shape: CircleBorder(),
              ),
              child: const Icon(
                Icons.add,
                size: Dimensions.ICON_SIZE_LARGE,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  ///
  ///bottom qua app
  ///
  Widget botomQuaApp(BuildContext context,
      {required V3CustomerDetailController controller}) {
    return (controller.visible && controller.currentIndex == 1)
        ? const SizedBox.shrink()
        : Container(
            height: DeviceUtils.getScaledHeight(context, .12),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              ),
              color: ColorResources.WHITE,
              boxShadow: boxShadowMedium,
            ),
            child: RowText(
              text1: (controller.currentIndex == 0)
                  ? "Tổng giá trị thanh toán"
                  : "Tổng giá trị các đơn hàng",
              text2: "${PriceConverter.convertPrice(
                context,
                (controller.currentIndex == 0)
                    ? controller.totalQuaApp.toDouble()
                    : controller.totalLienHe.toDouble(),
              )} vnđ",
              colorRed: true,
            ),
          );
  }

  ///
  ///form lien he
  ///
  Widget formLienHe(BuildContext context,
      {required V3CustomerDetailController controller}) {
    return Visibility(
      visible: controller.visible,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputWidget(
                label: "Ngày giao dịch",
                labelBold: true,
                obligatory: true,
                textEditingController: controller.dateController,
                width: .9,
                allowEdit: false,
                isDate: true,
                suffixIcon: const Icon(Icons.calendar_today_outlined),
                fillColor: Colors.transparent,
                isddMMyyyy: true,
              ),
              InputWidget(
                label: "Giá trị giao dịch",
                labelBold: true,
                obligatory: true,
                textEditingController: controller.totalController,
                fillColor: Colors.transparent,
                textInputType: TextInputType.number,
                thousandsSeparator: true,
                width: .9,
                padding: const EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
              ),
              InputWidget(
                label: "Nội dung",
                labelBold: true,
                obligatory: true,
                textEditingController: controller.contentController,
                fillColor: Colors.transparent,
                width: .9,
                maxLine: 5,
                padding: const EdgeInsets.only(
                  top: Dimensions.PADDING_SIZE_DEFAULT,
                ),
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_LARGE,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BtnCustomBorder(
                    onTap: () => controller.visibleOnChanged(),
                    text: "Huỷ",
                    width: DeviceUtils.getScaledWidth(context, .4),
                  ),
                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  BtnCustom(
                    onTap: () {
                      controller.onBtnUpdate();
                    },
                    color: ColorResources.PRIMARY,
                    text: "Cập nhật",
                    width: DeviceUtils.getScaledWidth(context, .4),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_LARGE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
