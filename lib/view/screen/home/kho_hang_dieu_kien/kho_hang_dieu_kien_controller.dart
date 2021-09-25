import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/product_model.dart';
import 'package:template/provider/product_provider.dart';

class KhoHangDieuKienController extends GetxController {
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();

  List<ProductModel> productList = [];

  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // lấy tất cả sản phẩm
  void getAllProduct() {
    productProvider.all(onSuccess: (value) {
      productList = value;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  //  money normalize
  String moneyNormalize(int money, String splitSymbol) {
    String text = money.toString().split('').reversed.join();
    int size = text.length;

    String result = "";
    int mark = 0;
    for (int i = 0; i < size; i++) {
      mark += 1;
      result = text[i] + result;

      if (mark % 3 == 0) {
        result = splitSymbol + result;
      }
    }

    if (result[0] == splitSymbol) result = result.substring(1, result.length);

    return result;
  }
}
