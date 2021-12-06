import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/introduce/introduce_controller.dart';

class V1IntroducePage extends GetView<V1IntroduceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1IntroduceController>(
        init: V1IntroduceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // image
                  _image(context),

                  //introduce
                  _introduce(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //gif
                  _gif(context, controller),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///image
  ///
  Widget _image(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: Images.placeholder,
      image: controller.urlImage,
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .3),
      fit: BoxFit.fill,
      imageErrorBuilder: (c, o, s) => Image.asset(
        Images.placeholder,
        width: double.infinity,
        height: DeviceUtils.getScaledHeight(context, .3),
      ),
    );
  }

  ///
  ///link
  ///
  Widget _link(BuildContext context,
      {required V1IntroduceController controller}) {
    return Column(
      children: [
        //title
        Text(
          "Link giới thiệu bạn bè",
          style: Dimensions.fontSizeStyle18w600(),
        ),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_LARGE,
        ),

        //copy field
        Stack(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              height: DeviceUtils.getScaledHeight(context, .07),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorResources.GREY.withOpacity(.3),
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              ),
              child: Text(
                "http://izisoft.io/",
                style: Dimensions.fontSizeStyle18(),
              ),
            ),

            //copy
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => controller.onBtnCopyClick(),
                  child: Container(
                    alignment: Alignment.center,
                    height: DeviceUtils.getScaledHeight(context, .07),
                    width: DeviceUtils.getScaledWidth(context, .3),
                    decoration: BoxDecoration(
                      color: ColorResources.PRIMARY,
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_DEFAULT),
                    ),
                    child: Text(
                      "Sao chép",
                      style: Dimensions.fontSizeStyle18().copyWith(
                        color: ColorResources.WHITE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  ///
  ///introduce code
  ///
  Widget _introduceCode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //tite
        Text(
          "Mã giới thiệu của bạn",
          style: Dimensions.fontSizeStyle18w600(),
        ),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_LARGE,
        ),

        //introduce code
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
          width: DeviceUtils.getScaledWidth(context, .5),
          height: DeviceUtils.getScaledHeight(context, .06),
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 2)),
            ],
            borderRadius: BorderRadius.circular(
              Dimensions.BORDER_RADIUS_DEFAULT,
            ),
          ),
          child: Text(
            "090909090909",
            style: Dimensions.fontSizeStyle16w600().copyWith(
              color: ColorResources.PRIMARY,
            ),
          ),
        ),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_LARGE,
        ),

        //title
        Text(
          "Chia sẻ",
          style: Dimensions.fontSizeStyle18w600(),
        ),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //share
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Share.share('http://izisoft.io/');
              },
              child: const Icon(
                Icons.share,
                color: ColorResources.PRIMARY,
              ),
            ),
            const SizedBox(
              width: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            GestureDetector(
              onTap: () {
                Share.share('http://izisoft.io/');
              },
              child: const Icon(
                Icons.share,
                color: ColorResources.PRIMARY,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///
  ///introduce
  ///
  Widget _introduce(BuildContext context,
      {required V1IntroduceController controller}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
      ),
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .45),
      color: ColorResources.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //link
          _link(context, controller: controller),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //introduce code
              _introduceCode(context),

              //qr code
              Column(
                children: [
                  Text(
                    "Quét mã QR code",
                    style: Dimensions.fontSizeStyle18(),
                  ),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                  Image.asset(Images.qr_code),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///gif
  ///
  Widget _gif(BuildContext context, V1IntroduceController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
      ),
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .35),
      color: ColorResources.WHITE,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quà cho người giới thiệu".toUpperCase(),
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),
          Text(
            controller.gif,
            textAlign: TextAlign.justify,
            style: Dimensions.fontSizeStyle16().copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
