import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/provider/product_provider.dart';

class KhoHangDieuKienController extends GetxController {
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  List<ProductModel> productList = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  ///
  /// lấy tất cả sản phẩm
  ///
  void getAllProduct() {
    productProvider.all(onSuccess: (value) {
      productList = value;
      isLoading = false;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }
}
