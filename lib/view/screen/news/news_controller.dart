import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/category_news_model.dart';
import 'package:template/data/model/body/news_model.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/category_news_provider.dart';
import 'package:template/provider/news_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;

  CategoryNewsProvider categoryNewsProvider =
      GetIt.I.get<CategoryNewsProvider>();

  final searchController = TextEditingController();

  NewsProvider newsProvider = GetIt.I.get<NewsProvider>();

  List<CategoryNewsModel> categoryNewsList = [];

  List<NewsModel> newsList = [];

  NewsModel? newsModel;

  bool isLoading = true;

  bool isLoadingNews = false;

  int isSelectedIndexTab = 0;

  int isSelectedIndexNews = 0;

  @override
  void onInit() {
    super.onInit();
    getAllCategoryNews();
  }

  @override
  void onClose() {
    super.onClose();
    tabController!.dispose();
  }

  ///
  ///get all categoryNews
  ///
  void getAllCategoryNews() {
    categoryNewsProvider.all(onSuccess: (value) {
      categoryNewsList = value;

      // binding data tab
      tabController =
          TabController(vsync: this, length: categoryNewsList.length);

      // listen tab controller
      listenerTabController();

      // load data product with id categories
      getNewsWithIdCateg(id: categoryNewsList[isSelectedIndexTab].id!);

      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///listener tabController
  ///
  void listenerTabController() {
    // listen tab
    tabController!.addListener(() {
      // add loading and clear data
      isLoadingNews = true;
      newsList.clear();
      update();

      // load data product with id categories
      getNewsWithIdCateg(id: categoryNewsList[tabController!.index].id!);
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
          isLoadingNews = false;
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///view news
  ///
  void onClickNewsDetail({required int index}) {
    Get.toNamed("${AppRoutes.NEWS_DETAIL}?idNews=${newsList[index].id}");
  }

  ///
  ///time diff
  ///
  String timeAgo(String dateTime) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    final String time = dateTime;
    final loadedTime = DateConverter.convertStringToDatetime(
        time.replaceAll("T", " ").substring(0, time.length - 1));
    final now = DateTime.now();
    final difference = now.difference(loadedTime);
    return timeago.format(now.subtract(difference), locale: "vi");
  }
}
