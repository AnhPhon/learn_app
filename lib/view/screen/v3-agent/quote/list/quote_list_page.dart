import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/card/bao_gia_card.dart';
import 'package:template/view/screen/v3-agent/quote/list/quote_list_controller.dart';

class V3QuoteListPage extends GetView<V3QuoteListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3QuoteListController>(
        init: V3QuoteListController(),
        builder: (V3QuoteListController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SizedBox(
            height: double.infinity,
            child: ListView.builder(
              itemCount: controller.donDichVus.length,
              shrinkWrap: true,
              itemBuilder: (
                BuildContext ctx,
                index,
              ) {
                final DonDichVuResponse donDichVuResponse =
                    controller.donDichVus[index];
                return BaoGiaCard(
                  donHangName: donDichVuResponse.tieuDe.toString(),
                  donHangId: "BH${donDichVuResponse.id!.substring(0, 6)}",
                  time:
                      donDichVuResponse.ngayKetThuc.toString().substring(0, 10),
                  date:
                      donDichVuResponse.ngayKetThuc.toString().substring(0, 10),
                  label: donDichVuResponse.tieuDe!,
                  content: donDichVuResponse.moTa!,
                  locationName: donDichVuResponse.diaDiemBocHang.toString(),
                  image: donDichVuResponse.hinhAnhBaoGia == null
                      ? Images.location_example
                      : donDichVuResponse.hinhAnhBaoGia!,
                  onTap: () {
                    controller.onYeuCauBaoGiaPageClick(
                        donDichVuResponse.id.toString());
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

mixin V3_QUOTE_REQUEST {}
