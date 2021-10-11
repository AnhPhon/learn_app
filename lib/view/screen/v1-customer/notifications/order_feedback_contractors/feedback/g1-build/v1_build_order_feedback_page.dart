
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g1-build/v1_build_order_feedback_controller.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';

class V1BuildOrderFeedBackPage extends GetView<V1BuildOrderFeedBackController> {
  V1BuildOrderFeedBackPage({Key? key}) : super(key: key);

  @override
  final V1BuildOrderFeedBackController controller = Get.find<V1BuildOrderFeedBackController>();

  

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (V1BuildOrderFeedBackController controller) {
        return Scaffold(
          backgroundColor: const Color(0xffF6F6F7),
          appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
          body: SizedBox(
            //padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề của nhóm
                  const GroupTitle(title: "Dịch vụ xây dựng toàn diện"),
                    
                  // Tiêu đề báo giá
                  header(),
                  // list Hình ảnh
                  image(context),
                  // List vật liệu
                  materialList(context),
                  // Khoản cách bottom sheet
                  const SizedBox(height:150),
                ],
              ),
            ),
          ),
          bottomSheet: OrderBottomSheet(
            itemValue: 100000000,
            children: [
              SmallButton(title: "Huỷ ", color: ColorResources.GREY,onPressed: (){}),
              SmallButton(title: "Đồng ý đơn giá",color: ColorResources.PRIMARYCOLOR, onPressed: (){
                print("aaa");
                controller.onClickAgreeButton();
              }),
            ],
          ),
        );
      },
    );
  }

  ///
  /// Nội dung tiêu đề
  ///
  Widget header(){
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TextHighlight(
            title: "Tiêu đề:",
            content: "Thợ ốp lót công trình 5 sao",
          ),
        ],
      ),
    );
  }

  ///
  /// List hình ảnh
  ///
  Widget image(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Đơn giá bằng hình ảnh",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
          ),),
          BoxImage(images: []),
        ],
      ),
    );
  }

  ///
  /// nội dung đơn hàng 
  ///
  Widget content({required String title, required String value}){
    return Row(
      children: [
        Text(title, style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        Text(" $value"),
      ],
    );
  }

  ///
  /// Danh sách vật liệu
  ///

  Widget materialList(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Đơn giá phản hồi theo khách hàng cung cấp",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
          ),),
          Column(
            children: [
              ...List.generate(10, (index) => Padding(
                padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                child: BoxShadowWidget(
                  child: SizedBox(
                    height: 160,
                    width: DeviceUtils.getScaledWidth(context, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: Dimensions.PADDING_SIZE_DEFAULT
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            TextHighlight(title:"Tên công việc:" ,content:"Lót nền vệ sinh", fontSize: Dimensions.FONT_SIZE_LARGE, ),
                            TextHighlight(title:"Quy cách:" ,content:"600 x 600",fontSize: Dimensions.FONT_SIZE_LARGE ),
                            TextHighlight(title:"Khối lượng:" ,content:"20",fontSize: Dimensions.FONT_SIZE_LARGE ),
                            TextHighlight(title:"Đơn vị:" ,content:"m2" ,fontSize: Dimensions.FONT_SIZE_LARGE),
                            TextHighlight(title:"Đơn giá:" ,content:"500.000 VNĐ" , style: TextStyle(
                              color: ColorResources.RED,
                              fontSize: Dimensions.FONT_SIZE_LARGE
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}