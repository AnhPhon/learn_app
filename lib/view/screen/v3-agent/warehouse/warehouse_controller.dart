import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3WarehouseController extends GetxController {
  KhoHangDaiLyProvider khoHangDaiLyProvider = GetIt.I.get<KhoHangDaiLyProvider>();
  List<KhoHangDaiLyResponse> khoHangDaiLyResponse = [];

  RefreshController refreshController = RefreshController();

  final searchController = TextEditingController();

  String title = "Kho sản phẩm";

  String userId = "";

  int pageMax = 1;
  int limitMax = 5;

  bool isLoading = true;

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  @override
  void onInit() {
    super.onInit();
    getProduct(isRefresh: true);
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  ///
  ///get product in warehouse by idUser
  ///
  Future<void> getProduct({required bool isRefresh}) async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
    if (isRefresh) {
      pageMax = 1;
    } else {
      pageMax++;
    }
    khoHangDaiLyProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (value) {
        if (isRefresh) {
          khoHangDaiLyResponse = value;
          refreshController.loadComplete();
        } else if (value.isEmpty) {
          refreshController.loadNoData();
        } else{
          khoHangDaiLyResponse = khoHangDaiLyResponse.toList() + value;
          refreshController.loadComplete();
        }
        
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  Future<void> onRefresh() async {
    getProduct(isRefresh: true);
  }

  Future<void> onLoading() async {
    getProduct(isRefresh: false);
  }
}
