import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3ProductController extends GetxController {
  final searchController = TextEditingController();
  String title = "Sản phẩm";

  ///
  ///go to product detail
  ///
  void onProductDetailClick() {
    Get.toNamed(AppRoutes.V3_PRODUCT_DETAIL);
  }
}
