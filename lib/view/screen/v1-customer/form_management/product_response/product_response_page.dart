import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/form_management/product_response/product_response_controller.dart';

class V1ProductResponsePage extends GetView<V1ProductResponseController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProductResponseController>(
        init: V1ProductResponseController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  Container(
                      alignment: Alignment.center,
                      child: _textTitle(context,
                          title: "Dịch vụ xây dựng toàn diện")),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
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

                        //container in bill
                        _providerBill(
                          context,
                          name: "Xi măng",
                          unit: "Tấn",
                          quanlity: "5",
                          specifications: "Kim đỉnh",
                          price: "300.000 VND",
                        ),
                        _providerBill(
                          context,
                          name: "Xi măng",
                          unit: "Tấn",
                          quanlity: "5",
                          specifications: "Kim đỉnh",
                          price: "300.000 VND",
                        ),

                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_LARGE,
                        ),

                        //image bill
                        _imageBill(context),

                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                        ),
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
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
          fontWeight: FontWeight.bold,
        ),
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
      required String specifications,
      required String price}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.MARGIN_SIZE_SMALL,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.MARGIN_SIZE_LARGE,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        color: ColorResources.WHITE,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
          ),
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
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            Text("Quy cách: $specifications"),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            Text("Số lượng: $quanlity"),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            Text("Đơn vị: $unit"),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
            RichText(
              text: TextSpan(
                  text: "Đơn giá: ",
                  style: const TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      color: ColorResources.BLACK),
                  children: [
                    TextSpan(
                        text: price,
                        style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            color: ColorResources.RED)),
                  ]),
            ),
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
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.PRIMARY),
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      height: DeviceUtils.getScaledHeight(context, .158),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                child: Image.asset(
                  Images.newsTemplate,
                  fit: BoxFit.fill,
                  height: DeviceUtils.getScaledHeight(context, .122),
                  width: DeviceUtils.getScaledWidth(context, .254),
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
      height: DeviceUtils.getScaledHeight(context, .19),
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        bottom: Dimensions.PADDING_SIZE_SMALL,
      ),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE - 5),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE - 5),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, -2))
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: ColorResources.BLACK,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          fontWeight: FontWeight.bold,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_SMALL,
              ),
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
}
