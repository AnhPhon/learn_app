import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v1-customer/services/reference_price_list/reference_price_table_controller.dart';

class V1ReferencePriceTablePage extends GetView<ReferencePriceTableController>{
  final ReferencePriceTableController _controller = Get.put(ReferencePriceTableController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: _controller.appBarTitle,
        leading: IconButton(onPressed: (){
          _controller.onBack();
        }, icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          )
        ),
      ),
      body: GetBuilder(
        builder: (ReferencePriceTableController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Tiêu tề nhóm công việc
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    child: Align(
                      child: Text(controller.title, textAlign: TextAlign.center, style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.FONT_SIZE_LARGE
                      ),)
                    ),
                  ),
                  
                  const Padding(
                    padding:  EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    child: Align(
                      child: Text('Bảng giá chi tiết tham khảo', textAlign: TextAlign.center, style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: Dimensions.FONT_SIZE_LARGE
                      ),)
                    ),
                  ),

                  imageWidget(context, controller: controller),
                  // File
                  file(controller: controller),
                  // Ghi chú
                  note(),
                  //Button
                  button(controller: controller)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget file({required ReferencePriceTableController controller}){
    return Padding(
      padding: const EdgeInsets.only(
        left:Dimensions.PADDING_SIZE_DEFAULT,
        right:Dimensions.PADDING_SIZE_DEFAULT,
        top:Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text('File giá chi tiết tham khảo', textAlign: TextAlign.left, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE
            ),)
          ),
          DefaultTextStyle(
            style: const TextStyle(
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline,
              color: ColorResources.PRIMARYCOLOR,
              fontSize: Dimensions.FONT_SIZE_LARGE
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: ()async{
                    CommonHelper.openLink(url: controller.chiTietGiaThamKhao!.filePdf!);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text("Bảng giá tham khảo.pdf",),
                  ),
                ),
                GestureDetector(
                  onTap: ()async{
                    CommonHelper.openLink(url: controller.chiTietGiaThamKhao!.fileExcel!);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text("Bảng giá tham khảo.xls"),
                  )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget imageWidget(BuildContext context, {required ReferencePriceTableController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: PinchZoomImage(
        image: controller.chiTietGiaThamKhao == null ?  
        Image.asset(Images.placeholder,fit: BoxFit.cover,width: DeviceUtils.getScaledWidth(context,1),height: DeviceUtils.getScaledHeight(context,0.5))
       : FadeInImage.assetNetwork(
            placeholder: Images.placeholder, 
            image: controller.chiTietGiaThamKhao!.image!,
            fit: BoxFit.cover,
            width: DeviceUtils.getScaledWidth(context,1),
            height: DeviceUtils.getScaledHeight(context,0.5
          ),
          imageErrorBuilder: (context, error, stackTrace) => Image.asset(Images.placeholder),
        )
      ),
    );
    
  }
  
  Widget note(){
    return const Padding(
      padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child:  Align(
        child: Text("Chú ý: Khi xem bảng giá bạn phải nhớ tên dịch vụ bạn muốn yêu cầu báo giá", style: TextStyle(
          color: ColorResources.RED
        ),),
      ),
    );
  }

  Widget button({required ReferencePriceTableController controller}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
      child: LongButton(
        title: "Tiếp tục",
        onPressed: (){
          controller.onClickCotinueButton();
        },
        color: ColorResources.PRIMARYCOLOR,
      ),
    );
  }

}