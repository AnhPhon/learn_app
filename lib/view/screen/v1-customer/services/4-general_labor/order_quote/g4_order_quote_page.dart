

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_quote/g4_order_quote_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V1G4OrderQuotePage extends GetView<V1G4OrderQuoteController> {
  V1G4OrderQuotePage({Key? key}) : super(key: key);
  final V1G4OrderQuoteController _controller = Get.find<V1G4OrderQuoteController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo giá đơn hàng"),
      body: Column(
        children: [
          // Tiêu tề nhóm công việc
          const GroupTitle(title: "Dịch vụ lao động thủ công"),
          // Bảng giá từng loại
          servicesList()
        ],
      ),
      bottomSheet: BottomAppBar(
        child: GestureDetector(
          onTap: ()=> controller.onNextPage(),
          child: Container(
            width: DeviceUtils.getScaledWidth(context,1),
            height: 90,
            color: ColorResources.PRIMARYCOLOR,
            alignment: Alignment.center,
            child: const Text("Tiếp tục", style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              fontWeight: FontWeight.bold,
              color: ColorResources.WHITE
            ))
          ),
        ),
      ),
    );
  }


  Widget servicesList(){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.PADDING_SIZE_SMALL,
          ),
          itemCount: 120,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL,
              ),
              child: GestureDetector(
                onTap: (){
                  _controller.onSelectedItem(1);
                },
                child: item(index: index)
              ),
            );
          },
        ),
      ),
    );
  }

  Widget item({required int index}){
    return GetBuilder(
      builder: (V1G4OrderQuoteController controller) {
        return Material(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)
          ),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: controller.currentSelected == index ? ColorResources.PRIMARYCOLOR.withOpacity(0.3) :  ColorResources.WHITE,
              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            ),
            height: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Công nhật dọn nhà", style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontWeight: FontWeight.bold
                ),),
                RichText(
                  text: const TextSpan(
                    text: "150.000đ",
                    style: TextStyle(
                      color: ColorResources.RED,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold
                    ),
                    children: [
                      TextSpan(
                        text: "/Lần"
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}