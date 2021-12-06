import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/dieu_khoan_chinh_sach_response.dart';
import 'package:template/data/model/response/quy_che_cong_ty_response.dart';
import 'package:template/provider/dieu_khoan_chinh_sach_provider.dart';
import 'package:template/provider/quy_che_cong_ty_provider.dart';

class V4RulesController extends GetxController {
  //Điều khoản chính sách Provider
  DieuKhoanChinhSachProvider dieuKhoanChinhSachProvider =
      GetIt.I.get<DieuKhoanChinhSachProvider>();
  List<DieuKhoanChinhSachResponse> dieuKhoanChinhSachModelList = [];
  DieuKhoanChinhSachResponse? dieuKhoanChinhSachResponse;

  //Quy chế công ty Provider
  QuyCheCongTyProvider quyCheCongTyProvider =
      GetIt.I.get<QuyCheCongTyProvider>();
  List<QuyCheCongTyResponse> quyCheCongTyModelList = [];
  QuyCheCongTyResponse? quyCheCongTyResponse;

  //Khai báo isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getQuyCheCongTy();
  }

  ///
  ///Get Điều khoản chính sách
  ///
  void getQuyCheCongTy() {
    quyCheCongTyProvider.paginate(
      page: 1,
      limit: 10,
      filter: "",
      onSuccess: (value) {
        quyCheCongTyModelList.addAll(value);
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V4RulesController getQuyCheCongTy onError $error");
      },
    );
  }
}
