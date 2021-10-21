
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g1-build/v1_build_order_feedback_controller.dart';

class V1BuildOrderFeedBackPage extends GetView<V1BuildOrderFeedBackController> {
  V1BuildOrderFeedBackPage({Key? key}) : super(key: key);

  @override
  final V1BuildOrderFeedBackController controller = Get.find<V1BuildOrderFeedBackController>();

  

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (V1BuildOrderFeedBackController controller) {
        return Scaffold(
          backgroundColor: ColorResources.BACKGROUND,
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
                  header(controller:controller),
                  // list Hình ảnh
                  image(context,controller:controller),
                  // List vật liệu
                  materialList(context,controller:controller),
                  // Khoản cách bottom sheet
                  const SizedBox(height:BOTTOMSHEET),
                ],
              ),
            ),
          ),
          bottomSheet: OrderBottomSheet(
            itemValue: double.parse(controller.dichVuResponse!.tongDon!),
            children: [
              SmallButton(title: "Huỷ ", color: ColorResources.GREY,onPressed: (){}),
              SmallButton(title: "Đồng ý đơn giá",color: ColorResources.PRIMARYCOLOR, onPressed: (){
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
  Widget header({required V1BuildOrderFeedBackController controller}){
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHighlight(
            title: "Tiêu đề:",
            content: controller.dichVuResponse!.tieuDe!,
          ),
        ],
      ),
    );
  }

  ///
  /// List hình ảnh
  ///
  Widget image(BuildContext context,{required V1BuildOrderFeedBackController controller}){
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: controller.dichVuResponse!.hinhAnhBanKhoiLuong!.isEmpty ? const SizedBox() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text("Đơn giá bằng hình ảnh",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
          ),),
<<<<<<< HEAD
          //BoxImage(imagesUrl: controller.dichVuResponse!.hinhAnhBanKhoiLuong!.split(',')),
=======
          BoxImage(imagesUrl: controller.dichVuResponse!.hinhAnhBaoGia!.split(',')),
>>>>>>> cd06cc9 (update)
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

  Widget materialList(BuildContext context,{required V1BuildOrderFeedBackController controller}){
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