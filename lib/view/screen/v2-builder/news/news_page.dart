import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/v2-builder/news/news_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V2NewsPage extends GetView<V2NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V2NewsController>(
        init: V2NewsController(),
        builder: (V2NewsController controller) {
          return Scaffold(
            appBar: const AppBarWidget(title: "Tin tức"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //item list
                  ...List.generate(5, (index) => _itemList(context)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// item list
  ///
  Widget _itemList(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onNewsDetailClick();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_SMALL,
            vertical: Dimensions.MARGIN_SIZE_SMALL),
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.MARGIN_SIZE_SMALL,
        ),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
          color: ColorResources.WHITE,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  child: Image.asset(
                    Images.newsTemplate,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    child: Text(
                      "Thợ ốp lát: Công trình khách hàng 5 sao",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    child: Text(
                      "Thợ ốp lát: Công trình khách hàng 5 sao",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "7:00 20/09/2021",
                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL),
                      ),
                      SizedBox(
                        width: Dimensions.MARGIN_SIZE_SMALL,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

