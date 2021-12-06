import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/data/model/request/loai_bao_cao_nhan_vien.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/data/model/response/cham_cong_response.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class V4ReportController extends GetxController
    with SingleGetTickerProviderMixin {
  GetIt sl = GetIt.instance;
  BaoCaoNhanVienResponse baoCaoNhanVienResponse = BaoCaoNhanVienResponse();

  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();

  //Khai báo model báo cáo
  List<BaoCaoNhanVienResponse> baoCaoNhanVienModelList = [];

  // khai báo cham cong
  ChamCongResponse chamCongResponse = ChamCongResponse();
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();
  ChamCongRequest chamCongRequest = ChamCongRequest();
  //Khai báo model báo cáo
  List<ChamCongResponse> chamCongModelList = [];

  // Khai báo Danh sách lọc
  List<BaoCaoNhanVienModel> baoCaoNhanVienModel = [
    BaoCaoNhanVienModel(id: "0", tieuDe: "Tất cả"),
    BaoCaoNhanVienModel(id: "1", tieuDe: "Yêu cầu"),
    BaoCaoNhanVienModel(id: "2", tieuDe: "Ngày"),
  ];

  BaoCaoNhanVienModel? nhanVienModel;

  // khai báo isUser
  String idUser = '';
  //khai báo isLoading
  bool isLoading = true;

  //khai báo thời gian bắt đầu báo cáo
  TimeOfDay timeStartReport = const TimeOfDay(hour: 16, minute: 0);

  //khai báo thời gian hết báo cáo
  TimeOfDay timeEndReport = const TimeOfDay(hour: 7, minute: 0);

  // refresh controller for load more refresh
  RefreshController refreshController = RefreshController(initialRefresh: true);

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //GetIdUser
    getIdUser();

    // onChanged giá trị ban đầu là tất cả
    onChanged(newValue: baoCaoNhanVienModel[0]);

    // get tất cả báo cáo
    getReport(isRefresh: true, value: "0");
  }

  ///
  /// đóng TextEditingController
  ///
  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }

  ///
  /// get id user
  ///
  void getIdUser() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      idUser = id!;
    });
  }

  ///
  /// Load danh sách báo báo theo loại yêu cầu hoặc theo ngày
  ///
  void getReport({required bool isRefresh, required String value}) {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      //isRefresh
      if (isRefresh) {
        pageMax = 1;
        baoCaoNhanVienModelList.clear();
      } else {
        //is load more
        pageMax++;
      }
      String filter = "";
      if (value == "0") {
        filter = '&idNhanVien=$id&sortBy=created_at:desc';
      } else {
        filter = '&loai=$value&idNhanVien=$id&sortBy=created_at:desc';
      }
      baoCaoNhanVienProvider.paginate(
          page: pageMax,
          limit: limitMax,
          filter: filter,
          onSuccess: (value) {
            //check isEmpty
            if (value.isEmpty) {
              refreshController.loadNoData();
            } else {
              //is Refresh
              if (isRefresh) {
                baoCaoNhanVienModelList = value;
                refreshController.refreshCompleted();
              } else {
                //is load more
                baoCaoNhanVienModelList =
                    baoCaoNhanVienModelList.toList() + value;
                refreshController.loadComplete();
              }
            }
            isLoading = false;
            update();
          },
          onError: (error) {
            print("V4ReportController getReport onError $error");
          });
    });
  }

  ///
  ///Click to onchanged filter
  ///
  void onChanged({required BaoCaoNhanVienModel newValue}) {
    nhanVienModel = newValue;
    getReport(isRefresh: true, value: nhanVienModel!.id.toString());
    update();
  }

  ///
  /// Set reload List
  ///
  Future<void> onRefresh() async {
    refreshController.resetNoData();
    getReport(isRefresh: true, value: nhanVienModel!.id.toString());
  }

  ///
  /// Set load more List
  ///
  Future<void> onLoading() async {
    getReport(isRefresh: false, value: nhanVienModel!.id.toString());
  }

  ///
  ///Click to Daily report
  ///
  void onClickToDailyReport(BuildContext context) {
    Get.toNamed(AppRoutes.V4_ADD_DAILY_REPORT)!.then((value) {
      if (value == true) {
        getReport(isRefresh: true, value: nhanVienModel!.id.toString());
        update();
      }
    });
  }

  ///
  ///Click to report on request
  ///
  void onClickToReportOnRequest(BuildContext context) {
    Get.toNamed(AppRoutes.V4_ADD_REPORT_ON_REQUEST)!.then((value) {
      if (value == true) {
        getReport(isRefresh: true, value: nhanVienModel!.id.toString());
        update();
      }
    });
  }

  ///
  ///format date time
  ///
  String getFormattedDate(String date) {
    /// Convert into local date format.
    /// Convert into local date format.
    // var localDate =
    //     DateTime.parse(date).toLocal().add(const Duration(hours: 7));
    final localDate = DateTime.parse(date).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format should be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format should be dd/MM/yyyy HH:mm
    final inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    final inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    final outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    final outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  ///
  ///go to  detail report page
  ///
  void onClickDetailReport(BaoCaoNhanVienResponse report) {
    Get.toNamed(AppRoutes.V4_DETAIL_REPORT, arguments: report)!.then((value) {
      if (value == true) {
        getReport(isRefresh: true, value: nhanVienModel!.id.toString());
        update();
      }
    });
  }

  ///
  /// Từ 16h - 7h sáng hôm say sẽ mở báo cáo ngày. Còn lại sẽ hiện Dialog thông báo hết hiệu lực để báo.
  ///
  Future<void> managerReportTimer(BuildContext context) async {
    final DateTime timeReal = await NTP.now();
    final double _timeNow = timeReal.hour + (timeReal.minute / 60);

    // Nếu timeNow lớn hơn 16 giờ thì đi đến trang Báo cáo
    if (16 < _timeNow) {
      // isReport = fasle là chưa báo cáo , isReport = true là đã báo cáo
      return onClickToDailyReport(context);
      // Nếu timeNow bé hơn 7 giờ thì đi đến trang Báo cáo
    } else if (_timeNow < 7) {
      // isReport = fasle là chưa báo cáo , isReport = true là đã báo cáo
      return onClickToDailyReport(context);
      // Ngược lại dến trang chấm công
    } else {
      Get.defaultDialog(
        titlePadding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_LARGE,
          horizontal: Dimensions.PADDING_SIZE_LARGE,
        ),
        radius: Dimensions.BORDER_RADIUS_DEFAULT,
        title: "Đã qua thời gian báo cáo có hiệu lực!",
        middleText: "Vui lòng quay lại và thực hiện báo cáo cho ngày hôm nay!",
        cancel:
            // Button back
            _btnBack(),
      );
    }
  }

  ///
  ///Button quay lại khi hiển thị Dialog thông báo hết thời gian báo cáo
  ///
  Widget _btnBack() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: Dimensions.PADDING_SIZE_LARGE * 2,
        width: Dimensions.PADDING_SIZE_LARGE * 6,
        decoration: BoxDecoration(
          color: ColorResources.PRIMARY,
          borderRadius: BorderRadius.circular(
            Dimensions.BORDER_RADIUS_DEFAULT,
          ),
        ),
        child: const Center(
          child: Text(
            "Quay lại",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              color: ColorResources.WHITE,
            ),
          ),
        ),
      ),
    );
  }
}
