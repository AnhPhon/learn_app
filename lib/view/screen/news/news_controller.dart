import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_news_model.dart';
import 'package:template/data/model/body/news_model.dart';
import 'package:template/provider/category_news_provider.dart';
import 'package:template/provider/news_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/news/news_detail/news_detail_controller.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class NewsController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;
  CategoryNewsProvider categoryNewsProvider =
      GetIt.I.get<CategoryNewsProvider>();
  NewsProvider newsProvider = GetIt.I.get<NewsProvider>();
  final newsDetailController = Get.put(NewsDetailController());

  List<CategoryNewsModel> categoryNewsList = [];
  List<NewsModel> newsList = [];

  bool isLoading = false;

  int isSelectedIndexTab = 0;

  @override
  void onInit() {
    super.onInit();
    categoryNewsProvider.all(onSuccess: (value) {
      categoryNewsList = value;
      this.tabController =
          TabController(vsync: this, length: categoryNewsList.length);
      tabController!.addListener(() {
        isSelectedIndexTab = tabController!.index;
        getNewsWithIdCateg(id: categoryNewsList[isSelectedIndexTab].id!);
      });
      getNewsWithIdCateg(id: categoryNewsList[isSelectedIndexTab].id!);
      update();
    }, onError: (error) {
      print(error);
      update();
    });
    newsDetailController.getAllNews();
  }

  //get news with categry news
  void getNewsWithIdCateg({required String id}) {
    newsProvider.paginate(
        page: 1,
        limit: 5,
        filter: "idCategoryNews=$id",
        onSuccess: (value) {
          newsList = value;

          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  void onNewsClick() {
    Get.toNamed(AppRoutes.NEWS_DETAIL);
  }
}
