

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class SuccessfullyPage extends StatelessWidget {
  const SuccessfullyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title:"Tạo đơn thành công",leading: false,),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(Images.create_success),
            ),
            const Expanded(
              flex: 4,
              child: Text("Bạn đã tạo đơn thành công ! \n"
              "Chúng tôi sẽ phản hồi lại cho bạn sớm nhất có thể !\n"
              "Cảm ơn bạn đã tin tưởng và lựa chọn dịch vụ của chúng tôi !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: LongButton(title: "Hoàn thành", 
                  color: ColorResources.PRIMARYCOLOR, 
                  onPressed: (){
                    Get.offAndToNamed(AppRoutes.V1_DASHBOARD);
                    
                    //Get.offAllNamed(AppRoutes.V1_G1_CREATE_WORK);
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}