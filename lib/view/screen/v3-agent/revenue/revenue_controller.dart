import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/revenue_data_model.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/snack_bar.dart';

class V3RevenueController extends GetxController {
  //TextEditingController
  final startController = TextEditingController(
    text: DateConverter.estimatedDateOnly(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(const Duration(days: 7)),
    ),
  );
  final endController = TextEditingController(
    text: DateConverter.estimatedDateOnly(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(hours: 15)),
    ),
  );

  //DonHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();

  //time stamp
  String startStamp = "";
  String endStamp = "";

  //user id
  String userId = "";

  //CircularProgressIndicator
  bool isLoading = true;

  //title appbar
  String title = "Doanh thu";

  //revenueDataList
  List<RevenueData> revenueDataList = [
    RevenueData(
      unit: "Tổng doanh thu các đơn hàng",
      color: const Color(0xffdb1f1f),
    ),
    RevenueData(
      unit: "Phí dịch vụ",
      color: const Color(0xff272ba3),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    //binding time range to stamp
    startStamp =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(const Duration(days: 7))
            .millisecondsSinceEpoch
            .toString();
    endStamp =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(const Duration(hours: 15))
            .millisecondsSinceEpoch
            .toString();

    //get load data
    getAllOrderInRange();

    //listener textEditingController
    listenertextEditingController();
  }

  @override
  void onClose() {
    startController.dispose();
    endController.dispose();
    super.onClose();
  }

  ///
  ///get all order in range
  ///
  Future<void> getAllOrderInRange() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //reset data
    revenueDataList[0].money = 0;
    revenueDataList[1].money = 0;

    donHangProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId&dateStart=$startStamp&dateEnd=$endStamp",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          for (final item in value) {
            revenueDataList[0].money = revenueDataList[0].money! +
                double.parse(item.tongTien.toString());
            revenueDataList[1].money = revenueDataList[0].money! +
                double.parse(item.phiDichVu.toString());
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3RevenueController getAllOrderInRange onError $error");
      },
    );
  }

  ///
  ///listener TextEditingController
  ///
  void listenertextEditingController() {
    //startController Listener
    startController.addListener(() {
      if (startStamp != convertToTimeStamp(dateTime: startController.text) ||
          endStamp != convertToTimeStamp(dateTime: endController.text)) {
        //set data
        startStamp = convertToTimeStamp(dateTime: startController.text);
        endStamp = convertToTimeStamp(dateTime: endController.text);
        //check time diff
        if (DateConverter.differenceDate(
                startDate: startController.text, endDate: endController.text) <
            0) {
          SnackBarUtils.showSnackBar(
            title: "Vui lòng kiểm tra lại",
            message: "Thời gian kết thúc phải lớn hơn thời gian bắt đầu",
          );
        } else {
          //reset chart
          getAllOrderInRange();
        }
      }
    });

    //endController Listener
    endController.addListener(() {
      if (startStamp != convertToTimeStamp(dateTime: startController.text) ||
          endStamp != convertToTimeStamp(dateTime: endController.text)) {
        //set data
        startStamp = convertToTimeStamp(dateTime: startController.text);
        endStamp = convertToTimeStamp(dateTime: endController.text);
        //check time diff
        if (DateConverter.differenceDate(
                startDate: startController.text, endDate: endController.text) <
            0) {
          Alert.error(
              message: "Thời gian kết thúc phải lớn hơn thời gian bắt đầu");
        } else {
          //reset chart
          getAllOrderInRange();
        }
      }
    });
  }

  ///
  ///convert input to time stamp
  ///
  String convertToTimeStamp({required String dateTime}) {
    return DateConverter.toTimeStamp(
      DateConverter.convertStringddMMyyyyToDate(dateTime),
    ).toString();
  }
}
