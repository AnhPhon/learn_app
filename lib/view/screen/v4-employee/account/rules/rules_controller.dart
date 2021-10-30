import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/dieu_khoan_chinh_sach_response.dart';
import 'package:template/provider/dieu_khoan_chinh_sach_provider.dart';

class V4RulesController extends GetxController {
  DieuKhoanChinhSachProvider dieuKhoanChinhSachProvider =
      GetIt.I.get<DieuKhoanChinhSachProvider>();
  List<DieuKhoanChinhSachResponse> dieuKhoanChinhSachModelList = [];
  DieuKhoanChinhSachResponse? dieuKhoanChinhSachResponse;
  //Khai báo isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDieuKhoanChinhSach();
  }

  ///
  ///Get Điều khoản chính sách
  ///
  void getDieuKhoanChinhSach() {
    dieuKhoanChinhSachProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&type=2",
      onSuccess: (value) {
        dieuKhoanChinhSachModelList.addAll(value);

        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }
}
