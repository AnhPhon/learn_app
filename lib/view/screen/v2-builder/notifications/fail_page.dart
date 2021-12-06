import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';

class V2FailPage extends StatelessWidget {
  const V2FailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Chúc bạn may mắn lần sau",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: Center(child: Image.asset(Images.fail)),
              ),
            ),
            const Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  'Giá bạn đã chưa tốt  bằng đơn vị khác! '
                  'Lần sau bạn xem xét lại giá tốt hơn để có khả năng nhận việc được cao hơn! '
                  'Chúc bạn may mắn và thành công! ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: LongButton(
                    title: "Hoàn tất",
                    color: ColorResources.PRIMARYCOLOR,
                    onPressed: () {
                      Get.offAndToNamed(AppRoutes.V2_NOTIFICATION);
                      Get.back();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
