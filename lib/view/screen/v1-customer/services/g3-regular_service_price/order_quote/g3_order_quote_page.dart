

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/bang_gia_don_hang_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_quote/g3_order_quote_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V1G3OrderQuotePage extends GetView<V1G3OrderQuoteController> {
  V1G3OrderQuotePage({Key? key}) : super(key: key);
  final V1G3OrderQuoteController _controller = Get.find<V1G3OrderQuoteController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo giá đơn hàng"),
      body: Column(
        children: [
          // Tiêu tề nhóm công việc
          const GroupTitle(title: "Dịch vụ thường xuyên đã có giá"),
          // Bảng giá từng loại
          servicesList(context),
          const SizedBox(
            height: Dimensions.SIZE_SUPER_LARGE,
          )
        ],
      ),
      bottomSheet: BottomAppBar(
        child: GestureDetector(
          onTap: ()=> controller.onNextPage(),
          child: Container(
            width: DeviceUtils.getScaledWidth(context,1),
            height: Dimensions.SIZE_SUPER_LARGE,
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


  Widget servicesList(BuildContext context){
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT
        ),
        child: GetBuilder(
          builder: (V1G3OrderQuoteController controller) {
            if(controller.isLoading){
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              controller: controller.scrollController,
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL,
              ),
              itemCount: controller.priceTable.length > (DeviceUtils.getScaledHeight(context, 1)/80) ? controller.priceTable.length + 1 : controller.priceTable.length,
              itemBuilder: (context, index) {
                if(index == controller.priceTable.length + 1){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      _controller.onSelectedItem(item: controller.priceTable[index]);
                    },
                    child: item(item: controller.priceTable[index], controller: controller)
                  ),
                );
              },
            );
          },
        )
      ),
    );
  }

  Widget item({required BangGiaDonHangResponse item, required V1G3OrderQuoteController controller}){
    return Material(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)
      ),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        decoration: BoxDecoration(
          color: controller.currentSelected!.id == item.id ? ColorResources.PRIMARYCOLOR.withOpacity(0.5) :  ColorResources.WHITE,
          borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        ),
        height: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(item.tieuDe!, style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              fontWeight: FontWeight.bold
            ),),
            RichText(
              text: TextSpan(
                text: item.giaTien,
                style: const TextStyle(
                  color: ColorResources.RED,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: "/ ${item.donViTinh}"
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

}