

import 'package:get/get.dart';
import 'package:template/view/screen/news/news_detail/news_detail_controller.dart';

class NewsDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailController>(() => NewsDetailController());
  }
}