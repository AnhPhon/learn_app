import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'news_controller.dart';

class V1NewsPage extends GetView<V1NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V1NewsController>(
        init: V1NewsController(),
        builder: (V1NewsController controller) {
          return const Center(
            child: Text("Tin tức"),
          );
        },
      ),
    );
  }
}
