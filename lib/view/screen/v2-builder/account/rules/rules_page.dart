import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class RulesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      appBar: const AppBarWidget(title: "Điều khoản"),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE + 7),
        child: Column(
          children: [
            Image.asset("assets/images/device.png"),
            const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child: Text(
                "THIẾT BỊ",
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              "Bất kỳ thiết bị, hệ thống hoặc tiện ích nào, do Công ty hoặc các nhà thầu phụ của Công ty cung cấp có thể được sử dụng trực tiếp hoặc gián tiếp trong việc cung cấp Dịch vụ, và không phải là đối tượng của một thỏa thuận riêng giữa các Bên theo đó quyền sở hữu được chuyển sang Khách hàng.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
