import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:template/helper/currency_covert.dart';
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
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/building_materials/order_feedback_controller.dart';

class V1OrderFeedBackPage extends GetView<V1OrderFeedBackController> {
  V1OrderFeedBackPage({Key? key}) : super(key: key);

  @override
  final V1OrderFeedBackController _controller =
      Get.find<V1OrderFeedBackController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F7),
      appBar: const AppBarWidget(title: "Phản hồi đơn hàng"),
      body: GetBuilder(
        builder: (V1OrderFeedBackController controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            //padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề của nhóm
                  const GroupTitle(title: "Công việc DVTX khảo sát báo giá"),

                  // Tiêu đề báo giá
                  header(controller: controller),
                  // list Hình ảnh
                  image(context, controller: controller),
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
      bottomSheet: OrderBottomSheet(
        itemValue: _controller
            .tongTien, 
        children: 
        controller.donDichVu!.idTrangThaiDonDichVu!.id!  == THAT_BAI ? 
        [
          const Flexible(
            child: Text(
              "Bạn đã không đồng ý giá đơn dich vụ. Rất vui hợp tác với bạn lần sau !",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorResources.RED
              ),
            )
          )
        ] :
        _controller.donDichVu!.idTrangThaiThanhToan!.id == DA_THANH_TOAN ? 
        [
          const Flexible(
          child: Text("Bạn đã thanh toán đơn dich vụ. Cám ơn bạn đa tin dùng dịch vụ chúng tôi", 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorResources.RED
              ),
            ),
          )
        ] :
        [
          SmallButton(
            title: "Huỷ ", color: ColorResources.GREY, onPressed: () {
              _controller.onFeebacked();
            }
          ),
          SmallButton(
            title: "Đồng ý đơn giá",
            color: ColorResources.PRIMARYCOLOR,
            onPressed: () {
              _controller.onClickAgreeButton();
            }
          ),
        ],
      ),
    );
  }

  ///
  /// Nội dung tiêu đề
  ///
  Widget header({required V1OrderFeedBackController controller}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_SMALL,
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextHighlight(
            title: "Tiêu đề: ",
            content: controller.donDichVu!.tieuDe!,
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: TextHighlight(
              title: "Thông tin báo giá: ",
              content: controller.donDichVu!.moTa!,
            ),
          )
        ],
      ),
    );
  }

  ///
  /// List hình ảnh
  ///
  Widget image(BuildContext context, {required V1OrderFeedBackController controller}){
    return controller.donDichVu!.hinhAnhBanKhoiLuongs!.isEmpty ?  const SizedBox() :
    Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Đơn giá bằng hình ảnh",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.FONT_SIZE_LARGE
          ),),
          BoxImage(images: controller.donDichVu!.hinhAnhBanKhoiLuongs),
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

  Widget materialList(BuildContext context,
      {required V1OrderFeedBackController controller}) {
    return Padding(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: controller.workMass.isEmpty  ? []: [
          const Text(
            "Đơn giá phản hồi theo khách hàng cung cấp",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.FONT_SIZE_LARGE),
          ),
          Column(
            children: [
              ...List.generate(
                  controller.workMass.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_DEFAULT),
                        child: BoxShadowWidget(
                          child: SizedBox(
                            height: 160,
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
                                    TextHighlight(
                                      title: "Tên công việc:",
                                      content:
                                          controller.workMass[index].tenVatTu ?? '',
                                    ),
                                    TextHighlight(
                                        title: "Quy cách:",
                                        content:
                                            controller.workMass[index].quyCach ?? ''),
                                    TextHighlight(
                                        title: "Khối lượng:",
                                        content:
                                            controller.workMass[index].khoiLuong ?? ''),
                                    TextHighlight(
                                        title: "Đơn vị:",
                                        content:
                                            controller.workMass[index].donVi ?? ''),
                                    TextHighlight(title:"Đơn giá:" ,content: '${controller.workMass[index].donGia ?? ''}VNĐ' , style: const TextStyle(
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
