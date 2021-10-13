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
          return SizedBox(
            height: double.infinity,
            child: ListView.builder(
              itemCount: controller.danhSachBaoGiaDonDichVuResponse.length,
              shrinkWrap: true,
              itemBuilder: (
                BuildContext ctx,
                index,
              ) {
                final DonDichVuResponse _donDichVuResponse = controller.danhSachBaoGiaDonDichVuResponse[index].idDonDichVu!;
                return BaoGiaCard(
                  donHangName: _donDichVuResponse.tieuDe.toString(),
                  donHangId: "ĐH123456",
                  time: _donDichVuResponse.ngayBatDau.toString().split("T")[0],
                  date: _donDichVuResponse.ngayBatDau.toString().split("T")[0],
                  label: "Thợ ốp lát".toString(),
                  content: "Công trình khách 5 sao".toString(),
                  locationName: _donDichVuResponse.diaDiemBocHang.toString(),
                  image: Images.location_example,
                  onTap: controller.toReponse,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
