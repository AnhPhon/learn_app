import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/news/new_detail/news_specification.dart';
import 'package:template/view/screen/v3-agent/news/new_detail/news_detail_controller.dart';

class V3NewsDetailPage extends GetView<V3NewsDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3NewsDetailController>(
        init: V3NewsDetailController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //image
                  _imageNews(context),

                  //title news
                  _titleNews(controller: controller),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //view and like
                      _author(context, controller: controller),

                      //authors and time
                      _views(controller: controller),
                    ],
                  ),

                  //content
                  _content(controller: controller),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///image
  ///
  Widget _imageNews(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: Images.placeholder,
      image: controller.tinTucModel.hinhAnh.toString(),
      height: DeviceUtils.getScaledHeight(context, .35),
      width: double.infinity,
      fit: BoxFit.fill,
      imageErrorBuilder: (c, o, s) => Image.asset(
        Images.placeholder,
        height: DeviceUtils.getScaledHeight(context, .35),
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  ///
  ///title news
  ///
  Widget _titleNews({required V3NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        top: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        controller.tinTucModel.tieuDe.toString(),
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///author
  ///
  Widget _author(BuildContext context,
      {required V3NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        controller.tinTucModel.tacGia.toString(),
        style: Dimensions.fontSizeStyle16w600()
            .copyWith(color: ColorResources.BLACK),
      ),
    );
  }

  ///
  ///view and time
  ///
  Widget _views({required V3NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              controller.formatDateTime(
                dateTime: controller.tinTucModel.createdAt.toString(),
              ),
              style: Dimensions.fontSizeStyle16w600().copyWith(
                color: ColorResources.GREY,
              ),
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            Row(
              children: [
                //view
                const Icon(
                  Icons.remove_red_eye_sharp,
                  color: ColorResources.PRIMARYCOLOR,
                ),
                const SizedBox(
                  width: Dimensions.MARGIN_SIZE_SMALL,
                ),
                Text(
                  controller.tinTucModel.luotXem.toString(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content({required V3NewsDetailController controller}) {
    return NewsSpecification(
      newsSpecification: controller.tinTucModel.noiDung.toString(),
    );
  }
}
