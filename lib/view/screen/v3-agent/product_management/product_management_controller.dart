import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';

class V3ProductManagementController extends GetxController
    with SingleGetTickerProviderMixin {
  int indexTab = 0;

  // RefreshController refreshController = RefreshController();

  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucSanPhamResponse = [];

  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamResponse = [];

  int pageMax = 1;
  int limitMax = 5;

  bool isLoading = true;
  bool isLoadingProduct = true;

  String title = "Quản lý sản phẩm";

  @override
  void onInit() {
    super.onInit();
    getAllCategory();
  }

  ///
  ///get all category
  ///
  void getAllCategory() {
    print("object020asdas");
    danhMucSanPhamProvider.all(
      onSuccess: (value) {
        print("object020");
        danhMucSanPhamResponse = value;

        //get product
        getProductByIdCategory(isRefresh: true);

        isLoading = false;
        update();
      },
      onError: (error) {
        print("object023");
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///listener tab controller
  ///
  void onChangedTab(int index) {
    indexTab = index;
    sanPhamResponse.clear();
    isLoadingProduct = true;
    update();
    getProductByIdCategory(isRefresh: true);
  }

  ///
  ///get product by idCategory
  ///
  void getProductByIdCategory({required bool isRefresh}) {
    if (isRefresh) {
      pageMax = 1;
    } else {
      pageMax++;
    }

    //paginate by idCategory
    sanPhamProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idDanhMucSanPham=${danhMucSanPhamResponse[indexTab].id}",
      onSuccess: (value) {
        sanPhamResponse = value;

        isLoadingProduct = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }
}
