import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_tin_tuc_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/provider/danh_muc_tin_tuc_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1NewsController extends GetxController
    with SingleGetTickerProviderMixin {
  //TabController
  TabController? tabController;

  //refresh controller for load more refresh
  List<RefreshController> refreshControllerList = [];

  //DanhMucTinTuc
  DanhMucTinTucProvider danhMucTinTucProvider =
      GetIt.I.get<DanhMucTinTucProvider>();
  List<DanhMucTinTucResponse> danhMucTinTucList = [];

  //tintuc
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  List<TinTucResponse> tinTucList = [];

  //title appbar
  String title = "Tin tức";

  //loading
  bool isLoading = true;
  bool isLoadingNews = true;

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  @override
  void onInit() {
    super.onInit();
    getAllCategoryNews();
  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }

  ///
  ///get all categoryNews
  ///
  void getAllCategoryNews() {
    danhMucTinTucProvider.paginate(
        page: 1,
        limit: 30,
        filter: "&sortBy=created_at:desc",
        onSuccess: (value) {
          danhMucTinTucList = value;

          // binding data tab
          tabController = TabController(vsync: this, length: value.length);

          //binding refresh controller
          refreshControllerList = List<RefreshController>.generate(
              value.length, (_) => RefreshController());

          //get news
          getNews();

          //listener TabController
          listenerTabController();

          isLoading = false;
          update();
        },
        onError: (error) {
          print("V1NewsController getAllCategoryNews onError $error");
        });
  }

  ///
  ///get news
  ///
  void getNews({bool? isRefresh = true}) {
    //isRefresh
    if (isRefresh == true) {
      pageMax = 1;
      tinTucList.clear();
    } else {
      pageMax++;
    }

    tinTucProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter:
            "&idDanhMucTinTuc=${danhMucTinTucList[tabController!.index].id}",
        onSuccess: (data) {
          if (data.isEmpty) {
            refreshControllerList[tabController!.index].loadNoData();
          } else {
            if (isRefresh == true) {
              tinTucList = data;
              refreshControllerList[tabController!.index].refreshCompleted();
            } else {
              tinTucList = tinTucList.toList() + data;
              refreshControllerList[tabController!.index].loadComplete();
            }
          }

          isLoadingNews = false;
          update();
        },
        onError: (error) {
          print("V1NewsController getNews onError $error");
        });
  }

  ///
  ///listener tabController
  ///
  void listenerTabController() {
    // listen tab
    tabController!.addListener(
      () {
        // check call first time
        if (tabController!.indexIsChanging) {
          //start CircularProgressIndicator
          isLoadingNews = true;
          update();

          //resetNoData
          refreshControllerList[tabController!.index].resetNoData();

          //get order
          getNews();
        }
      },
    );
  }

  //onRefresh
  Future<void> onRefresh() async {
    //resetNoData
    refreshControllerList[tabController!.index].resetNoData();
    //get order isRefresh
    getNews();
  }

  //onLoading
  Future<void> onLoading() async {
    //get order isLoading
    getNews(isRefresh: false);
  }

  ///
  ///on news click
  ///
  void onNewsClick({required int index}) {
    Get.toNamed(AppRoutes.V1_NEWS_DETAIL, arguments: tinTucList[index])!.then(
      (value) {
        if (value == true) {
          isLoadingNews = true;
          update();
          getNews();
        }
      },
    );
  }
}
