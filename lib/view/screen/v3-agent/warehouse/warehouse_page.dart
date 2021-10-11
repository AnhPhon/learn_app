import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v3-agent/warehouse/warehouse_controller.dart';

class V3WarehousePage extends GetView<V3WarehouseController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3WarehouseController>(
        init: V3WarehouseController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //search
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InputWidget(
                    width: double.infinity,
                    textEditingController: controller.searchController,
                    hintText: "Tìm kiếm",
                    prefixIcon: const Icon(
                      Icons.search,
                      size: Dimensions.ICON_SIZE_DEFAULT,
                    ),
                    isColorFieldWhite: true,
                  ),
                ),

                //item
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext ctx, int i) {
                        return _item(
                          context,
                          title: "Sản phẩm ${i + 1} ",
                          unit: "unit",
                          price: "${Random().nextInt(4000000) + 1000000} vnđ",
                          urlImg: controller.urlImage,
                          code: "SP${Random().nextInt(2000) + 1000}",
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  ///
  ///item
  ///
  Widget _item(BuildContext context,
      {required String title,
      required String unit,
      required String price,
      required String code,
      required String urlImg}) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_SMALL,
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  image: urlImg,
                  height: DeviceUtils.getScaledHeight(context, .08),
                  width: double.infinity,
                  fit: BoxFit.fill,
                  imageErrorBuilder: (c, o, s) => Image.asset(
                    Images.placeholder,
                  ),
                ),
              ),
              const SizedBox(
                width: Dimensions.MARGIN_SIZE_SMALL,
              ),
              Expanded(
                flex: 7,
                child: SizedBox(
                  height: DeviceUtils.getScaledHeight(context, .08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        style: Dimensions.fontSizeStyle16w600(),
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(unit),
                            VerticalDivider(
                              color: ColorResources.BLACK.withOpacity(.7),
                            ),
                            Text(price),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Divider(
            height: 20,
            color: ColorResources.BLACK.withOpacity(.7),
          ),

          //product code
          Text(code),
        ],
      ),
    );
  }
}