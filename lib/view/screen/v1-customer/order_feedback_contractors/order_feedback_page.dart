import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/order_feedback_contractors/order_feedback_controller.dart';

class V1OrderFeedBackPage extends GetView<V1OrderFeedBackController> {
  const V1OrderFeedBackPage({Key? key}) : super(key: key);

  Widget header(){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: ColorResources.BLACK,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.FONT_SIZE_LARGE
              ),
              text: "Tiêu đề: ",
              children: [
                TextSpan(
                  text: "Đập phá cải tạo sửa nhà cấp 4",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: Dimensions.PADDING_SIZE_DEFAULT
                  )
                )
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_LARGE
                ),
                text: "Thông tin báo giá: ",
                children: [
                  TextSpan(
                    text: "Khách hàng cung cấp thông tin",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    )
                  )
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

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
  /// Thuộc tính 
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

  Widget button(BuildContext context, {required String title, required Color color}){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: MaterialButton(
        onPressed: (){},
        minWidth: DeviceUtils.getScaledSize(context,0.4),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text(title,style: const TextStyle(color: ColorResources.WHITE),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (V1OrderFeedBackController controller) {
        return Scaffold(
          backgroundColor: const Color(0xffF6F6F7),
          appBar: AppBarWidget(title: "Phản hồi đơn hàng"),
          body: Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: DeviceUtils.getScaledHeight(context, 1)
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    child: Text("Công việc DVTX khảo sát báo giá", textAlign: TextAlign.center, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.FONT_SIZE_OVER_LARGE
                    ),)
                  ),
                    
                  // Tiêu đề báo giá
                  header(),
                  image(context),
                  Expanded(
                    child: materialList()
                  ),
                  const SizedBox(height:150)
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 150,
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_DEFAULT,
              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            width: DeviceUtils.getScaledWidth(context, 1),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), 
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 0.1,
                  color: ColorResources.BLACK.withOpacity(0.5)
                ),
              ]
            ),
            child: Column(
              children: [
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold,
                    color: ColorResources.BLACK
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Giá trị đơn hàng:"),
                      Text("10.000.000 VNĐ", style: TextStyle(
                        color: ColorResources.RED
                      ),)
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTextStyle(
                    style: const TextStyle(color: ColorResources.WHITE),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        button(context, title: "Huỷ ", color: ColorResources.GREY,),
                        button(context,title: "Đồng ý đơn giá",color: ColorResources.PRIMARYCOLOR)
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        );
      },
    );
  }
}