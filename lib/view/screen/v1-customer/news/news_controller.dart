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
  // TabController? tabController;

  DanhMucTinTucProvider danhMucTinTucProvider =
      GetIt.I.get<DanhMucTinTucProvider>();
  List<DanhMucTinTucResponse> danhMucTinTucList = [];

  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();
  List<List<TinTucResponse>> tinTucModelList = [];

  String title = "Tin tức";

  bool isLoading = true;
  bool isLoadingNews = true;

  @override
  void onInit() {
    super.onInit();
    getAllCategoryNews();
  }

  ///
  ///get all categoryNews
  ///
  void getAllCategoryNews() {
    tinTucModelList.clear();
    danhMucTinTucProvider.all(onSuccess: (value) {
      danhMucTinTucList = value;

      //add value
      value.forEach((element) {
        getNewsByIdCategory(id: element.id.toString());
      });

      isLoading = false;
      isLoadingNews = false;
      update();
    }, onError: (error) {
      print(error);
    });
  }

  ///
  ///get all tin tuc
  ///
  void getNewsByIdCategory({required String id}) {
    tinTucProvider.paginate(
        page: 1,
        limit: 100,
        filter: "&idDanhMucTinTuc=$id",
        onSuccess: (value) {
          tinTucModelList.add(value);
        },
        onError: (error) {
          print(error);
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
  void onNewsDetailClick({required int indexA, required int indexB}) {
    Get.toNamed(
        "${AppRoutes.V1_NEWS_DETAIL}?id=${tinTucModelList[indexA][indexB].id}");
  }
}
