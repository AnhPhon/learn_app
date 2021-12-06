import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group3/winning_bid/winning_bid_controller.dart';

class V2WinningBidPage extends GetView<V2WinningBidController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2WinningBidController>(
      init: V2WinningBidController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_LARGE,
              ),
              //image
              _image(),

              //note
              _note(context),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              _btnBottomSheet(controller),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_LARGE,
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  ///image
  ///
  Widget _image() {
    return Image.asset(Images.payment_success);
  }

  ///
  ///note
  ///
  Widget _note(BuildContext context) {
    return DefaultTextStyle(
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: ColorResources.BLACK,
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Column(
          children: const [
            SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
            ),
            Text(
              "Bạn đã trúng thầu công việc!\nHãy liên hệ với chúng tôi sớm nhất có thể để nhận việc.\nCám ơn Bạn đã tin tưởng sử dụng dịch vụ chúng tôi!",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///btn bottomsheet
  ///
  Widget _btnBottomSheet(V2WinningBidController controller) {
    return BtnCustom(
      onTap: () => controller.onPaymentClick(),
      color: ColorResources.PRIMARY,
      text: "Tiến hành cọc tiền và nhận việc",
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }
}
