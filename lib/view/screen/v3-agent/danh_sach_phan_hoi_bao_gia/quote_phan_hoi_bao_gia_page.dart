import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/quote_phan_hoi_bao_gia_controller.dart';

class V3QuotePhanHoiBaoGiaPage extends GetView<V3QuotePhanHoiBaoGiaController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(title: controller.title),
        body: GetBuilder(
          init: V3QuotePhanHoiBaoGiaController(),
          builder: (V3QuotePhanHoiBaoGiaController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: DeviceUtils.getScaledWidth(context, .9),
                        height: DeviceUtils.getScaledHeight(context, .07),
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                          ),
                        ),
                        child: TabBar(
                          labelPadding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),
                          labelStyle: Dimensions.fontSizeStyle16w600(),
                          indicator: BoxDecoration(
                            color: ColorResources.APPBARCOLOR,
                            borderRadius: BorderRadius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 2),
                                blurRadius: 2,
                                color: ColorResources.BLACK.withAlpha(90),
                              )
                            ],
                          ),
                          unselectedLabelColor: ColorResources.UNSELECT_TABBAR,
                          tabs: const [
                            //tab ĐÃ PHẢN HỒI
                            Text('Đã phản hồi'),

                            //tab CHƯA PHẢN HỒI
                            Text('Chưa phản hồi'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Tab View
                Container(
                  height: DeviceUtils.getScaledHeight(context, .8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  //Tabbar View Tiến độ công việc
                  child: TabBarView(children: [
                    //listview VIỆC ĐANG LÀM
                    _listViewDaPhanHoi(context),

                    //Listview CHƯA PHẢN HỒI
                    _listViewChuaPhanHoi(context),
                  ]),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ///
  ///ListView đã phản hồi
  ///
  Widget _listViewDaPhanHoi(BuildContext context) {
    final int daLength = controller.daPhanHoiDDV.length;
    return SmartRefresher(
      controller: controller.refreshDaPhanHoiController!,
      onLoading: controller.onDaDonPhanHoiLoading,
      onRefresh: controller.onDaDonPhanHoiRefresh,
      enablePullUp: controller.daPhanHoiDDV.isNotEmpty,
      footer: const ClassicFooter(
        loadingText: "Đang tải...",
        noDataText: "Không có dữ liệu",
        canLoadingText: "Kéo lên để tải thêm dữ liệu",
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
            Column(
              children: List.generate(daLength, (index) {
                String statusBtn = "";
                if (controller.daPhanHoiDDV[index].idTrangThaiDonDichVu !=
                    null) {
                  statusBtn = controller
                      .daPhanHoiDDV[index].idTrangThaiDonDichVu!.tieuDe
                      .toString();
                }
                String status = controller.statusList[
                    controller.datCheckList.contains(statusBtn.toLowerCase())
                        ? 0
                        : 1];

                String labelBtn = "Đề nghị thanh toán phí";
                int statusLabel = 0;
                status = "Đạt";

                String hinhAnh = Images.location_example;
                if (controller.daPhanHoiDDV[index].idNhomDichVu != null &&
                    controller
                            .daPhanHoiDDV[index].idNhomDichVu!.hinhAnhDaiDien !=
                        null) {
                  hinhAnh = controller
                      .daPhanHoiDDV[index].idNhomDichVu!.hinhAnhDaiDien
                      .toString();
                }

                if (controller.daPhanHoiDDV[index].idTrangThaiDonDichVu !=
                    null) {
                  if (controller.daPhanHoiDDV[index].idTrangThaiDonDichVu
                          .toString()
                          .toLowerCase() ==
                      'trúng thầu') {
                    statusLabel = 1;
                    labelBtn = "Liên hệ khách hàng";
                  }

                  if ([THAT_BAI].contains(controller
                          .daPhanHoiDDV[index].idTrangThaiDonDichVu!.id) &&
                      controller.daPhanHoiDDV[index].idTaiKhoanNhanDon!.id !=
                          controller.idTaiKhoan) {
                    statusLabel = 2;
                    labelBtn = "Xóa đơn hàng";
                    status = "Không đạt";
                  }

                  if ([DA_BAO_GIA].contains(controller
                      .daPhanHoiDDV[index].idTrangThaiDonDichVu!.id)) {
                    statusLabel = 3;
                    labelBtn = "Xóa đơn hàng";
                    status = "Không đạt";
                  }
                }

                return GestureDetector(
                  onTap: () {
                    // đề nghị thành toán phí
                    if (statusLabel == 0) {
                      controller.onProductResponseClick(
                        controller.daPhanHoiDDV[index],
                      );
                    }

                    // liện hệ với cách hàng
                    if (statusLabel == 1) {
                      controller.onProductResponseClick(
                        controller.daPhanHoiDDV[index],
                      );
                    }

                    // trường hợp xóa đơn
                    if (statusLabel == 2) {
                      controller
                          .onXoaDonHangClick(controller.daPhanHoiDDV[index]);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    width: DeviceUtils.getScaledWidth(context, 1),
                    height: DeviceUtils.getScaledWidth(context, .285),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: ColorResources.BLACK.withAlpha(60),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        SizedBox(
                          width: DeviceUtils.getScaledWidth(context, 0.65),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.PADDING_SIZE_LARGE,
                              horizontal: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      //Tiêu đề công việc
                                      TextSpan(
                                        text: controller
                                            .daPhanHoiDDV[index].tieuDe
                                            .toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: Dimensions.PADDING_SIZE_DEFAULT,
                                ),
                                Row(
                                  children: [
                                    if (statusLabel != 3)
                                      GestureDetector(
                                        onTap: () {
                                          // đề nghị thành toán phí
                                          if (statusLabel == 0) {
                                            controller.onProductResponseClick(
                                              controller.daPhanHoiDDV[index],
                                            );
                                          }

                                          // liện hệ với cách hàng
                                          if (statusLabel == 1) {
                                            controller.onThongTinKhachHangClick(
                                                controller.daPhanHoiDDV[index]);
                                          }

                                          // trường hợp xóa đơn
                                          if (statusLabel == 2) {
                                            controller.onXoaDonHangClick(
                                                controller.daPhanHoiDDV[index]);
                                          }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                Dimensions.PADDING_SIZE_SMALL,
                                              ),
                                            ),
                                            color: (statusLabel == 2 ||
                                                    statusLabel == 3)
                                                ? ColorResources.RED
                                                : ColorResources.THEME_DEFAULT,
                                          ),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: DeviceUtils.getScaledWidth(
                                              context,
                                              .35,
                                            ),
                                            child: Text(
                                              labelBtn,
                                              style: const TextStyle(
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL,
                                                color: ColorResources.WHITE,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      width: DeviceUtils.getScaledWidth(
                                          context, .2),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          color: (statusLabel == 2 ||
                                                  statusLabel == 3)
                                              ? ColorResources.RED
                                              : ColorResources.GREEN,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        //Icon
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: DeviceUtils.getScaledWidth(context, 0.25),
                            height: DeviceUtils.getScaledHeight(context, .138),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  Dimensions.BORDER_RADIUS_SMALL,
                                ),
                                bottomLeft: Radius.circular(
                                  Dimensions.BORDER_RADIUS_SMALL,
                                ),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(hinhAnh),
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                  ColorResources.GREY,
                                  BlendMode.multiply,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///ListView chưa phản hồi
  ///
  Widget _listViewChuaPhanHoi(BuildContext context) {
    final int chuaLength = controller.chuaPhanHoiDDV.length;
    return SmartRefresher(
      controller: controller.refreshChuaPhanHoiController!,
      onLoading: controller.onChuaDonPhanHoiLoading,
      onRefresh: controller.onChuaDonPhanHoiRefresh,
      enablePullUp: controller.chuaPhanHoiDDV.isNotEmpty,
      footer: const ClassicFooter(
        loadingText: "Đang tải...",
        noDataText: "Không có dữ liệu",
        canLoadingText: "Kéo lên để tải thêm dữ liệu",
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
            Column(
              children: List.generate(chuaLength, (index) {
                String hinhAnh = Images.location_example;
                if (controller.chuaPhanHoiDDV[index].idNhomDichVu != null &&
                    controller.chuaPhanHoiDDV[index].idNhomDichVu!
                            .hinhAnhDaiDien !=
                        null) {
                  hinhAnh = controller
                      .chuaPhanHoiDDV[index].idNhomDichVu!.hinhAnhDaiDien!;
                }

                return ItemListWidget(
                  title: controller.chuaPhanHoiDDV[index].tieuDe.toString(),
                  onTap: () => controller.onProductNoResponseClick(
                      controller.chuaPhanHoiDDV[index]),
                  urlImage: hinhAnh,
                  rowText2: "Chưa phản hồi",
                  colorRowText2: ColorResources.LIGHT_SKY_BLUE_HEIGHT,
                  isSpaceBetween: true,
                  scaleHeight: .138,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
