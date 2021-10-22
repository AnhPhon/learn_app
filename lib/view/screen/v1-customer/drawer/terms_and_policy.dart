import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/drawer/terms_and_policy_controller.dart';

class TermsAndPolicy extends GetView<TermsAndPolicyController> {
  const TermsAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(title: "Điều khoản và chính sách"),
      body: GetBuilder(
        init: TermsAndPolicyController(),
        builder: (TermsAndPolicyController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(
                  Dimensions.PADDING_SIZE_SMALL
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_LARGE
                      ),
                      child: Text(controller.fss.first.tieuDe!, style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    Html(data: CommonHelper().htmlUnescape(controller.fss.first.noiDung!))
                  ],
                ),
              )
            ),
          );
        },
      )
    );
  }
}