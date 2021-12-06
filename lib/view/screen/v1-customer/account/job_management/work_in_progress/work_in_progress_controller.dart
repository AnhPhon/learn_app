import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V1WorkInProgressController extends GetxController {
  //TextEditingController
  final customerOpinionController = TextEditingController();

  //donDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  //PhanHoiDonDichVu
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();
  PhanHoiDonDichVuRequest phanHoiDonDichVuRequest = PhanHoiDonDichVuRequest();

  //title appbar
  String title = "Việc đang làm";

  //user id
  String userId = '';

  //loading
  bool isLoading = true;

  //isClicked
  bool isClicked = false;

  @override
  void onInit() {
    super.onInit();
    //get arguments
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
      getUserId().then((value) {
        getPhanHoiDonDichVu();
      });
    }
  }

  @override
  void onClose() {
    customerOpinionController.dispose();
    super.onClose();
  }

  ///
  ///get user id
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///PhanHoiDonDichVu
  ///
  void getPhanHoiDonDichVu() {
    phanHoiDonDichVuProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idDonDichVu=${donDichVuResponse.id}",
      onSuccess: (data) {
        //check is notempty
        if (data.isNotEmpty) {
          phanHoiDonDichVuRequest.id = data.first.id;

          //set yKienThoThau
          if (data.first.yKienThoThau != "null") {
            phanHoiDonDichVuRequest.yKienThoThau = data.first.yKienThoThau;
          }

          //mapping khachHangDanhGia
          if (data.first.khachHangDanhGia != "null") {
            customerOpinionController.text = data.first.khachHangDanhGia!;
            phanHoiDonDichVuRequest.khachHangDanhGia =
                data.first.khachHangDanhGia;
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1WorkInProgressController getPhanHoiDonDichVu onError $error");
      },
    );
  }

  ///
  ///btn send
  ///
  void onBtnSendClick() {
    if (isClicked) {
      return;
    } else {
      //validate
      if (customerOpinionController.text.isEmpty) {
        IZIAlert.error(
            message: 'Vui lòng nhập đánh giá, nếu không có thì nhập "không"');
      } else {
        isClicked = true;
        //set data
        phanHoiDonDichVuRequest.khachHangDanhGia =
            customerOpinionController.text;

        if (phanHoiDonDichVuRequest.id != null) {
          //update
          phanHoiDonDichVuProvider.update(
            data: phanHoiDonDichVuRequest,
            onSuccess: (create) {
              Get.back(result: true);
              IZIAlert.success(message: "Gửi đánh giá công việc thành công");
            },
            onError: (error) {
              print("V1WorkInProgressController onBtnSendClick onError $error");
            },
          );
        } else {
          //set data
          phanHoiDonDichVuRequest.idTaiKhoan = userId;
          phanHoiDonDichVuRequest.idTaiKhoanNhanDon =
              donDichVuResponse.idTaiKhoanNhanDon!.id;
          phanHoiDonDichVuRequest.daXem = "0";
          phanHoiDonDichVuRequest.idDonDichVu = donDichVuResponse.id;

          //add
          phanHoiDonDichVuProvider.add(
            data: phanHoiDonDichVuRequest,
            onSuccess: (create) {
              Get.back(result: true);
              IZIAlert.success(message: "Gửi đánh giá công việc thành công");
            },
            onError: (error) {
              print("V1WorkInProgressController onBtnSendClick onError $error");
            },
          );
        }
      }
    }
  }

  ///
  /// format date
  ///
  String getDeadline({required String start, required String end}) {
    final DateTime dateStart = DateConverter.stringToLocalDate(start);

    final DateTime dateEnd = DateConverter.stringToLocalDate(end);

    return "${(dateEnd.difference(dateStart).inDays) + 1} ngày";
  }
}
