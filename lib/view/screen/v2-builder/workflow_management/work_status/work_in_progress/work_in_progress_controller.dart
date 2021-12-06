import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/trang_thai_don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/trang_thai_don_dich_vu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';

class V2WorkInProgressController extends GetxController {
  //TextEditingController
  final customerOpinionController = TextEditingController();
  final yKienThoThauController = TextEditingController();
  TrangThaiDonDichVuProvider trangThaiDonDichVuProvider =
      GetIt.I.get<TrangThaiDonDichVuProvider>();

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  //donDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();

  //PhanHoiDonDichVu
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();
  PhanHoiDonDichVuRequest phanHoiDonDichVuRequest = PhanHoiDonDichVuRequest();

  List<TrangThaiDonDichVuResponse> trangThais = [];
  TrangThaiDonDichVuResponse? trangThai;

  //title appbar
  String title = "Việc đang làm";

  //user id
  String userId = '';

  //loading
  bool isLoading = true;

  bool coValue = false;

  //isClicked
  bool isClickedStatus = false;
  bool isClickedContent = false;

  @override
  void onInit() {
    super.onInit();
    //get arguments
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
      getUserId().then((value) {
        getPhanHoiDonDichVu();

        // load trang thai don dich vu
        getTrangThaiDonDichVu();
      });
    }
  }

  @override
  void onClose() {
    yKienThoThauController.dispose();
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
            yKienThoThauController.text = data.first.yKienThoThau!;
            phanHoiDonDichVuRequest.yKienThoThau = data.first.yKienThoThau;
          }

          //mapping khachHangDanhGia
          if (data.first.khachHangDanhGia != "null") {
            phanHoiDonDichVuRequest.khachHangDanhGia =
                data.first.khachHangDanhGia;
          }

          // có value
          coValue = true;
        }

        update();
      },
      onError: (error) {
        print("V1WorkInProgressController getPhanHoiDonDichVu onError $error");
      },
    );
  }

  ///
  /// get Trang Thai Don Dich Vu
  ///
  void getTrangThaiDonDichVu() {
    trangThaiDonDichVuProvider.all(
      onSuccess: (data) {
        for (final x in data) {
          if (["trúng thầu", "chưa nghiệm thu"]
              .contains(x.tieuDe.toString().toLowerCase())) {
            trangThais.add(x);
          }
        }

        if (trangThais.isNotEmpty) {
          trangThai = trangThais.first;
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print(
            "V1WorkInProgressController getTrangThaiDonDichVu onError $error");
      },
    );
  }

  ///
  /// thay doi trang thai
  ///
  void onThayDoiTrangThaiChange({
    required TrangThaiDonDichVuResponse data,
    required Widget widget,
  }) {
    if (data.id == CHUA_NGHIEM_THU) {
      Get.dialog(widget);
      trangThai = data;
      update();
    }
  }

  ///
  ///on accept click
  ///
  void onAcceptClick() {
    if (isClickedStatus) {
      return;
    } else {
      isClickedStatus = true;
      // update trang thai don dich vu
      donDichVuProvider.update(
        data: DonDichVuRequest(
          id: donDichVuResponse.id,
          idTrangThaiDonDichVu: trangThai!.id.toString(),
          ngayKetThuc: DateTime.now().toIso8601String(),
        ),
        onSuccess: (data) {
          if (phanHoiDonDichVuRequest.id == null) {
            //set data
            phanHoiDonDichVuRequest.idTaiKhoan =
                donDichVuResponse.idTaiKhoan!.id;
            phanHoiDonDichVuRequest.idTaiKhoanNhanDon = userId;
            phanHoiDonDichVuRequest.daXem = "0";
            phanHoiDonDichVuRequest.idDonDichVu = donDichVuResponse.id;

            //add
            phanHoiDonDichVuProvider.add(
              data: phanHoiDonDichVuRequest,
              onSuccess: (data) {
                Get.back(result: true);
                IZIAlert.success(
                    message: "Cập nhật trạng thái công việc thành công!");
              },
              onError: (error) {
                print("V1WorkInProgressController add onError $error");
              },
            );
          } else {
            Get.back(result: true);
            IZIAlert.success(message: "Cập nhật trạng thái công việc thành công!");
          }
        },
        onError: (error) {
          print(
              "V1WorkInProgressController getPhanHoiDonDichVu onError $error");
        },
      );
    }
  }

  ///
  ///btn send
  ///
  void onBtnSendClick() {
    if (isClickedContent) {
      return;
    } else {
      //validate
      if (yKienThoThauController.text.isEmpty) {
        IZIAlert.error(
            message: "Vui lòng nhập đánh giá, nếu không có thì nhập không");
      } else {
        isClickedContent = true;
        //set data
        phanHoiDonDichVuRequest.yKienThoThau = yKienThoThauController.text;

        if (phanHoiDonDichVuRequest.id != null) {
          //update
          phanHoiDonDichVuProvider.update(
            data: phanHoiDonDichVuRequest,
            onSuccess: (update) {
              Get.back(result: true);
              IZIAlert.success(message: "Gửi ý kiến thành công");
            },
            onError: (error) {
              print("V1WorkInProgressController update onError $error");
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
