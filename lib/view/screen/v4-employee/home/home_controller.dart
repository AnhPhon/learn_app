import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/provider/nhan_vien_provider.dart';
import 'package:template/provider/thu_chi_nhan_vien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V4HomeController extends GetxController {
  GetIt sl = GetIt.instance;
  // Thu chi nhân viên Provider
  ThuChiNhanVienProvider thuChiNhanVienProvider =
      GetIt.I.get<ThuChiNhanVienProvider>();

  //Công việc nhân viên Provider
  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  //Nhân viên Provider
  NhanVienProvider nhanVienProvider = GetIt.I.get<NhanVienProvider>();

  // refresh controller
  RefreshController? refreshController;

  //khai báo thay đổi text chấm công và báo cáo
  bool isChange = false;

  // Load Ngày tháng năm
  String thu = DateFormat('EEEE', 'vi-VN').format(DateTime.now());
  String ngay = DateTime.now().day.toString();
  String thang = DateTime.now().month.toString();
  String nam = DateTime.now().year.toString();

  // isSelected
  bool? isSelected;

  // isReport
  bool? isReport;

  // khai báo String chấm công
  String checkSelected = "";

  // khai báo String báo cáo
  String checkReported = "";

  List<Map<String, dynamic>>? contentGrid;

  String fullname = "Phạm Dương";
  String avatar = "";
  double? total;
  double? revenue; // thu
  double? expenditure; // chi

  // số lượng các tiến độ
  int? moiTaoQuality;
  int? dangLamQuality;
  int? hoanThanhQuality;
  int? chamTreQuality;

  // isloading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // init refreshController
    refreshController ??= RefreshController();

    // init program run
    initProgramRun();

    //Reset isSelected
    resetIsSelected();

    //Check isSelected
    getIsSelected();

    //Reset isReport
    resetIsReport();

    //Check isReport
    getIsReport();

    //CHu kì 10p sẽ reload page
    timePeriodic();
  }

  ///
  ///Time Periodic
  ///
  Future<void> timePeriodic() async {
    final DateTime timeReal = await NTP.now();
    final double timeNow = timeReal.hour + (timeReal.minute / 60);
    if (7 <= timeNow && timeNow <= 16) {
      isChange = true;
      update();
    } else if (7 > timeNow || timeNow > 16) {
      isChange = false;
      update();
    }

    Timer.periodic(const Duration(minutes: 10), (timer) {
      onInit();
      update();
      timer.cancel();
    });
  }

  ///
  ///Reset isSelected
  ///
  Future<void> resetIsSelected() async {
    final DateTime timeReal = await NTP.now();
    final double timeNow = timeReal.hour + (timeReal.minute / 60);
    if (timeNow > 16) {
      sl.get<SharedPreferenceHelper>().saveIsSelected(isSelected: false);
      sl.get<SharedPreferenceHelper>().isSelected.then((value) {
        isSelected = value;
        update();
      });
    }
  }

  ///
  /// Get isSelected
  ///
  void getIsSelected() {
    sl.get<SharedPreferenceHelper>().isSelected.then((value) {
      isSelected = value;
      update();
    });
  }

  ///
  ///Reset IsReprot
  ///
  Future<void> resetIsReport() async {
    final DateTime timeReal = await NTP.now();
    final double timeNow = timeReal.hour + (timeReal.minute / 60);
    if (7 < timeNow && timeNow < 16) {
      sl.get<SharedPreferenceHelper>().saveIsReport(isReport: false);
      sl.get<SharedPreferenceHelper>().isReport.then((value) {
        isReport = value;
        update();
      });
    }
  }

  ///
  /// Get isReport
  ///
  void getIsReport() {
    sl.get<SharedPreferenceHelper>().isReport.then((value) {
      isReport = value;
      update();
    });
  }

  ///
  /// init program run
  ///
  void initProgramRun() {
    total = 0;
    revenue = 0;
    expenditure = 0;

    moiTaoQuality = 0;
    dangLamQuality = 0;
    hoanThanhQuality = 0;
    chamTreQuality = 0;

    sl.get<SharedPreferenceHelper>().userId.then((id) {
      nhanVienProvider.find(
        id: id!,
        onSuccess: (taiKhoanResponse) {
          fullname = taiKhoanResponse.hoTen!;
          avatar = taiKhoanResponse.hinhDaiDien!;

          // load thu chi
          _readRevenueAndExpenditure(id);

          // xử lý tiến độ công việc
          _theoDoiTienDo();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// set user
  ///
  void _readRevenueAndExpenditure(String id) {
    // set name of user
    thuChiNhanVienProvider.paginate(
      page: 1,
      limit: 50,
      filter: "&idNhanVien=$id",
      onSuccess: (models) {
        for (final model in models) {
          final String type = model.loai.toString().toLowerCase();
          final double money = double.parse(model.soTien!);
          if (type == "1") {
            revenue = revenue! + money;
          } else {
            expenditure = expenditure! + money;
          }
        }
        total = total! + revenue!;
        total = total! - expenditure!;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///  theo doi tien do
  ///
  void _theoDoiTienDo() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      congViecNhanVienProvider.paginate(
        page: 1,
        limit: 100,
        filter: "&idNhanVien=$id",
        onSuccess: (models) {
          if (models.isNotEmpty) {
            for (final model in models) {
              final String status = model.trangThai!.toLowerCase();
              if (status == "1") {
                moiTaoQuality = moiTaoQuality! + 1;
              } else if (status == "2") {
                dangLamQuality = dangLamQuality! + 1;
              } else if (status == "3") {
                hoanThanhQuality = hoanThanhQuality! + 1;
              } else {
                chamTreQuality = chamTreQuality! + 1;
              }
            }
          } else {
            moiTaoQuality = 0;
            dangLamQuality = 0;
            hoanThanhQuality = 0;
            chamTreQuality = 0;
          }
          _resetContenGrid();
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
  /// reset content grid
  ///
  void _resetContenGrid() {
    contentGrid = [
      {
        "title": "Mới tạo",
        "quality": moiTaoQuality,
        "color": RadialGradient(colors: [
          const Color(0xffE7C550).withOpacity(.78),
          const Color(0xffBE8542).withOpacity(.78),
        ]),
      },
      {
        "title": "Đang làm",
        "quality": dangLamQuality,
        "color": RadialGradient(colors: [
          const Color(0xffC1E6EE).withOpacity(.78),
          const Color(0xff00B4D8).withOpacity(.78),
        ]),
      },
      {
        "title": "Hoàn Thành",
        "quality": hoanThanhQuality,
        "color": RadialGradient(colors: [
          const Color(0xff97DBAE).withOpacity(.78),
          const Color(0xff3FA963).withOpacity(.78),
        ]),
      },
      {
        "title": "Chậm trễ",
        "quality": chamTreQuality,
        "color": RadialGradient(colors: [
          const Color(0xffEE7B7B).withOpacity(.78),
          const Color(0xffF81818).withOpacity(.78),
        ]),
      }
    ];
  }

  ///
  /// click to work progress page
  ///
  void onClickToWorkProgress(int index) {
    Get.toNamed("${AppRoutes.V4_WORKPROGRESS}?tabIndex=$index")!.then((value) {
      // init program run
      initProgramRun();
      update();
    });
  }

  /// click to timekeeping
  ///
  void onClickToTimeKeeping() {
    Get.toNamed(AppRoutes.V4_TIMEKEEPING)!.then((value) {
      if (value == true) {
        Alert.success(message: "Bạn đã chấm công thành công!");
        onInit();
        update();
      }
    });
  }

  ///
  ///click to report timekeeping
  ///
  void onClickToReportTimeKeeping() {
    Get.toNamed(AppRoutes.V4_REPORT_TIMEKEEPING)!.then((value) {
      if (value == true) {
        Alert.success(message: "Bạn đã Báo cáo thành công!");
        onInit();
        update();
      }
    });
  }

  ///
  /// Từ 7h đén 17 thì sẽ điểu hướng đến page chấm công , từ 17h đến 7h sáng hôm sau sẽ điều hướng đén trang báo cáo
  ///
  Future<void> onBtnTimeKeepingClick() async {
    final DateTime timeReal = await NTP.now();
    final double _timeNow = timeReal.hour + (timeReal.minute / 60);

    // Nếu timeNow lớn hơn 16 giờ thì đi đến trang Báo cáo
    if (16 < _timeNow) {
      // isReport = fasle là chưa báo cáo , isReport = true là đã báo cáo
      if (isReport == false || isReport == null) {
        onClickToReportTimeKeeping();
      }

      // Nếu timeNow bé hơn 7 giờ thì đi đến trang Báo cáo
    } else if (_timeNow < 7) {
      // isReport = fasle là chưa báo cáo , isReport = true là đã báo cáo
      if (isReport == false || isReport == null) {
        onClickToReportTimeKeeping();
      }
      // Ngược lại dến trang chấm công
    } else {
      // isSelected = fasle là chưa chấm công , isSelected = true là đã chấm công
      if (isSelected == false || isSelected == null) {
        onClickToTimeKeeping();
      }
      update();
    }
  }

  ///
  ///click to export page
  ///
  void onClickToExprot() {
    Get.toNamed("${AppRoutes.V4_EXPORT_IMPROT}?export=true")!.then((value) {
      if (value == true) {
        Alert.success(message: "Xuất kho thành công!");

        initProgramRun();
        update();
      }
    });
  }

  ///
  ///click to import page
  ///
  void onClickToImport() {
    Get.toNamed("${AppRoutes.V4_EXPORT_IMPROT}?export=flase")!.then((value) {
      if (value == true) {
        Alert.success(message: "Nhập kho thành công!");

        initProgramRun();
        update();
      }
    });
  }

  /// click to Revenue page
  ///
  void onClickRevenue(BuildContext context) {
    Get.toNamed("${AppRoutes.V4_REVENUE_EXPENDITURE}?revenue=true")!
        .then((value) {
      if (value == true) {
        Alert.success(message: "Thêm thu thành công!");

        //refresh lại home pape
        initProgramRun();
        update();
      }
    });
  }

  ///
  /// click to Expenditure page
  ///
  void onClickExpenditure() {
    Get.toNamed("${AppRoutes.V4_REVENUE_EXPENDITURE}?revenue=false")!
        .then((value) {
      if (value == true) {
        Alert.success(message: "Thêm chi thành công!");

        //refresh lại home pape
        initProgramRun();
        update();
      }
    });
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    initProgramRun();
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController!.refreshCompleted();
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController!.loadComplete();
  }

  void goToInfo() {
    Get.toNamed(AppRoutes.V4_INFO)!.then((value) {
      if (value == true) {
        onInit();
        update();
      }
      update();
    });
  }
}
