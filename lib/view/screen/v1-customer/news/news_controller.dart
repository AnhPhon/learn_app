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

class V1NewsController extends GetxController with SingleGetTickerProviderMixin {
  TabController? tabController;
  int isSelectedIndexTab = 0;

  DanhMucTinTucProvider danhMucTinTucProvider = GetIt.I.get<DanhMucTinTucProvider>();
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

      danhMucTinTucList = value;

      // binding data tab
      tabController = TabController(vsync: this, length: value.length);

      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
    });
  }

}
