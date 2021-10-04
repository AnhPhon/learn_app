import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/news/news_controller.dart';

class V1NewsPage extends GetView<V1NewsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1NewsController>(
        init: V1NewsController(),
        builder: (controller) {
          return const Center(child: Text("Tin tức"));
        });
  }
}
