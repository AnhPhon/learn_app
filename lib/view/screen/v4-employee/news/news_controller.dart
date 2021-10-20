import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/danh_muc_tin_tuc_response.dart';
import 'package:template/provider/danh_muc_tin_tuc_provider.dart';

class V4NewsController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;

  DanhMucTinTucProvider danhMucTinTucProvider =
      GetIt.I.get<DanhMucTinTucProvider>();
  List<DanhMucTinTucResponse> danhMucTinTucList = [];

  String title = "Tin tức";

  bool isLoading = true;

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
    danhMucTinTucProvider.paginate(
        page: 1,
        limit: 30,
        filter: "&sortBy=created_at:desc",
        onSuccess: (value) {
          danhMucTinTucList = value;

          // binding data tab
          tabController = TabController(vsync: this, length: value.length);

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }
}
