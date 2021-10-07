import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/card/bao_gia_card.dart';
import 'package:template/view/screen/v3-agent/quote/list/quote_list_controller.dart';

class V3QuoteListPage extends GetView<V3QuoteListController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWidget(title: "Danh sách báo giá đơn hàng"),
      body: GetBuilder<V3QuoteListController>(
        init: V3QuoteListController(),
        builder: (V3QuoteListController controller) {
          return SizedBox(
            height: double.infinity,
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (
                BuildContext ctx,
                index,
              ) {
                return BaoGiaCard(
                  donHangName: "Cần báo giá vật liệu cát, xi, đá, gạch xây",
                  donHangId: "ĐH123456",
                  time: "12:00pm",
                  date: "20/09/2021 ",
                  label: "Thợ ốp lát",
                  content: "Công trình khách 5 sao",
                  locationName: "Đà Nẵng",
                  image: Images.location_example,
                  onTap: () {
                    Get.toNamed(AppRoutes.V3_QUOTE_REQUEST);
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
