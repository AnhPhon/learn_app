import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';
import 'package:template/view/screen/v1-customer/news/news_controller.dart';

class V1NewsPage extends GetView<V1NewsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1NewsController>(
      init: V1NewsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(
            title: controller.title,
            isNotBack: true,
          ),
          body: _itemList(controller: controller),
        );
      },
    );
  }

  ///
  ///item list
  ///
  Widget _itemList({required V1NewsController controller}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext ctx, int index) {
              return ItemListWidget(
                urlImage: Images.example,
                onTap: () => controller.onNewsDetailClick(),
                title: "Thợ ốp lát: Công trình khách hàng 5 sao",
                subTitle: "Thợ ốp lát: Công trình khách hàng 5 sao",
                rowText2: "7:00 20/09/2021",
                colorRowText2: ColorResources.GREY,
              );
            },
          ),
        ],
      ),
    );
  }
}
