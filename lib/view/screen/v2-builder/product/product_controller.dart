import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/routes/app_routes.dart';

class V2ProductController extends GetxController {
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

  //onchange icon (search or close)
  bool isSearched = false;

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 8;

  //page for for load more refresh
  int pageSearchMax = 1;
  int limiSearchtMax = 8;

  @override
  void onInit() {
    super.onInit();
    //get agument
    danhMucSanPhamResponse = (Get.arguments != null)
        ? Get.arguments as DanhMucSanPhamResponse
        : null;
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
        if (danhMucSanPhamResponse != null) {
          danhMucSanPhamResponse = danhMucList.firstWhere(
              (element) => element.id == danhMucSanPhamResponse!.id);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V2ProductController loadDanhMucSanPham onError $error");
      },
    );
  }

  ///
  ///load san pham
  ///
  void loadSanPham({
    required bool isRefresh,
    bool? isFirst = false,
    bool? isSearch = false,
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
        print("V2ProductController loadSanPham onError $error");
      },
    );
  }

  ///
  ///go to product detail
  ///
  void onProductDetailClick(SanPhamResponse value) {
    Get.toNamed(AppRoutes.V2_PRODUCT_DETAIL, arguments: value);
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
  Future<void> onRefresh(BuildContext context) async {
    //reset noData
    refreshController.resetNoData();

    if (isSearched) {
      //search
      searchProduct(context, isRefresh: true);
    } else {
      //isloading
      isSPLoading = true;

      //load sanPham
      loadSanPham(isRefresh: true);
    }
  }

  ///
  /// on loading
  ///
  Future<void> onLoading(BuildContext context) async {
    if (isSearched) {
      //search
      searchProduct(context, isRefresh: false);
    } else {
      //load sanPham
      loadSanPham(isRefresh: false);
    }
  }

  ///
  ///search product
  ///
  void searchProduct(
    BuildContext context, {
    required bool isRefresh,
  }) {
    //isRefresh
    if (isRefresh) {
      pageSearchMax = 1;
      sanPhamList.clear();
    } else {
      pageSearchMax++;
    }

    //get data search
    if (searchController.text.isNotEmpty) {
      sanPhamProvider.paginate(
        page: pageSearchMax,
        limit: limiSearchtMax,
        filter: (danhMucSanPhamResponse == null)
            ? "&tenSearch=${searchController.text}&sortBy=created_at:desc"
            : "&idDanhMucSanPham=${danhMucSanPhamResponse!.id}&tenSearch=${searchController.text}&sortBy=created_at:desc",
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

          FocusScope.of(context).requestFocus(FocusNode());
          isSearched = true;
          update();
        },
        onError: (error) {
          print("V2ProductController searchProduct onError $error");
        },
      );
    }
  }

  ///
  ///btn search
  ///
  void btnSearch(BuildContext context) {
    searchProduct(context, isRefresh: true);
  }

  ///
  ///clear search
  ///
  void clearSearch(BuildContext context) {
    //clear text
    searchController.text = "";
    isSearched = false;

    //reset noData
    refreshController.resetNoData();

    //reload
    loadSanPham(isRefresh: true);
    FocusScope.of(context).requestFocus(FocusNode());
    update();
  }
}
