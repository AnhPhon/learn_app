import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/cong_viec_nhan_vien_request.dart';
import 'package:template/data/model/response/cong_viec_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/cong_viec_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V4DetailWorkController extends GetxController {
  GetIt sl = GetIt.instance;
  CongViecNhanVienProvider congViecNhanVienProvider =
      GetIt.I.get<CongViecNhanVienProvider>();

  CongViecNhanVienResponse? moiTaoModel;

  //Khai báo isLoading
  bool isLoading = true;

  final contentDetailWork = TextEditingController();

  String? selectIndex;

  List<String> selectList = [
    "Mới tạo",
    "Đang làm",
    "Hoàn thành",
    "Chậm trễ",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //Get chi tiết thông tin chi tiết công việc MỚI TẠO
    getDetailNewWork();
  }

  ///
  ///Get thông tin chi tiết công việc mới tạo
  ///
  void getDetailNewWork() {
    //get chi tiết công việc mới tạo theo id
    sl.get<SharedPreferenceHelper>().idNewWork.then((id) {
      congViecNhanVienProvider.find(
        id: id!,
        onSuccess: (value) {
          moiTaoModel = value;
          if (moiTaoModel!.trangThai == "1") {
            selectIndex = "Mới tạo";
          } else if (moiTaoModel!.trangThai == "2") {
            selectIndex = "Đang làm";
          } else if (moiTaoModel!.trangThai == "3") {
            selectIndex = "Hoàn thành";
          } else if (moiTaoModel!.trangThai == "4") {
            selectIndex = "Chậm trễ";
          }
          contentDetailWork.text = moiTaoModel!.noiDung.toString();
          print(selectIndex);
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
  /// on status change
  ///
  void onStatusChange(String? name) {
    selectIndex = name;
    print(selectIndex);
    update();
  }

  ///
  ///Update
  ///
  void updateWork(BuildContext context) {
    if (selectIndex == "Mới tạo") {
      selectIndex = "1";
    } else if (selectIndex == "Đang làm") {
      selectIndex = "2";
    } else if (selectIndex == "Hoàn thành") {
      selectIndex = "3";
    } else if (selectIndex == "Chậm trễ") {
      selectIndex = "4";
    }
    sl.get<SharedPreferenceHelper>().idNewWork.then((id) {
      congViecNhanVienProvider.update(
        data: CongViecNhanVienRequest(
          id: id,
          trangThai: selectIndex,
          noiDung: contentDetailWork.text,
        ),
        onSuccess: (value) {
          print(selectIndex);
          if (selectIndex == "1") {
            selectIndex = "Mới tạo";
          } else if (selectIndex == "2") {
            selectIndex = "Đang làm";
          } else if (selectIndex == "3") {
            selectIndex = "Hoàn thành";
          } else if (selectIndex == "4") {
            selectIndex = "Chậm trễ";
          }
          print(selectIndex);
          Get.back(result: true);

          //show dialog
          showAnimatedDialog(
            context,
            const MyDialog(
              icon: Icons.check,
              title: "Thành công!",
              description: "Cập nhật tiến độ công việc thành công!",
            ),
            dismissible: false,
            isFlip: true,
          );
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  /// Tính tiến độ công việc
  ///
  int tienDo({required String startDate, required String endDate}) {
    return DateConverter.differenceDateyyyyMMdd(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
