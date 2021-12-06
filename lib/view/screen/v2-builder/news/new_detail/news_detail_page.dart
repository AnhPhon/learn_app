import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v2-builder/news/new_detail/news_detail_controller.dart';

class V2NewsDetailPage extends GetView<V2NewsDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2NewsDetailController>(
        init: V2NewsDetailController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWidget(
              title: controller.title,
              leading: IconButton(
                onPressed: () {
                  Get.back(result: true);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorResources.WHITE,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //image
                  _imageNews(context),

                  //title news
                  _titleNews(controller: controller),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //view and like
                        _author(context, controller: controller),

                        const SizedBox(
                          width: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),

                        //authors and time
                        _views(controller: controller),
                      ],
                    ),
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
      image: controller.tinTucResponse.hinhAnh.toString(),
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
  Widget _titleNews({required V2NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        top: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        controller.tinTucResponse.tieuDe.toString(),
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///author
  ///
  Widget _author(BuildContext context,
      {required V2NewsDetailController controller}) {
    return Flexible(
      child: Text(
        controller.tinTucResponse.tacGia.toString(),
        maxLines: 2,
        textAlign: TextAlign.left,
        style: Dimensions.fontSizeStyle16w600()
            .copyWith(color: ColorResources.BLACK),
      ),
    );
  }

  ///
  ///view and time
  ///
  Widget _views({required V2NewsDetailController controller}) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(
            DateConverter.formatDateTime(
              controller.tinTucResponse.createdAt.toString(),
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
                width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
              ),
              Text(
                controller.tinTucRequest.luotXem.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content({required V2NewsDetailController controller}) {
    return Specification(
      specification: controller.tinTucResponse.noiDung.toString(),
    );
  }
}
