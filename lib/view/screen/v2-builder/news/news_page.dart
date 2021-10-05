import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/news/news_controller.dart';

class V2NewsPage extends GetView<V2NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V2NewsController>(
        init: V2NewsController(),
        builder: (V2NewsController controller) {
          return const Center(
            child: Text("Tin tức"),
          );
        },
      ),
    );
  }
}
