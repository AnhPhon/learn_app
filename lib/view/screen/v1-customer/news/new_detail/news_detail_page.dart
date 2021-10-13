import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/news/new_detail/news_detail_controller.dart';

class V1NewsDetailPage extends GetView<V1NewsDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1NewsDetailController>(
        init: V1NewsDetailController(),
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

                  //view and like
                  _totalsView(context, controller: controller),

                  //title news
                  _titleNews(controller: controller),

                  //authors and time
                  _authors(controller: controller),

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
  ///view and like
  ///
  Widget _totalsView(BuildContext context,
      {required V1NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        children: [
          const Spacer(),
          //view
          const Icon(
            Icons.remove_red_eye_sharp,
            color: ColorResources.PRIMARYCOLOR,
          ),
          Text(controller.tinTucModel.luotXem.toString()),

          const SizedBox(
            width: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //reacion
          const Icon(
            Icons.favorite_border_outlined,
            color: ColorResources.RED,
          ),
          const Text("600"),
        ],
      ),
    );
  }

  ///
  ///title news
  ///
  Widget _titleNews({required V1NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        controller.tinTucModel.tieuDe.toString(),
        textAlign: TextAlign.center,
        style: Dimensions.fontSizeStyle20w600(),
      ),
    );
  }

  ///
  ///authors and time
  ///
  Widget _authors({required V1NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Text(
              controller.formatDateTime(
                dateTime: controller.tinTucModel.createdAt.toString(),
              ),
              style: Dimensions.fontSizeStyle16w600()
                  .copyWith(color: ColorResources.PRIMARY),
            ),
            const VerticalDivider(
              thickness: 2,
            ),
            Text(controller.tinTucModel.tacGia.toString(),
                style: Dimensions.fontSizeStyle16w600()
                    .copyWith(color: ColorResources.BLACK)),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content({required V1NewsDetailController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Text(
        controller.tinTucModel.noiDung.toString(),
        textAlign: TextAlign.justify,
        style:
            Dimensions.fontSizeStyle18().copyWith(color: ColorResources.BLACK),
      ),
    );
  }
}
