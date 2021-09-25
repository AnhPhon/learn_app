import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_news_model.dart';
import 'package:template/data/model/body/news_model.dart';
import 'package:template/provider/category_news_provider.dart';
import 'package:template/provider/news_provider.dart';
import 'package:template/routes/app_routes.dart';

class NewsController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;
  final searchController = TextEditingController();
  CategoryNewsProvider categoryNewsProvider =
      GetIt.I.get<CategoryNewsProvider>();
  NewsProvider newsProvider = GetIt.I.get<NewsProvider>();

  List<CategoryNewsModel> categoryNewsList = [];

  List<NewsModel> newsList = [];

  NewsModel? newsModel;

  bool isLoading = false;

  int isSelectedIndexTab = 0;

  int isSelectedIndexNews = 0;

  @override
  void onInit() {
    super.onInit();
    getAllCategoryNews();
  }

  ///
  ///get all categoryNews
  ///
  void getAllCategoryNews() {
    categoryNewsProvider.all(onSuccess: (value) {
      categoryNewsList = value;
      tabController =
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
  }

  ///
  /// get news with category news
  ///
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

  ///
  ///get news from id
  ///
  void getNewsFromId({required int index}) {
    newsProvider
        .find(
            id: newsList[index].id!,
            onSuccess: (value) {
              newsModel = value;
              update();
            },
            onError: (error) {
              print(error);
              update();
            })
        .then((value) => Get.toNamed(AppRoutes.NEWS_DETAIL));
  }
}
