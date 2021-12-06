import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';

import 'auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder(
        builder: (AuthController controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                DropDownButton<String>(
                  data: const ["m2","m3",'Tấn','Tạ','Kg'],
                  obligatory: true,
                  onChanged: (unit)=> {},
                  value: null,
                  width: DeviceUtils.getScaledSize(context,0.5),
                  label: "Đơn vị",
                  hint: 'Chọn đơn vị',
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
