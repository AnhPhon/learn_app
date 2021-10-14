import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/thu_chi_nhan_vien_provider.dart';
import 'package:template/routes/app_routes.dart';

class V4HomeController extends GetxController {
  List<Map<String, dynamic>>? contentGrid;

  //khai báo thời gian báo cáo
  TimeOfDay reportTimekeeping = const TimeOfDay(hour: 7, minute: 0);

  //khai báo thời gian chấm công
  TimeOfDay timekeeping = const TimeOfDay(hour: 10, minute: 0);

  //khai báo thay đổi text chấm công và báo cáo
  bool isvalid = 7 <= TimeOfDay.now().hour && TimeOfDay.now().hour <= 17;


  String fullname = "Phạm Dương";
  double? total;
  double? revenue; // thu
  double? expenditure; // chi

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    contentGrid = [
      {
        "title": "Mới tạo",
        "quality": 3,
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff79B4B8),
        ])
      },
      {
        "title": "Đang làm",
        "quality": "2",
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff00B4D8),
        ]),
      },
      {
        "title": "Hoàn Thành",
        "quality": "4",
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff00A676),
        ]),
      },
      {
        "title": "Chậm trễ",
        "quality": "1",
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xffD00000),
        ]),
      }
    ];

    total = 10000000;
    revenue = 10000000;
    expenditure = 10000000;
  }

  // ///
  // /// set user
  // ///
  // void _readRevenueAndExpenditure() {
  //   // set name of user
  //   thuChiNhanVienProvider.paginate(
  //     page: 1,
  //     limit: 50,
  //     filter: "",
  //     onSuccess: (models) {
  //       for (final model in models) {
  //         String type = model.loai.toString().toLowerCase();
  //         double money = double.parse(model.soTien!);
  //         if (type == "loai 1") {
  //           revenue = revenue! + money;
  //         } else {
  //           expenditure = expenditure! + money;
  //         }
  //         total = total! + revenue!;
  //         total = total! - expenditure!;
  //       }
  //       update();
  //     },
  //     onError: (error) {
  //       print(error);
  //     },
  //   );
  // }

  ///
  ///  theo doi tien do
  ///
  // void _theoDoiTienDo() {
  //   congViecNhanVienProvider.paginate(
  //     page: 1,
  //     limit: 10,
  //     filter: "",
  //     onSuccess: (models) {
  //       for (final model in models) {
  //         final String status = model.trangThai!.toLowerCase();
  //         if (status == "moi tao") {
  //           moiTaoQuality = moiTaoQuality + 1;
  //         } else if (status == "dang lam") {
  //           dangLamQuality = dangLamQuality + 1;
  //         } else if (status == "hoan thanh") {
  //           hoanThanhQuality = hoanThanhQuality + 1;
  //         } else {
  //           chamTreQuality = chamTreQuality + 1;
  //         }
  //         _initContenGrid();
  //         isLoading = false;
  //         update();
  //       }
  //     },
  //     onError: (error) {
  //       print(error);
  //     },
  //   );
  // }

  ///
  /// reset content grid
  ///
  // void _initContenGrid() {
  //   contentGrid = [
  //     {
  //       "title": "Mới tạo",
  //       "quality": moiTaoQuality,
  //       "color": const RadialGradient(colors: [
  //         Color(0xffC1E6EE),
  //         Color(0xff79B4B8),
  //       ])
  //     },
  //     {
  //       "title": "Đang làm",
  //       "quality": dangLamQuality,
  //       "color": const RadialGradient(colors: [
  //         Color(0xffC1E6EE),
  //         Color(0xff00B4D8),
  //       ]),
  //     },
  //     {
  //       "title": "Hoàn Thành",
  //       "quality": hoanThanhQuality,
  //       "color": const RadialGradient(colors: [
  //         Color(0xffC1E6EE),
  //         Color(0xff00A676),
  //       ]),
  //     },
  //     {
  //       "title": "Chậm trễ",
  //       "quality": chamTreQuality,
  //       "color": const RadialGradient(colors: [
  //         Color(0xffC1E6EE),
  //         Color(0xffD00000),
  //       ]),
  //     }
  //   ];
  // }

  ///
  /// click to work progress page
  ///
  void onClickToWorkProgress(int index) {
    Get.toNamed("${AppRoutes.V4_WORKPROGRESS}?tabIndex=$index");
  }

  /// click to timekeeping
  ///
  void onClickToTimeKeeping() {
    Get.toNamed(AppRoutes.V4_TIMEKEEPING);
  }

  ///
  ///click to report timekeeping
  ///
  void onClickToReportTimeKeeping() {
    Get.toNamed(AppRoutes.V4_REPORT_TIMEKEEPING);
  }

  ///
  /// Từ 7h đén 17 thì sẽ điểu hướng đến page chấm công , từ 17h đến 7h sáng hôm sau sẽ điều hướng đén trang báo cáo
  ///
  void onBtnTimeKeepingClick() {
    final double _reportTimekeeping = reportTimekeeping.hour.toDouble() +
        (reportTimekeeping.minute.toDouble() / 60);
    final double _timekeeping =
        timekeeping.hour.toDouble() + (timekeeping.minute.toDouble() / 60);
    final double _timeNow = TimeOfDay.now().hour.toDouble() +
        (TimeOfDay.now().minute.toDouble() / 60);

    if (_reportTimekeeping < _timeNow && _timeNow < _timekeeping) {
      return onClickToTimeKeeping();
    } else {
      return onClickToReportTimeKeeping();
    }
  }

  ///
  ///click to export page
  ///
  void onClickToExprot() {
    Get.toNamed("${AppRoutes.V4_EXPORT_IMPROT}?export=true");
  }

  ///
  ///click to import page
  ///
  void onClickToImport() {
    Get.toNamed("${AppRoutes.V4_EXPORT_IMPROT}?export=flase");
  }

  /// click to Revenue page
  ///
  void onClickRevenue() {
    Get.toNamed("${AppRoutes.V4_REVENUE_EXPENDITURE}?revenue=true");
  }

  ///
  /// click to Expenditure page
  ///
  void onClickExpenditure() {
    Get.toNamed("${AppRoutes.V4_REVENUE_EXPENDITURE}?revenue=false");
  }
}
