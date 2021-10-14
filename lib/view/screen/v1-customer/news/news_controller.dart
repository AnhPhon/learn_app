import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_tin_tuc_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/danh_muc_tin_tuc_provider.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1NewsController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;
  int isSelectedIndexTab = 0;

  List<RefreshController> refreshController = [];

  DanhMucTinTucProvider danhMucTinTucProvider =
      GetIt.I.get<DanhMucTinTucProvider>();
  List<DanhMucTinTucResponse> danhMucTinTucList = [];

  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  List<TinTucResponse> tinTucModelList = [];

  String title = "Tin tức";

  int pageMax = 1;
  int currentMax = 5;
  int indexRefresh = 0;

  bool isLoading = true;
  bool isLoadingNews = false;

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
    danhMucTinTucProvider.all(onSuccess: (value) {
      //
      for (var i = 0; i < value.length; i++) {
        refreshController.add(new RefreshController(initialRefresh: false));
      }
      print(" 0101${refreshController.length}");

      // //
      danhMucTinTucList = value;

      // // binding data tab
      tabController = TabController(vsync: this, length: value.length);
      print("object ${danhMucTinTucList.length}");

      // refreshController = List<RefreshController>.filled(
      //     value.length, new RefreshController(initialRefresh: false));

      // load data product with id categories
      // getNewsByIdCategory(index: isSelectedIndexTab);

      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
    });
  }

  ///
  ///get news by idCategory
  ///
  void getNewsByIdCategory({required int index}) {
    if (indexRefresh == index) {
      return;
    }
    isLoadingNews = true;
    indexRefresh = index;
    update();
    // pageMax = 1;
    // currentMax = 5;
    // tinTucModelList.clear();
    // update();
    // tinTucProvider.paginate(
    //     page: 1,
    //     limit: 5,
    //     filter:
    //         "&idDanhMucTinTuc=${danhMucTinTucList[index].id}&sortBy=create_at:desc",
    //     onSuccess: (value) {
    //       tinTucModelList = value;
    //       isLoadingNews = false;
    //       update();
    //     },
    //     onError: (error) {
    //       print(error);
    //     });
  }

  Future<void> onRefresh() async {
    reloadNews();
    refreshController[indexRefresh].refreshCompleted();
  }

  Future<void> onLoading() async {
    loadMoreNews();
    refreshController[indexRefresh].loadComplete();
  }

  ///
  ///reload
  ///
  void reloadNews() {
    isLoadingNews = true;
    update();
    tinTucProvider.paginate(
        page: 1,
        limit: 5,
        filter:
            "&idDanhMucTinTuc=${danhMucTinTucList[indexRefresh].id}&sortBy=create_at:desc",
        onSuccess: (value) {
          tinTucModelList = value;
          isLoadingNews = false;
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///load more
  ///
  void loadMoreNews() {
    pageMax += 1;
    currentMax = currentMax;
    tinTucProvider.paginate(
      page: pageMax,
      limit: currentMax,
      filter:
          "&idDanhMucTinTuc=${danhMucTinTucList[indexRefresh].id}&sortBy=create_at:desc",
      onSuccess: (value) {
        tinTucModelList = tinTucModelList + value;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick({required int index}) {
    Get.toNamed("${AppRoutes.V1_NEWS_DETAIL}?id=${tinTucModelList[index].id}");
  }
}
