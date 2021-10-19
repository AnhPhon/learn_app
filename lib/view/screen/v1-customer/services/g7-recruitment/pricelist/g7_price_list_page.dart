import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_list_controller.dart';

class V1G7PriceListPage extends GetView<V1G7PriceListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: "Tin tuyển dụng"),
        body: SingleChildScrollView(
          child: GetBuilder(
              init: V1G7PriceListController(),
              builder: (V1G7PriceListController controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tiêu tề nhóm công việc
                      const GroupTitle(title: "Dịch vụ đăng tin tuyển dụng"),

                      content(controller: controller),
                      // Button tiếp tục
                      button(controller: controller),
                    ],
                  ),
                );
              }),
        ));
  }

  ///
  /// Nội dung đơn
  ///
  Widget content({required V1G7PriceListController controller}) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          priceListPosted(children: [
            ...List.generate(
                controller.bangGiaDangTinModel.length,
                (index) => priceTypeDangTin(
                    controller: controller,
                    title:
                        controller.bangGiaDangTinModel[index].tieuDe.toString(),
                    price: double.parse(controller
                        .bangGiaDangTinModel[index].donGia
                        .toString()),
                    groupValue: controller.chooseDangTin.toString(),
                    value: controller.bangGiaDangTinModel[index].id.toString()))
          ]),
          Padding(
            padding:
                const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: priceListFilter(children: [
              ...List.generate(
                  controller.bangGiaLocHoSoModel.length,
                  (index) => priceTypeLocHoSo(
                      controller: controller,
                      title: controller.bangGiaLocHoSoModel[index].tieuDe
                          .toString(),
                      price: double.parse(controller
                          .bangGiaLocHoSoModel[index].donGia
                          .toString()),
                      groupValue: controller.chooseLocHoSo.toString(),
                      value:
                          controller.bangGiaLocHoSoModel[index].id.toString()))
            ]),
          ),
        ],
      ),
    );
  }

  Widget priceListPosted({required List<Widget> children}) {
    return BoxShadowWidget(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Bảng giá đăng tin",
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                    fontWeight: FontWeight.bold)),
          ),
          ...children
        ],
      ),
    );
  }

  Widget priceListFilter({required List<Widget> children}) {
    return BoxShadowWidget(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Bảng giá lọc hồ sơ",
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                    fontWeight: FontWeight.bold)),
          ),
          ...children
        ],
      ),
    );
  }

  Widget priceTypeDangTin(
      {required String title,
      required String value,
      required String groupValue,
      required double price,
      required V1G7PriceListController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child: GestureDetector(
        onTap: () {
          controller.getChangeDangTin(value);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Radio(
                value: value,
                groupValue: groupValue,
                onChanged: (String? val) {
                  controller.getChangeDangTin(val.toString());
                }),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: Dimensions.PADDING_SIZE_LARGE,
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(
                  "${CurrencyConverter.currencyConverterVND(price)} VNĐ",
                  style: const TextStyle(
                      fontSize: Dimensions.PADDING_SIZE_LARGE,
                      color: ColorResources.RED)),
            )
          ],
        ),
      ),
    );
  }

  Widget priceTypeLocHoSo(
      {required String title,
      required String value,
      required String groupValue,
      required double price,
      required V1G7PriceListController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child: GestureDetector(
        onTap: () {
          controller.getChangeLocHoSo(value);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Radio(
                value: value,
                groupValue: groupValue,
                onChanged: (String? val) {
                  controller.getChangeLocHoSo(val.toString());
                }),
            Flexible(
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(
                    right: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: Dimensions.PADDING_SIZE_LARGE,
                    )),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(
                  "${CurrencyConverter.currencyConverterVND(price)} VNĐ",
                  style: const TextStyle(
                      fontSize: Dimensions.PADDING_SIZE_LARGE,
                      color: ColorResources.RED)),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// Nút tiếp tục
  ///

  Widget button({required V1G7PriceListController controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: controller.onClickContinueButton,
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }
}
