import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_tin_tuc_response.dart';
import 'package:template/data/model/response/tin_tuc_response.dart';
import 'package:template/provider/tin_tuc_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2NewsCategoriesController extends GetxController
    with SingleGetTickerProviderMixin {
  DanhMucTinTucResponse? danhMucTinTucList;

  RefreshController refreshController = RefreshController();
  TinTucProvider tinTucProvider = GetIt.I.get<TinTucProvider>();

  RxList<TinTucResponse> tinTucModelList = <TinTucResponse>[].obs;

  int pageMax = 1;
  int currentMax = 5;

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
    refreshController.dispose();
  }

  ///
  ///get news by idCategory
  ///
  void getNewsByIdCategory() {
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
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
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
    update();
    tinTucProvider.paginate(
        page: 1,
        limit: 5,
        filter:
            "&idDanhMucTinTuc=${danhMucTinTucList!.id}&sortBy=create_at:desc",
        onSuccess: (value) {
          tinTucModelList.value = value;
          refreshController.refreshCompleted();
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }

  ///
  ///load more
  ///
  void loadMoreNews() {
    pageMax += 1;
    print(pageMax);
    currentMax = currentMax;
    tinTucProvider.paginate(
      page: pageMax,
      limit: currentMax,
      filter: "&idDanhMucTinTuc=${danhMucTinTucList!.id}&sortBy=create_at:desc",
      onSuccess: (data) {
        if (data.isEmpty) {
          refreshController.loadNoData();
        } else {
          tinTucModelList.value = tinTucModelList.toList() + data;
          refreshController.loadComplete();
        }

        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick({required int index}) {
    Get.toNamed("${AppRoutes.V1_NEWS_DETAIL}?id=${tinTucModelList[index].id}");
  }
}
