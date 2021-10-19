

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/reference_price_list/reference_price_table_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class RefenrencePriceTablePage extends GetView<ReferencePriceTableController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tạo đơn công việc",),
      body: GetBuilder(
        init: ReferencePriceTableController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ thường xuyên khảo sát chờ báo giá"),
                  imageWidget(context),
                  const Padding(
                    padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Align(
                      child: Text('File giá chi tiết tham khảo', textAlign: TextAlign.center, style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE
                      ),)
                    ),
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                      decorationStyle: TextDecorationStyle.solid,
                      decoration: TextDecoration.underline,
                      color: ColorResources.PRIMARYCOLOR
                    ),
                    child: Column(
                      children: const [
                        Text("File.pdf",),
                        Text("File.xls")
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Chú ý: Khi xem bảng giá bạn phải nhớ tên dịch vụ bạn muốn yêu cầu báo giá"),
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  Widget imageWidget(BuildContext context){
    return Image.network('',fit: BoxFit.cover,width: DeviceUtils.getScaledWidth(context,1),height: DeviceUtils.getScaledHeight(context,0.5),);
  }

}