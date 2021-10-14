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

class V1NewsCategoriesController extends GetxController with SingleGetTickerProviderMixin {
  DanhMucTinTucResponse? danhMucTinTucList;

  RefreshController refreshController = RefreshController(initialRefresh: false);
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();

  RxList<TinTucResponse> tinTucModelList = <TinTucResponse>[].obs;

  String title = "Tin tức";

  int pageMax = 1;
  int currentMax = 5;
  int indexRefresh = 0;

  bool isLoading = true;
  bool isLoadingNews = false;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () {
      getNewsByIdCategory();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///
  ///get news by idCategory
  ///
  void getNewsByIdCategory() {
    isLoadingNews = true;
    update();
    pageMax = 1;
    currentMax = 5;
    tinTucModelList.clear();
    update();
    tinTucProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idDanhMucTinTuc=${danhMucTinTucList!.id}&sortBy=create_at:desc",
      onSuccess: (value) {
        tinTucModelList.value = value;
        isLoadingNews = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  Future<void> onRefresh() async {
    reloadNews();
  }

  Future<void> onLoading() async {
    loadMoreNews();
  }

  ///
  ///reload
  ///
  void reloadNews() {
    print('reloadNews');
    pageMax = 1;
    currentMax = 5;
    isLoadingNews = true;
    update();
    tinTucProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idDanhMucTinTuc=${danhMucTinTucList!.id}&sortBy=create_at:desc",
        onSuccess: (value) {
          tinTucModelList.value = value;
          isLoadingNews = false;
          refreshController.refreshCompleted();
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
    print('loadMoreNews');
    pageMax += 1;
    currentMax = currentMax;
    tinTucProvider.paginate(
      page: pageMax,
      limit: currentMax,
      filter: "&idDanhMucTinTuc=${danhMucTinTucList!.id}&sortBy=create_at:desc",
      onSuccess: (value) {
        tinTucModelList.value = tinTucModelList.value.toList() + value;
        isLoadingNews = false;
        refreshController.loadComplete();
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
    return DateConverter.isoStringToLocalFullDateOnly(dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1)).toString();
  }

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick({required int index}) {
    Get.toNamed("${AppRoutes.V1_NEWS_DETAIL}?id=${tinTucModelList[index].id}");
  }
}
