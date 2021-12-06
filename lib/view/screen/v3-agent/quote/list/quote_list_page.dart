import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/card/bao_gia_card.dart';
import 'package:template/view/screen/v3-agent/quote/list/quote_list_controller.dart';

class V3QuoteListPage extends GetView<V3QuoteListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: SmartRefresher(
        controller: controller.donDichVuOnRefresh,
        onRefresh: controller.onDonDichVuRefresh,
        onLoading: controller.onDonDichVuLoading,
        enablePullUp: controller.donDichVus.isNotEmpty,
        footer: const ClassicFooter(
          loadingText: "Đang tải...",
          noDataText: "Không có dữ liệu",
          canLoadingText: "Kéo lên để tải thêm dữ liệu",
        ),
        child: GetBuilder<V3QuoteListController>(
          init: V3QuoteListController(),
          builder: (V3QuoteListController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                  Column(
                    children:
                        List.generate(controller.donDichVus.length, (index) {
                      return Column(
                        children: [
                          BaoGiaCard(
                            fontSize: 11,
                            donHangName:
                                controller.donDichVus[index].tieuDe.toString(),
                            donHangId: controller.donDichVus[index].idTinhTp!
                                .toString(),
                            time: "",
                            date: DateConverter.formatDateTimeFull(
                              dateTime: controller.donDichVus[index].createdAt
                                  .toString(),
                            ),
                            label: controller.donDichVus[index].tieuDe!,
                            content:
                                "Thời gian dự kiến: ${DateConverter.formatDateTimeFull(
                              dateTime: controller.donDichVus[index].ngayBatDau!
                                  .toString(),
                            )} - ${DateConverter.formatDateTimeFull(
                              dateTime: controller
                                  .donDichVus[index].ngayKetThuc!
                                  .toString(),
                            )}",
                            locationName: controller
                                .donDichVus[index].diaDiemBocHang
                                .toString(),
                            image: controller.donDichVus[index].idNhomDichVu ==
                                        null ||
                                    controller.donDichVus[index].idNhomDichVu!
                                            .hinhAnhDaiDien ==
                                        null
                                ? Images.location_example
                                : controller.donDichVus[index].idNhomDichVu!
                                    .hinhAnhDaiDien
                                    .toString(),
                            onTap: () {
                              controller.onYeuCauBaoGiaPageClick(
                                  controller.donDichVus[index]);
                            },
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_SMALL,
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
