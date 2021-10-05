import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/product/product_controller.dart';

class V1ProductPage extends GetView<V1ProductController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProductController>(
        init: V1ProductController(),
        builder: (controller) {
          return const Center(child: Text("Sản phẩm"));
        });
  }
}
