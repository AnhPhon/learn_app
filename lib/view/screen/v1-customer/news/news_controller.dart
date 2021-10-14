import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
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

  List<ScrollController> scrollController = [];

  DanhMucTinTucProvider danhMucTinTucProvider =
      GetIt.I.get<DanhMucTinTucProvider>();
  List<DanhMucTinTucResponse> danhMucTinTucList = [];

  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  List<TinTucResponse> tinTucModelList = [];

  String title = "Tin tức";

  int pageMax = 1;
  int currentMax = 5;
  int indexScroll = 0;

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
      danhMucTinTucList = value;

      // binding data tab
      tabController = TabController(vsync: this, length: value.length);

      //binding scroll controller tab
      scrollController =
          List<ScrollController>.filled(value.length, ScrollController());
      print(scrollController.length);

      // load data product with id categories
      getNewsByIdCategory(index: isSelectedIndexTab);

      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
    }).then((value) => listenerScroll());
  }

  ///
  ///get all tin tuc
  ///
  void getNewsByIdCategory({required int index}) {
    isLoadingNews = true;
    indexScroll = index;
    pageMax = 1;
    currentMax = 5;
    tinTucModelList.clear();
    update();
    tinTucProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idDanhMucTinTuc=${danhMucTinTucList[index].id}&sortBy=desc",
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
  ///listener scroll
  ///
  void listenerScroll() {
    scrollController[indexScroll].addListener(() {
      print(scrollController[indexScroll].position.pixels ==
          scrollController[indexScroll].position.maxScrollExtent);
      if (scrollController[indexScroll].position.pixels ==
          scrollController[indexScroll].position.maxScrollExtent) {
        pageMax += 1;
        currentMax = currentMax;
        tinTucProvider.paginate(
          page: pageMax,
          limit: currentMax,
          filter:
              "&idDanhMucTinTuc=${danhMucTinTucList[indexScroll].id}&sortBy=desc",
          onSuccess: (value) {
            tinTucModelList = tinTucModelList + value;
            update();
          },
          onError: (error) {
            print(error);
          },
        );
      }
    });
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
