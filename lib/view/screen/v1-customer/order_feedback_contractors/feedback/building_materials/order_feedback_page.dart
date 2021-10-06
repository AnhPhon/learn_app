import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/feedback/building_materials/order_feedback_controller.dart';

class V1OrderFeedBackPage extends GetView<V1OrderFeedBackController> {
  V1OrderFeedBackPage({Key? key}) : super(key: key);

  @override
  final V1OrderFeedBackController controller = Get.find<V1OrderFeedBackController>();

  

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (V1OrderFeedBackController controller) {
        return Scaffold(
          backgroundColor: const Color(0xffF6F6F7),
          appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
          body: Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: DeviceUtils.getScaledHeight(context, 1)
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề của nhóm
                  const GroupTitle(title: "Công việc DVTX khảo sát báo giá"),
                    
                  // Tiêu đề báo giá
                  header(),
                  // list Hình ảnh
                  image(context),
                  // List vật liệu
                  Expanded(
                    child: materialList()
                  ),
                  // Khoản cách bottom sheet
                  const SizedBox(height:150),
                ],
              ),
            ),
          ),
          bottomSheet: OrderBottomSheet(
            itemValue: "100.000.000",
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
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TextHighligt(
            title: "Tiêu đề:",
            content: "Đập phá cải tạo sửa nhà cấp 4",
          ),
          // RichText(
          //   text: const TextSpan(
          //     style: TextStyle(
          //       color: ColorResources.BLACK,
          //       fontWeight: FontWeight.bold,
          //       fontSize: Dimensions.FONT_SIZE_LARGE
          //     ),
          //     text: "Tiêu đề: ",
          //     children: [
          //       TextSpan(
          //         text: "Đập phá cải tạo sửa nhà cấp 4",
          //         style: TextStyle(
          //           fontWeight: FontWeight.normal,
          //           fontSize: Dimensions.PADDING_SIZE_DEFAULT
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: TextHighligt(
              title: "Thông tin báo giá: ",
              content: "Khách hàng cung cấp thông tin",
            ), 
            // RichText(
            //   text: const TextSpan(
            //     style: TextStyle(
            //       color: ColorResources.BLACK,
            //       fontWeight: FontWeight.bold,
            //       fontSize: Dimensions.FONT_SIZE_LARGE
            //     ),
            //     text: "Thông tin báo giá: ",
            //     children: [
            //       TextSpan(
            //         text: "Khách hàng cung cấp thông tin",
            //         style: TextStyle(
            //           fontWeight: FontWeight.normal,
            //         )
            //       )
            //     ]
            //   ),
            // ),
          )
        ],
      ),
    );
  }

  ///
  /// List hình ảnh
  ///
  Widget image(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Đơn giá bằng hình ảnh",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE
          ),),
          Container(
            margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            width: DeviceUtils.getScaledWidth(context,1),
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: ColorResources.PRIMARYCOLOR)
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorResources.GREY,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        Images.admin_background, fit: BoxFit.cover,
                      )
                    ),
                  ),
                );
              },
            ),
          ),
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

  Widget materialList(){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Đơn giá phản hồi theo khách hàng cung cấp",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE
          ),),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorResources.WHITE,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,0),
                        blurRadius: 10,
                        color: ColorResources.BLACK.withOpacity(0.4)
                      ),
                    ]
                  ),
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
                        children: [
                          content(title:"Tên công việc:" ,value:"Lót nền vệ sinh" ),
                          content(title:"Đơn vị:" ,value:"m2" ),
                          content(title:"Đơn giá:" ,value:"500.000 VNĐ" ),
                          content(title:"Quy cách:" ,value:"600 x 600" ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}