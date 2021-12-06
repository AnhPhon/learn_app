import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:tiengviet/tiengviet.dart';

class ProductController extends GetxController {
  // refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //TextEditingController
  TextEditingController searchController = TextEditingController();

  // SanPham
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamList = [];

  //DanhMucSanPham
  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucList = [];
  DanhMucSanPhamResponse? danhMucSanPhamResponse;

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
  int limitSearchtMax = 8;

  @override
  void onInit() {
    super.onInit();
    //get agument
    danhMucSanPhamResponse = (Get.arguments != null)
        ? Get.arguments as DanhMucSanPhamResponse
        : null;
    loadDanhMucSanPham();
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
    danhMucSanPhamProvider.all(
      onSuccess: (values) {
        danhMucList = values;

        //insert tab tat ca
        danhMucList.insert(0, DanhMucSanPhamResponse(ten: "Tất cả"));
        if (danhMucSanPhamResponse != null) {
          danhMucSanPhamResponse = danhMucList.firstWhere(
              (element) => element.id == danhMucSanPhamResponse!.id);
        } else {
          danhMucSanPhamResponse = danhMucList.first;
        }
        loadSanPham(isRefresh: true);
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
      filter: danhMucSanPhamResponse!.id == null
          ? "&sortBy=created_at:desc"
          : "&idDanhMucSanPham=${danhMucSanPhamResponse!.id}&sortBy=created_at:desc",
      onSuccess: (data) {
        //check is empty
        if (data.isEmpty) {
          if (isRefresh) {
            refreshController.refreshCompleted();
          } else {
            refreshController.loadNoData();
          }
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

        isLoading = false;
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
    Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: value);
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
    isSPLoading = true;
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
        limit: limitSearchtMax,
        filter: (danhMucSanPhamResponse!.id == null)
            ? "&tenSearch=${TiengViet.parse(searchController.text)}&sortBy=created_at:desc"
            : "&idDanhMucSanPham=${danhMucSanPhamResponse!.id}&tenSearch=${TiengViet.parse(searchController.text)}&sortBy=created_at:desc",
        onSuccess: (data) {
          //check is empty
          if (data.isEmpty) {
            if (isRefresh) {
              refreshController.refreshCompleted();
            } else {
              refreshController.loadNoData();
            }
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
          isSPLoading = false;
          update();
        },
        onError: (error) {
          print("V1ProductController searchProduct onError $error");
        },
      );
    }
  }

  ///
  ///btn search
  ///
  void btnSearch(BuildContext context) {
    if (searchController.text.isNotEmpty) {
      searchProduct(context, isRefresh: true);
    }
  }

  ///
  ///clear search
  ///
  void clearSearch(BuildContext context) {
    //clear text
    searchController.clear();
    isSearched = false;
    isSPLoading = true;

    //reset noData
    refreshController.resetNoData();

    //reload
    loadSanPham(isRefresh: true);
    FocusScope.of(context).requestFocus(FocusNode());
    update();
  }
}
