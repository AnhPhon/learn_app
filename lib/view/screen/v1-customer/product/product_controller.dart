import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1ProductController extends GetxController {
  // SanPham
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamList = [];

  //DanhMucSanPham
  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucList = [];
  DanhMucSanPhamResponse? danhMucSanPhamResponse;

  // refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //TextEditingController
  TextEditingController searchController = TextEditingController();

  //title appbar
  String title = "Sản phẩm";

  // loading
  bool isLoading = true;
  bool isSPLoading = true;

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 8;

  @override
  void onInit() {
    super.onInit();
    loadDanhMucSanPham();
    loadSanPham(isRefresh: true, isFirst: true);
  }

  @override
  void onClose() {
    refreshController.dispose();
    searchController.dispose();
    super.onClose();
  }

  ///
  /// load danh muc san pham
  ///
  void loadDanhMucSanPham() {
    // product list
    danhMucSanPhamProvider.all(
      onSuccess: (values) {
        danhMucList = values;

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1ProductController loadDanhMucSanPham onError $error");
      },
    );
  }

  ///
  ///load san pham
  ///
  void loadSanPham({
    required bool isRefresh,
    bool? isFirst = false,
  }) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      sanPhamList.clear();
    } else {
      pageMax++;
    }

    //load sanPham
    sanPhamProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: danhMucSanPhamResponse == null
          ? "&sortBy=created_at:desc"
          : "&idDanhMucSanPham=${danhMucSanPhamResponse!.id}&sortBy=created_at:desc",
      onSuccess: (data) {
        //check is empty
        if (data.isEmpty) {
          refreshController.loadNoData();
        } else {
          //isRefresh
          if (isRefresh) {
            sanPhamList = data;
            refreshController.refreshCompleted();
          } else {
            //is load more
            sanPhamList = sanPhamList.toList() + data;
            refreshController.loadComplete();
          }
        }

        isSPLoading = false;
        update();
      },
      onError: (error) {
        print("V1ProductController loadSanPham onError $error");
      },
    );
  }

  ///
  ///go to product detail
  ///
  void onProductDetailClick(SanPhamResponse value) {
    Get.toNamed(AppRoutes.V1_PRODUCT_DETAIL, arguments: value);
  }

  ///
  /// on Category Change
  ///
  void onCategoryChange(DanhMucSanPhamResponse? value) {
    danhMucSanPhamResponse = value;
    isSPLoading = true;
    update();
    loadSanPham(isRefresh: true);
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //isloading
    isSPLoading = true;

    //reset noData
    refreshController.resetNoData();

    //load sanPham
    loadSanPham(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //load sanPham
    loadSanPham(isRefresh: false);
  }

  ///
  ///search product
  ///
  void searchProduct() {
    if (searchController.text.isNotEmpty) {
      
    }
  }
}
