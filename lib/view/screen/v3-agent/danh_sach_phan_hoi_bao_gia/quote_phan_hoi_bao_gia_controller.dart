import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/phi_app_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

class V3QuotePhanHoiBaoGiaController extends GetxController
    with SingleGetTickerProviderMixin {
  final DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  CaiDatChungProvider caiDatChungProvider = GetIt.I.get<CaiDatChungProvider>();
  PhiAppProvider phiAppProvider = GetIt.I.get<PhiAppProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  RefreshController? refreshDaPhanHoiController;
  RefreshController? refreshChuaPhanHoiController;
  List<DonDichVuResponse> daPhanHoiDDV = [];
  List<DonDichVuResponse> chuaPhanHoiDDV = [];

  int currentIndex = 0;
  bool isLoading = true;
  String title = "Danh sách phản hồi báo giá";
  List<String> statusList = ["Đạt", "Không đạt"];

  List<String> datCheckList = [CHOT_GIA, TRUNG_THAU, THAT_BAI];
  List<String> chuaCheckList = [DA_DUYET, DA_BAO_GIA];

  double giaTriDonHang = 0;
  double phiDichVu = 0;
  double khuyenMaiCuaApp = 0;

  String? idTaiKhoan = "";

  double money = 0;

  int page1 = 1;
  int page2 = 1;

  @override
  void onInit() {
    super.onInit();

    refreshDaPhanHoiController = RefreshController();
    refreshChuaPhanHoiController = RefreshController();

    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      idTaiKhoan = userId;
      update();

      // load da phan hoi
      loadData(userId.toString(), 1);

      // load chua phan hoi
      loadData(userId.toString(), 2);
    });
  }

  @override
  void onClose() {
    refreshDaPhanHoiController!.dispose();
    refreshChuaPhanHoiController!.dispose();
    super.onClose();
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// load da phan hoi
  ///
  void loadData(String id, int index) {
    daPhanHoiDDV.clear();
    chuaPhanHoiDDV.clear();

    // load da phan hoi
    if (index == 1) {
      page1 = 1;
      loadDaPhanHoi(id, page1);
    }

    // load chua phan hoi
    if (index == 2) {
      page2 = 1;
      loadChuaPhanHoi(id, page2);
    }

    Future.delayed(const Duration(microseconds: 1500))
        .then((value) => isLoading = false);
  }

  ///
  /// load dữ liệu đã phản hồi
  ///
  void loadDaPhanHoi(String idTaiKhoan, int page) {
    donDichVuProvider.paginate(
      page: page,
      limit: 20,
      filter: '&sortBy=created_at:desc',
      onSuccess: (donDichVuList) {
        if (donDichVuList.isEmpty) {
          refreshDaPhanHoiController!.loadNoData();
        }

        for (final item in donDichVuList) {
          danhSachBaoGiaDonDichVuProvider.paginate(
            page: 1,
            limit: 30,
            filter: "&idDonDichVu=${item.id}&idTaiKhoanBaoGia=$idTaiKhoan",
            onSuccess: (data) {
              if (data.isNotEmpty) {
                if (datCheckList.contains(item.idTrangThaiDonDichVu!.id) &&
                    item.idTaiKhoanNhanDon!.id! == idTaiKhoan) {
                  if (datCheckList.contains(item.idTrangThaiDonDichVu!.id) &&
                      item.idTaiKhoanNhanDon != null) {
                    daPhanHoiDDV.add(item);
                  }
                } else {
                  if (item.idTrangThaiDonDichVu!.id == DA_BAO_GIA) {
                    daPhanHoiDDV.add(item);
                  }
                }
              }
              update();
            },
            onError: (error) {
              print(
                  "V3QuotePhanHoiBaoGiaController loadChuaPhanHoi onError $error");
            },
          );
        }
      },
      onError: (error) {
        print("V3QuotePhanHoiBaoGiaController loadChuaPhanHoi onError $error");
      },
    );
  }

  ///
  /// load dữ liệu chưa phản hồi
  ///
  void loadChuaPhanHoi(String idTaiKhoan, int page) {
    chuaPhanHoiDDV.clear();
    donDichVuProvider.paginate(
      page: page,
      limit: 20,
      filter: '&idNhomDichVu=$NHOM_DICH_VU_8&sortBy=created_at:desc',
      onSuccess: (donDichVuList) {
        if (donDichVuList.isEmpty) {
          refreshChuaPhanHoiController!.loadNoData();
        }

        for (final item in donDichVuList) {
          if (chuaCheckList.contains(item.idTrangThaiDonDichVu!.id) &&
              item.idTaiKhoanNhanDon == null) {
            danhSachBaoGiaDonDichVuProvider.paginate(
              page: 1,
              limit: 20,
              filter: "&idDonDichVu=${item.id}&idTaiKhoanBaoGia=$idTaiKhoan",
              onSuccess: (data) {
                if (data.isNotEmpty) {
                  chuaPhanHoiDDV.add(item);
                }
                isLoading = false;
                update();
              },
              onError: (error) {
                print(error);
              },
            );
          }
        }
      },
      onError: (error) {
        print("V3QuotePhanHoiBaoGiaController loadChuaPhanHoi onError $error");
      },
    );
  }

  ///
  /// on xoa don hang click
  ///
  void onXoaDonHangClick(DonDichVuResponse idDonDichVu) {
    Get.defaultDialog(
      title: "Thông báo",
      content: DialogContentPriceAccept(
        textContent: 'Bạn có muốn xóa đơn hàng này không',
      ),
      confirm: ElevatedButton(
          onPressed: () {
            IZIAlert.error(message: "Đã xóa đơn hàng");
            donDichVuProvider.update(
              data: DonDichVuRequest(
                id: idDonDichVu.id,
                idTrangThaiDonDichVu: DA_HUY,
              ),
              onSuccess: (data) {
                daPhanHoiDDV.clear();
                chuaPhanHoiDDV.clear();
                onDaDonPhanHoiRefresh();
              },
              onError: (error) {
                print(
                    "V3QuotePhanHoiBaoGiaController onXoaDonHangClick onError $error");
              },
            );
          },
          child: const Text("Đồng ý")),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorResources.GREY,
        ),
        onPressed: () {
          Get.back();
        },
        child: const Text("Hủy"),
      ),
    );
  }

  ///
  /// on thong tin khach hang click
  ///
  void onThongTinKhachHangClick(DonDichVuResponse idDonDichVu) {
    Get.toNamed(AppRoutes.V3_THONG_TIN_KHACH_HANG, arguments: idDonDichVu);
  }

  ///
  /// go to Product Response
  ///
  void onProductResponseClick(DonDichVuResponse idDonDichVu) {
    // tinh tien
    tinhTien(idDonDichVu);
  }

  ///
  /// tinh tiền
  ///
  void tinhTien(DonDichVuResponse idDonDichVu) {
    // load khuyến mãi
    phiAppProvider.all(onSuccess: (phiApps) {
      giaTriDonHang =
          idDonDichVu.tienCoc != null ? double.parse(idDonDichVu.tienCoc!) : 0;

      for (final phi in phiApps) {
        final double donGiaBatDau = double.parse(phi.donGiaBatDau.toString());
        final double donGiaKetThuc = double.parse(phi.donGiaKetThuc.toString());

        if (donGiaBatDau <= giaTriDonHang && giaTriDonHang <= donGiaKetThuc) {
          phiDichVu = idDonDichVu.tienCoc != null
              ? double.parse(idDonDichVu.tienCoc!)
              : 0;

          // set value cho khuyến mãi app
          caiDatChungProvider.all(
            onSuccess: (data) {
              if (data.isNotEmpty) {
                khuyenMaiCuaApp =
                    double.parse(data.first.khuyenMai.toString()) /
                        100 *
                        phiDichVu;

                // prediction to than toan phi dich vu
                Get.toNamed(
                  AppRoutes.V3_THANH_TOAN_PHI_DICH_VU,
                  arguments: [
                    [giaTriDonHang, khuyenMaiCuaApp, phiDichVu],
                    idDonDichVu.id
                  ],
                )!
                    .then((value) {
                  if (value != null) {
                    // update status trung thau khi back ve
                    donDichVuProvider.find(
                      id: idDonDichVu.id.toString(),
                      onSuccess: (data) {
                        donDichVuProvider.update(
                            data: DonDichVuRequest(
                              id: data.id,
                              idTrangThaiDonDichVu: TRUNG_THAU,
                            ),
                            onSuccess: (data) {
                              onDaDonPhanHoiRefresh();
                            },
                            onError: (error) {
                              print(
                                  "V3DaPhanHoiController onThanhToanPhiDichVuClick onError $error");
                            });
                      },
                      onError: (error) {
                        print(
                            "V3DaPhanHoiController onThanhToanPhiDichVuClick onError $error");
                      },
                    );
                  }
                });
              }
              isLoading = false;
              update();
            },
            onError: (error) {
              print(error);
            },
          );

          update();
        }
      }
    }, onError: (error) {
      print(error);
    });
  }

  ///
  /// go to Product Response
  ///
  void onProductNoResponseClick(DonDichVuResponse idDonDichVu) {
    Get.toNamed(AppRoutes.V3_CHUA_PHAN_HOI, arguments: idDonDichVu);
  }

  ///
  /// on đơn phan hoi refresh
  ///
  Future<void> onDaDonPhanHoiRefresh() async {
    page1 = 1;
    refreshDaPhanHoiController!.resetNoData();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      daPhanHoiDDV.clear();
      loadDaPhanHoi(value.toString(), page1);
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDaPhanHoiController!.refreshCompleted();
  }

  ///
  /// on đơn phan hoi loading
  ///
  Future<void> onDaDonPhanHoiLoading() async {
    page1++;
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      loadDaPhanHoi(value.toString(), page1);
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshDaPhanHoiController!.loadComplete();
  }

  ///
  /// on đơn phan hoi refresh
  ///
  Future<void> onChuaDonPhanHoiRefresh() async {
    page2 = 1;
    refreshChuaPhanHoiController!.resetNoData();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      chuaPhanHoiDDV.clear();
      loadChuaPhanHoi(value.toString(), page2);
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshChuaPhanHoiController!.refreshCompleted();
  }

  ///
  /// on đơn phan hoi loading
  ///
  Future<void> onChuaDonPhanHoiLoading() async {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      page2++;
      loadChuaPhanHoi(value.toString(), page2);
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshChuaPhanHoiController!.loadComplete();
  }
}
