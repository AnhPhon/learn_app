import 'package:get/get.dart';
import 'package:template/data/model/response/dieu_khoan_chinh_sach_response.dart';
import 'package:template/provider/dieu_khoan_chinh_sach_provider.dart';

class V3RulesController extends GetxController {
  // dieuKhoanChinhSach
  DieuKhoanChinhSachProvider dieuKhoanChinhSachProvider =
      DieuKhoanChinhSachProvider();
  DieuKhoanChinhSachResponse? dieuKhoanChinhSachResponse;

  //title appbar
  String title = "Điều khoản và chính sách";

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    // get load data
    getRules();
  }

  ///
  ///get rules
  ///
  void getRules() {
    dieuKhoanChinhSachProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&type=4",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          dieuKhoanChinhSachResponse = value.first;
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3RulesController getRules onError $error");
      },
    );
  }
}
