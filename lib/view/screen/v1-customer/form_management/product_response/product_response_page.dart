import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/form_management/product_response/product_response_controller.dart';

class V1ProductResponsePage extends GetView<V1ProductResponseController> {
  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, 0.03)),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  ///
  ///provider bill
  ///
  Widget _providerBill(BuildContext context,
      {required String name,
      required String unit,
      required String quanlity,
      required String specifications}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, 0.015)),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, 0.015),
          horizontal: DeviceUtils.getScaledWidth(context, 0.055)),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 10),
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: ColorResources.BLACK),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tên vật liệu: $name"),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.013)),
            Text("Quy cách: $specifications"),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.013)),
            Text("Số lượng: $quanlity"),
            SizedBox(height: DeviceUtils.getScaledHeight(context, 0.013)),
            Text("Đơn vị: $unit"),
          ],
        ),
      ),
    );
  }

  ///
  ///image bill
  ///
  Widget _imageBill(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.025)),
      decoration: BoxDecoration(
          border: Border.all(color: ColorResources.PRIMARY),
          borderRadius: BorderRadius.circular(5)),
      height: DeviceUtils.getScaledHeight(context, 0.158),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  "assets/images/news_template.png",
                  fit: BoxFit.fill,
                  height: 93,
                  width: 100,
                ),
              ),
            );
          }),
    );
  }

  ///
  ///bottom sheet
  ///
  Widget _bottomSheet(
      BuildContext context, V1ProductResponseController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.19),
      padding: EdgeInsets.only(
          left: DeviceUtils.getScaledWidth(context, 0.038),
          right: DeviceUtils.getScaledWidth(context, 0.038),
          top: DeviceUtils.getScaledHeight(context, 0.035),
          bottom: DeviceUtils.getScaledHeight(context, 0.026)),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, -2))
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
            color: ColorResources.BLACK,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            fontWeight: FontWeight.bold),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, 0.025)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Giá trị đơn hàng"),
                  Text(
                    "11.000.000 VND",
                    style: TextStyle(color: ColorResources.RED),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BtnCustom(
                    color: ColorResources.GREY,
                    text: "Huỷ",
                    onTap: () {},
                    width: DeviceUtils.getScaledWidth(context, 0.85) / 2),
                BtnCustom(
                    color: ColorResources.PRIMARY,
                    text: "Đồng ý",
                    onTap: () => controller.onAcceptClick(),
                    width: DeviceUtils.getScaledWidth(context, 0.85) / 2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProductResponseController>(
        init: V1ProductResponseController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AppBarWidget(title: controller.title),

                  //title
                  Container(
                      alignment: Alignment.center,
                      child: _textTitle(context,
                          title: "Dịch vụ xây dựng toàn diện")),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledWidth(context, 0.025)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textTitle(context,
                            title: "Công việc: Thợ ốp lót công trình 5 sao"),

                        //provider bill
                        const Text(
                          "Đơn giá phản hồi từ nhà cung cấp",
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                              fontWeight: FontWeight.bold),
                        ),
                        _providerBill(context,
                            name: "Xi măng",
                            unit: "Tấn",
                            quanlity: "5",
                            specifications: "Kim đỉnh"),
                        _providerBill(context,
                            name: "Xi măng",
                            unit: "Tấn",
                            quanlity: "5",
                            specifications: "Kim đỉnh"),

                        SizedBox(
                            height: DeviceUtils.getScaledHeight(context, 0.03)),

                        //image bill
                        _imageBill(context),

                        SizedBox(
                            height: DeviceUtils.getScaledHeight(context, 0.04))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _bottomSheet(context, controller),
          );
        });
  }
}
