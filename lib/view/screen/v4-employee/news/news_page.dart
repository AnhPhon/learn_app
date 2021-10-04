import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'news_controller.dart';

class V4NewsPage extends GetView<V4NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V4NewsController>(
          init: V4NewsController(),
          builder: (V4NewsController controller) {
            return const Center(
              child: Text("News Page"),
            );
          }),
    );
  }
}
