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

class V1G7PriceListPage extends GetView<V1G7PriceListController>{

  final V1G7PriceListController _controller = Get.find<V1G7PriceListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tin tuyển dụng"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Tiêu tề nhóm công việc
              const GroupTitle(title: "Dịch vụ đăng tin tuyển dụng"),


              content(),
              // Button tiếp tục
              button(controller: _controller),
            ],
          ),
        ),
      )
    );
  }

  ///
  /// Nội dung đơn
  ///
  Widget content(){
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          priceListPosted(
            children: [
              priceType(title: "Đăng 4 tuần",price: 100000,groupValue: 1,value: 1),
              priceType(title: "Đăng 4 tuần + lọc hồ sơ 100đ/8 tuần",price: 100000,groupValue: 1,value: 1),
              priceType(title: "Đăng 4 tuần + lọc hồ sơ 300/ 16 tuần",price: 100000,groupValue: 1,value: 1)
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: priceListFilter(
              children: [
                priceType(title: "Lọc hồ sơ 90 điểm",price: 90000,groupValue: 1,value: 1),
                priceType(title: "Lọc hồ sơ 100 điểm",price: 100000,groupValue: 1,value: 1),
                priceType(title: "Lọc hồ sơ 500 điểm",price: 50000,groupValue: 1,value: 1)
              ]
            ),
          ),
        ],
      ),
    );
  }

  Widget priceListPosted({required List<Widget> children}){
    return BoxShadowWidget(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Bảng giá đăng tin", style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              fontWeight: FontWeight.bold
            )),
          ),
          ...children
        ],
      ),
    );
  }

  Widget priceListFilter({required List<Widget> children}){
    return BoxShadowWidget(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Bảng giá lọc hồ sơ", style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
              fontWeight: FontWeight.bold
            )),
          ),
          ...children
        ],
      ),
    );
  }

  Widget priceType({required String title, required int value, required int groupValue, required double price}){
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Radio(value: false, groupValue: true, onChanged: (val){}),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(title, textAlign: TextAlign.start,style: const TextStyle(
                fontSize: Dimensions.PADDING_SIZE_LARGE,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("${CurrencyConverter.currencyConverterVND(price)} VNĐ",style: const TextStyle(
              fontSize: Dimensions.PADDING_SIZE_LARGE,
              color: ColorResources.RED
            )),
          )
        ],
      ),
    );
  }

  ///
  /// Nút tiếp tục
  ///

  Widget button({required V1G7PriceListController controller}){
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