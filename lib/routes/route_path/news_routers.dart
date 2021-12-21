import 'package:get/get.dart';
import 'package:template/view/screen/news/news_detail/news_detail__binding.dart';
import 'package:template/view/screen/news/news_detail/news_detail_page.dart';

class NewsRouters {
  static const String NEWS_DETAIL = "/news_detail";

  static List<GetPage> newsList = [
    GetPage(
      name: NEWS_DETAIL,
      page: () => NewsDetailPage(),
      binding: NewsDetailBinding(),
    ),
   
  ];
}
