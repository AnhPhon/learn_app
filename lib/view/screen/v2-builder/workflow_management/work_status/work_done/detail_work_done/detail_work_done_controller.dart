import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2DetailWorkDoneController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  List<Map<String, dynamic>>? deploymentItems;

  //Khai báo isLoading
  bool isLoading = true;

  String nameProject = "Thợ ốp lát công trình khách 5 sao";
  String city = 'Đà Nẵng';
  String address = 'BT 170 Nguyễn Đình Thi Hòa Xuân – Đà Nẵng';
  String introduce =
      "Dự án biệt thự 170 Nguyễn Đình Thi là dự án được xây dựng trên thành phố Đà Nẵng với tổng diện tích hơn 1000m2";

  @override
  void onInit() {
    super.onInit();

    // load thong tin
    loadThongTin();

    // deployment Items init
    deploymentItemInit();
  }

  ///
  /// load thông tin dự án
  ///
  void loadThongTin() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      donDichVuProvider.find(
        id: workFlowId!,
        onSuccess: (data) {
          nameProject = data.tieuDe!;
          address = data.idTinhTp!.ten!;
          city = data.idQuanHuyen!.ten!;
          introduce = data.moTaChiTiet!;

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// deployment Item Init
  ///
  void deploymentItemInit() {
    deploymentItems = [
      {
        "title": "Ốp lát",
      },
      {
        "title": "Xây trát",
      },
      {
        "title": "Chống thấm",
      },
      {
        "title": "Nội thất",
      },
      {
        "title": "Sơn bả",
      },
      {
        "title": "Nhôm kính",
      },
    ];
  }
}
