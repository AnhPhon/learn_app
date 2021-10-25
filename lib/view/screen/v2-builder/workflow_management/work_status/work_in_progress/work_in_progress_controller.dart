import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/trang_thai_don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/trang_thai_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkInProgressController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  TrangThaiDonDichVuProvider trangThaiDonDichVuProvider =
      GetIt.I.get<TrangThaiDonDichVuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  //khai báo isLoading
  bool isLoading = true;

  final rateBuilder = TextEditingController();

  String job = "Thợ ốp lát";
  String title = "Công trình khách hàng 4 sao tại Đà Nẵng";
  String city = "Đà Nẵng";
  String address = "Ngũ Hành Sơn";
  String deadline = "35 ngày";
  bool isStatus = true;
  String result = "Chưa nghiệm thu";
  String rate = "Không có";

  final String dangTuyenKey = "đang tuyển";
  final String dangXuLyKey = "đang xử lý";
  final String hoanThanhKey = "hoàn thành";

  String? selectIndex;
  String? keyIndex;
  List<TrangThaiDonDichVuResponse> selectList = [];
  @override
  void onInit() {
    super.onInit();

    // load trang thai
    loadTrangThai();

    // get data don dich vu
    getDonDichVu();

    // trang thai khach hang
    getKhachHangDanhGia();
  }

  ///
  /// load trang thai
  ///
  void loadTrangThai() {
    trangThaiDonDichVuProvider.paginate(
      page: 1,
      limit: 20,
      filter: "",
      onSuccess: (models) {
        selectList = [];
        for (final element in models) {
          final String tieuDe = element.tieuDe!.toLowerCase();
          if (tieuDe == 'đã làm' || tieuDe == 'đang làm') {
            selectList.add(element);
          }
        }
        if (selectList.isNotEmpty) {
          selectIndex = selectList[0].tieuDe;
          keyIndex = selectList[0].id;
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// get data don dich vu
  ///
  void getDonDichVu() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      donDichVuProvider.find(
        id: workFlowId!,
        onSuccess: (model) {
          if (model != null) {
            // set adress
            address = "";
            if (model.idQuanHuyen != null) {
              address += model.idQuanHuyen!.ten!;
            }
            // set title
            title = model.tieuDe!;

            // set city
            if (model.idTinhTp != null) {
              city = model.idTinhTp!.ten!;
            }

            // set deadline
            deadline = _getDeadline(model.ngayKetThuc!);

            if (model.idTrangThaiDonHang != null) {
              // set icon and color
              isStatus = model.idTrangThaiDonHang!.tieuDe!.toLowerCase() ==
                  dangTuyenKey;

              // set status
              result = model.idTrangThaiDonHang!.tieuDe!;
            }

            isLoading = false;
            update();
          }
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// get khach hang danh gia
  ///
  void getKhachHangDanhGia() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      phanHoiDonDichVuProvider.paginate(
        page: 1,
        limit: 20,
        filter: "&idDonDichVu=$workFlowId",
        onSuccess: (models) {
          if (models.isNotEmpty) {
            rate = models[0].khachHangDanhGia!;
          }
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// update data feature
  ///
  void updateData() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      print("PRINT $workFlowId");
      phanHoiDonDichVuProvider.paginate(
        page: 1,
        limit: 20,
        filter: "&idDonDichVu=$workFlowId",
        onSuccess: (models) {
          if (models.isNotEmpty) {
            final String id = models[0].id!;
            // update y kien tho thau
            phanHoiDonDichVuProvider.update(
              data: PhanHoiDonDichVuRequest(
                yKienThoThau: rateBuilder.text,
                id: id,
              ),
              onSuccess: (value) {
                // set trang thái
                donDichVuProvider.update(
                  data: DonDichVuRequest(
                    id: workFlowId,
                    idTrangThaiDonDichVu: keyIndex,
                  ),
                  onSuccess: (success) {
                    Get.back(result: true);
                  },
                  onError: (error) {
                    print(
                      "TermsAndPolicyController getTermsAndPolicy onError $error",
                    );
                  },
                );
              },
              onError: (error) {
                print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error",
                );
              },
            );
          } else {
            sl.get<SharedPreferenceHelper>().userId.then((userId) {
              sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
                phanHoiDonDichVuProvider.add(
                  data: PhanHoiDonDichVuRequest(
                    yKienThoThau: rateBuilder.text,
                    idDonDichVu: workFlowId,
                    idTaiKhoan: userId,
                  ),
                  onSuccess: (success) {
                    Get.back(result: true);
                  },
                  onError: (error) {
                    print(
                      "TermsAndPolicyController getTermsAndPolicy onError $error",
                    );
                  },
                );
              });
            });
          }
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
  void onStatusChange(String? name, String? id) {
    selectIndex = name;
    keyIndex = id;
    update();
  }

  ///
  ///Click to Detail Work In progress page
  ///
  void onClickToDetialWorkInProgressPage() {
    Get.toNamed(AppRoutes.V2_DETAIL_WORK_IN_PROGRESS);
  }

  ///
  /// submit
  ///
  void submit() {
    if (_validate()) {
      updateData();
    }
  }

  ///
  /// format date
  ///
  String _getDeadline(String end) {
    final DateTime current = DateTime.now();
    final DateTime dateEnd = DateConverter.convertStringToDatetime(
      end.replaceAll("T", " ").substring(
            0,
            end.length - 1,
          ),
    );

    return "${dateEnd.difference(current).inDays} ngày";
  }

  bool _validate() {
    if (rateBuilder.text == '') {
      Get.snackbar("Báo lỗi", "Mục ý kiến thầu không được rỗng");
      return false;
    }
    return true;
  }
}
