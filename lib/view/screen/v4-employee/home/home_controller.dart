import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thu_chi_nhan_vien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V4HomeController extends GetxController {
  // providers
  ThuChiNhanVienProvider thuChiNhanVienProvider =
      GetIt.I.get<ThuChiNhanVienProvider>();

  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  //khai báo thời gian báo cáo
  TimeOfDay reportTimekeeping = const TimeOfDay(hour: 17, minute: 0);

  //khai báo thời gian chấm công
  TimeOfDay timekeeping = const TimeOfDay(hour: 7, minute: 0);

  //khai báo thay đổi text chấm công và báo cáo
  bool isvalid = 7 <= TimeOfDay.now().hour && TimeOfDay.now().hour <= 17;

  List<Map<String, dynamic>>? contentGrid;

  String fullname = "Phạm Dương";
  String avatar = "";
  double? total;
  double? revenue; // thu
  double? expenditure; // chi

  // số lượng các tiến độ
  int moiTaoQuality = 0;
  int dangLamQuality = 0;
  int hoanThanhQuality = 0;
  int chamTreQuality = 0;

  // isloading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    total = 0;
    revenue = 0;
    expenditure = 0;

    sl.get<SharedPreferenceHelper>().userId.then((id) {
      taiKhoanProvider.find(
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
          print(error);
        },
      );
    });

    update();
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
          if (type == "loai 1") {
            revenue = revenue! + money;
          } else {
            expenditure = expenditure! + money;
          }
          total = total! + revenue!;
          total = total! - expenditure!;
        }
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///  theo doi tien do
  ///
  void _theoDoiTienDo() {
    congViecNhanVienProvider.paginate(
      page: 1,
      limit: 10,
      filter: "",
      onSuccess: (models) {
        for (final model in models) {
          final String status = model.trangThai!.toLowerCase();
          if (status == "moi tao") {
            moiTaoQuality = moiTaoQuality + 1;
          } else if (status == "dang lam") {
            dangLamQuality = dangLamQuality + 1;
          } else if (status == "hoan thanh") {
            hoanThanhQuality = hoanThanhQuality + 1;
          } else {
            chamTreQuality = chamTreQuality + 1;
          }
          _resetContenGrid();
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// reset content grid
  ///
  void _resetContenGrid() {
    contentGrid = [
      {
        "title": "Mới tạo",
        "quality": moiTaoQuality,
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff79B4B8),
        ])
      },
      {
        "title": "Đang làm",
        "quality": dangLamQuality,
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff00B4D8),
        ]),
      },
      {
        "title": "Hoàn Thành",
        "quality": hoanThanhQuality,
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff00A676),
        ]),
      },
      {
        "title": "Chậm trễ",
        "quality": chamTreQuality,
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xffD00000),
        ]),
      }
    ];
  }

  ///
  /// click to work progress page
  ///
  void onClickToWorkProgress(int index) {
    Get.toNamed("${AppRoutes.V4_WORKPROGRESS}?tabIndex=$index");
  }

  /// click to timekeeping
  ///
  void onClickToTimeKeeping(BuildContext context) {
    Get.toNamed(AppRoutes.V4_TIMEKEEPING)!.then((value) {
      if (value == true) {
        showAnimatedDialog(
          context,
          const MyDialog(
            icon: Icons.check,
            title: "Thành Công",
            description: "Bạn đã chấm công thành công!",
          ),
          dismissible: false,
          isFlip: true,
        );
        update();
      }
    });
  }

  ///
  ///click to report timekeeping
  ///
  void onClickToReportTimeKeeping(BuildContext context) {
    Get.toNamed(AppRoutes.V4_REPORT_TIMEKEEPING)!.then((value) {
      if (value == true) {
        showAnimatedDialog(
          context,
          const MyDialog(
            icon: Icons.check,
            title: "Thành Công",
            description: "Báo cáo thành công!",
          ),
          dismissible: false,
          isFlip: true,
        );
        update();
      }
    });
  }

  ///
  /// Từ 7h đén 17 thì sẽ điểu hướng đến page chấm công , từ 17h đến 7h sáng hôm sau sẽ điều hướng đén trang báo cáo
  ///
  void onBtnTimeKeepingClick(BuildContext context) {
    final double _reportTimekeeping = reportTimekeeping.hour.toDouble() +
        (reportTimekeeping.minute.toDouble() / 60);
    final double _timekeeping =
        timekeeping.hour.toDouble() + (timekeeping.minute.toDouble() / 60);
    final double _timeNow = TimeOfDay.now().hour.toDouble() +
        (TimeOfDay.now().minute.toDouble() / 60);

    if (_reportTimekeeping < _timeNow) {
      onClickToReportTimeKeeping(context);
    } else if (_timeNow < _timekeeping) {
      onClickToReportTimeKeeping(context);
    } else {
      onClickToTimeKeeping(context);
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
  void onClickRevenue(BuildContext context) {
    Get.toNamed("${AppRoutes.V4_REVENUE_EXPENDITURE}?revenue=true")!
        .then((value) {
      if (value == true) {
        showAnimatedDialog(
          context,
          const MyDialog(
            icon: Icons.check,
            title: "Thành Công!",
            description: "Thêm thu thành công!",
          ),
          dismissible: false,
          isFlip: true,
        );
        update();
      }
    });
  }

  ///
  /// click to Expenditure page
  ///
  void onClickExpenditure(BuildContext context) {
    Get.toNamed("${AppRoutes.V4_REVENUE_EXPENDITURE}?revenue=false")!
        .then((value) {
      if (value == true) {
        showAnimatedDialog(
          context,
          const MyDialog(
            icon: Icons.check,
            title: "Thành Công!",
            description: "Thêm chi thành công!",
          ),
          dismissible: false,
          isFlip: true,
        );
        update();
      }
    });
  }
}
