import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'news_controller.dart';

class V3NewsPage extends GetView<V3NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V3NewsController>(
        init: V3NewsController(),
        builder: (V3NewsController controller) {
          return const Center(
            child: Text("News Page"),
          );
        },
      ),
    );
  }
}
