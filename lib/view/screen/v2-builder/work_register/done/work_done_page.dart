import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/screen/v2-builder/work_register/done/work_done_controller.dart';

class V2RegisterDonePage extends GetView<V2RegisterDoneController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2RegisterDoneController>(
        init: V2RegisterDoneController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                  //image
                  _image(),

                  //note
                  _note(context)
                ],
              ),
            ),
            bottomNavigationBar: _btnBottomSheet(controller),
          );
        });
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
              "Bạn đã đăng ký việc thành công!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            Text(
                "Chúng tôi sẽ tương tác bạn với khách hàng!\nCảm ơn bạn đã tin tưởng và lựa chọn dịch vụ chúng tôi!\nChúc bạn sớm nhận được công việc như mong muốn!\n"),
            SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            Text("Trân trọng kính chào!"),
          ],
        ),
      ),
    );
  }

  ///
  ///btn bottomsheet
  ///
  Widget _btnBottomSheet(V2RegisterDoneController controller) {
    return BtnCustom(
      onTap: () {},
      color: ColorResources.PRIMARY,
      text: "Xác nhận",
      width: double.infinity,
    );
  }
}
