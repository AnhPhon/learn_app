import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/g1-build/v1_build_order_feedback_controller.dart';

class V1BuildOrderFeedBackPage extends GetView<V1BuildOrderFeedBackController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND,
      appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
      body: GetBuilder(
        builder: (V1BuildOrderFeedBackController controller) {
          if (controller.isLoading && controller.donPhanHoi == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề của nhóm
                  const GroupTitle(title: "Dịch vụ xây dựng toàn diện"),

                  // Tiêu đề báo giá
                  header(controller: controller),
                  // list Hình ảnh
                  image(context, controller: controller),
                  // File
                  file(context, controller: controller),

                  const Padding(
                   padding: EdgeInsets.only(
                      left:Dimensions.PADDING_SIZE_DEFAULT,
                      right:Dimensions.PADDING_SIZE_DEFAULT,
                      top:Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Text(
                      "Đơn giá phản hồi theo khách hàng cung cấp",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                  ),
                  // List vật liệu
                  materialList(context, controller: controller),
                  // Khoản cách bottom sheet
                  const SizedBox(height: BOTTOMSHEET),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: GetBuilder(
        builder: (V1BuildOrderFeedBackController controller) {
          if(controller.isLoading && controller.donPhanHoi == null){
            return const SizedBox.shrink();
          }
          return OrderBottomSheet(
            itemValue: controller
                .tongTien, 
            children: 
            controller.donDichVu!.idTrangThaiDonDichVu!.id!  == THAT_BAI ? 
            [
              const Flexible(
                child: Text(
                  "Bạn đã không đồng ý giá đơn dịch vụ. Rất vui hợp tác với bạn lần sau !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorResources.RED
                  ),
                )
              )
            ] : 
            controller.donDichVu!.idTrangThaiThanhToan == null ? const [
              Text('Đơn dịch vụ đã bị huỷ hoặc vi phạm quy chế của công ty',
              style: TextStyle(
                  color: ColorResources.RED
              ),)
            ] :
            controller.donDichVu!.idTrangThaiThanhToan!.id! == DA_THANH_TOAN || controller.donDichVu!.idTrangThaiThanhToan!.id == DAT_COT? 
            [
              const Flexible(
              child: Text("Bạn đã thanh toán đơn dịch vụ. Cám ơn bạn đã tin dùng dịch vụ chúng tôi", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorResources.RED
                  ),
                ),
              )
            ] 
            : 
            [
              SmallButton(
                title: "Từ chối", color: ColorResources.GREY, onPressed: (){
                  controller.showDialog();
                }
              ),
              SmallButton(
                title: "Đồng ý đơn giá",
                color: ColorResources.PRIMARYCOLOR,
                onPressed: () {
                  controller.onClickAgreeButton();
                }
              ),
            ],
          );
        },
      )
    );
  }

  ///
  /// Nội dung tiêu đề
  ///
  Widget header({required V1BuildOrderFeedBackController controller}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_DEFAULT,
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHighlight(
            title: "Tiêu đề: ",
            content: controller.donDichVu!.tieuDe!,
          ),
        ],
      ),
    );
  }

  ///
  /// List hình ảnh
  ///
  Widget image(BuildContext context,{required V1BuildOrderFeedBackController controller}){
    return Validate.checkValueIsNullEmpty(controller.donPhanHoi!.hinhAnhBaoGias) ? const SizedBox.shrink() : Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child:  controller.donPhanHoi!.hinhAnhBaoGias!.isEmpty ? const SizedBox() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text("Đơn giá bằng hình ảnh",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE
          ),),
          BoxImage(images: controller.donPhanHoi!.hinhAnhBaoGias!.cast<String>()),
        ],
      ),
    );
  }
  ///
  /// file
  ///
  Widget file(BuildContext context,{required V1BuildOrderFeedBackController controller}){
    return Validate.checkValueIsNullEmpty(controller.donPhanHoi!.file) ? const SizedBox.shrink() :  Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const Text("File báo giá",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE
          ),),
          SizedBox(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
              ),
              onPressed: ()async{
                CommonHelper.openLink(
                  url: controller.donPhanHoi!.file!
                );
              },child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("File báo giá", style: TextStyle(
                    color: ColorResources.BLACK,
                  ),),
                  IconButton(onPressed: (){
                    CommonHelper.openLink(
                      url: controller.donPhanHoi!.file!
                    );
                  }, icon: const Icon(Icons.download, color: ColorResources.BLACK,))
                ],
              )
            )
          )
        ],
      ),
    );
  }

  ///
  /// nội dung đơn hàng
  ///
  Widget content({required String title, required String value}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(" $value"),
      ],
    );
  }

  ///
  /// Danh sách vật liệu
  ///

  Widget materialList(BuildContext context,{required V1BuildOrderFeedBackController controller}){
    return Validate.checkValueIsNullEmpty(controller.donPhanHoi) ?  const SizedBox.shrink() : controller.donPhanHoi!.giaCongViecs!.isEmpty  ? const SizedBox.shrink() : Padding(
      padding: const EdgeInsets.only(
        left:Dimensions.PADDING_SIZE_DEFAULT,
        right:Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ...List.generate(
                  controller.donPhanHoi!.giaCongViecs!.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            bottom: Dimensions.PADDING_SIZE_SMALL),
                        child: BoxShadowWidget(
                          child: SizedBox(
                            // height: 160,
                            width: DeviceUtils.getScaledWidth(context, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_SMALL),
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                    color: ColorResources.BLACK,
                                    fontSize: Dimensions.PADDING_SIZE_DEFAULT),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: TextHighlight(
                                        title: "Tên công việc: ",
                                        content:controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec == null ? '':
                                            controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec!.tenCongViec ?? '',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: TextHighlight(
                                          title: "Quy cách: ",
                                          content:controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec == null ? '':
                                              controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec!.quyCach ?? ''),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: TextHighlight(
                                          title: "Khối lượng: ",
                                          content:controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec == null ? '':
                                              controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec!.soLuong ?? ''),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: TextHighlight(
                                          title: "Đơn vị: ",
                                          content:controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec == null ? '':
                                             controller.donPhanHoi!.giaCongViecs![index].idChiTietCongViec!.donVi ?? ''),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: TextHighlight(
                                        title:"Đơn giá: " ,
                                        content: controller.donPhanHoi == null ? '':
                                        '${CurrencyConverter.currencyConverterVND(double.parse(controller.donPhanHoi!.giaCongViecs![index].donGia!))}VNĐ' , 
                                        style: const TextStyle(
                                        color: ColorResources.RED,
                                        fontSize: Dimensions.FONT_SIZE_LARGE
                                      ),),
                                    ),
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
