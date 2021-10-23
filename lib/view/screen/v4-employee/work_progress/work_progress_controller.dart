import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4WorkProgressController extends GetxController
    with SingleGetTickerProviderMixin {
  GetIt sl = GetIt.instance;

  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  List<CongViecNhanVienResponse> congViecMoiTaoModelList = [];
  List<CongViecNhanVienResponse> congViecDangLamModelList = [];
  List<CongViecNhanVienResponse> congViecHoanThanhModelList = [];
  List<CongViecNhanVienResponse> congViecChamTreModelList = [];

  //set model để thiết kế UI tiến độ công việc
  List<Map<String, dynamic>>? uiWorkProgress;
  //khai báo seleceted Index
  int selectedIndex = 0;

  //khai báo isLoading
  bool isLoading = true;

  TabController? tabController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //get worl progress
    selectedIndex = int.parse(Get.parameters['tabIndex'].toString());

    //get tiến độ công việc
    getTienDoCongViec();

    //List model thiết kế UI
    uiWorkProgress = [
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng A trục A",
        "description": "Phòng D,E,F của công trình A",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": -2,
      },
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng B trục B",
        "description": "Phòng D,E,F của công trình B",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": -10,
      },
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng C trục C",
        "description": "Phòng D,E,F của công trình B",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": -3,
        "status": true,
      },
      {
        "title": "Thông báo tiến độ công việc",
        "subtitle": "Phòng C trục C",
        "description": "Phòng D,E,F của công trình B",
        "daystart": "06/10/2021",
        "dayend": "11/10/2021",
        "finishday": "11/10/2021",
        "progress": 22,
      }
    ];
  }

  ///
  ///  theo doi tien do
  ///
  void getTienDoCongViec() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: 1,
        limit: 100,
        filter: "&idNhanVien=$id",
        onSuccess: (models) {
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }
}
