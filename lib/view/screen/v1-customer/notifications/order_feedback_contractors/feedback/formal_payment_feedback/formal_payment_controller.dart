import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/thong_bao_request.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/repository/don_dich_vu_repository.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';

class V1FormalPaymentFeedbackController extends GetxController {
  DonDichVuRepository donDichVuRepository = GetIt.I.get<DonDichVuRepository>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();
  final DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  DanhSachBaoGiaDonDichVuResponse? donPhanHoi;

  DonDichVuResponse? donDichVu;

  int formalPaymentGroup = 0;
  double soTien = 0;
  double thanhToan = 0;
  double tienCoc = 0;
  double tongTien2 = 0;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null){
      donDichVu = Get.arguments as DonDichVuResponse;
      if(donDichVu!.id == NHOM_DICH_VU_6 || donDichVu!.id == NHOM_DICH_VU_5){
        toPayment();
      }else{
        tinhTien();
      }
    }
  }

  ///
  /// change formal payment
  ///
  void onChangedFormalPayment(int val) {
    formalPaymentGroup = val;
    tinhTien();
    update();
  }

  void tinhTien() {
    soTien = double.parse(donDichVu!.tongDon!);
    tienCoc = double.parse(donDichVu!.tienCoc != 'null' ? donDichVu!.tienCoc! : '0');
    if (formalPaymentGroup == 0) {
      thanhToan = soTien;
      tienCoc = 0;
    } else {
      // 10 %
      tienCoc = soTien * 10 / 100;
      thanhToan = soTien;
      tongTien2 = tienCoc;
    }
  }

  void onClickContinueButton() {
    //set value tuyendung
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.id = donDichVu!.id;

    Get.toNamed(
            '${AppRoutes.ORDER_INFORMATION}?soTien=${thanhToan.toStringAsFixed(0)}&tienCoc=${tienCoc.toStringAsFixed(0)}&noiDung=Thanh toán đơn dịch vụ')!
        .then((value){
              //đã thanh toán
              if (value != null && value['type'] == 1)
                {
                  //set trạng thái đã thanh toán

                  if (formalPaymentGroup == 0)
                    {
                      dichVuRequest.idTrangThaiThanhToan = DA_THANH_TOAN;
                    }
                  else
                    {
                      dichVuRequest.idTrangThaiThanhToan =
                          KHACH_HANG_THANH_TOAN;
                    }
                  dichVuRequest.idTrangThaiDonDichVu = CHOT_GIA;
                  dichVuRequest.phiDichVu = value['phiDichVu'].toString();
                  dichVuRequest.khuyenMai = value['khuyenMai'].toString();
                  dichVuRequest.tongDon = value['tongTien'].toString();

                  // Thông báo
                  final ThongBaoRequest thongBaoRequest = ThongBaoRequest();
                  thongBaoRequest.idTaiKhoan = donDichVu!.idTaiKhoanNhanDon!.id;
                  thongBaoRequest.idDonDichVu = donDichVu!.id;
                  thongBaoRequest.doiTuongs = ['2'];
                  thongBaoRequest.noiDung = donDichVu!.idLoaiCongViec == null ? 'Dự án đã được khách hàng chốt giá': "Dự án ${donDichVu!.idLoaiCongViec!.tenCongViec!}";
                  thongBaoRequest.status = '0';
                  thongBaoRequest.hinhDaiDien = donDichVu!.idNhomDichVu!.hinhAnhDaiDien;
                  thongBaoRequest.tieuDe = "Bạn đã trúng thầu";
                  
                  thongBaoProvider.add(data: thongBaoRequest, onSuccess: (onSuccess){
                    //insert db
                    donDichVuRepository.update(dichVuRequest).then((value) => {
                          if (value.response.data != null)
                            {
                              Get.offAllNamed(AppRoutes.V1_DASHBOARD,
                                  predicate: ModalRoute.withName(
                                      AppRoutes.V1_DASHBOARD)),
                              Get.back(),
                              Get.back(),
                              IZIAlert.success(
                                  message: 'Phản hồi dịch vụ thành công'),
                            }
                          else
                            IZIAlert.error(message: 'Vui lòng thực hiện lại')
                        });

                  }, 
                  onError: (onError){
                    print("Thêm thông báo thất bại");
                  });
                  
                }
              //chưa thanh toán
              else if (value != null && value['type'] == 2)
                {
                  //set trạng thái chưa thanh toán
                  dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
                  // dichVuRequest.idTrangThaiDonDichVu = CHOT_GIA,
                  // dichVuRequest.phiDichVu = value['phiDichVu'].toString(),
                  // dichVuRequest.khuyenMai = value['khuyenMai'].toString(),
                  // dichVuRequest.tongDon = value['tongTien'].toString(),
                  //insert db
                  donDichVuRepository.update(dichVuRequest).then((value) => {
                        if (value.response.data != null)
                          {
                            Get.offAllNamed(AppRoutes.V1_DASHBOARD,
                                predicate: ModalRoute.withName(
                                    AppRoutes.V1_DASHBOARD)),
                            Get.back(),
                            Get.back(),
                            IZIAlert.success(message: 'Phản hồi dịch vụ thất bại'),
                          }
                        else
                          {IZIAlert.error(message: 'Vui lòng thực hiện lại')}
                      });
                }
            });
  }


  void toPayment() {
    danhSachBaoGiaDonDichVuProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idDonDichVu=${donDichVu!.id}&sortBy=created_at:desc',
        onSuccess: (donBaoGia) {
          if (donBaoGia.isNotEmpty) {
            donPhanHoi = donBaoGia.where((element) => element.idTaiKhoanBaoGia!.id! == donDichVu!.idTaiKhoanNhanDon!.id!).toList().first;
            donDichVu!.soTien = donPhanHoi!.giaBao;
            donDichVu!.tongDon = donPhanHoi!.tongTien;
            tinhTien();
          }
        },
        onError: (onError) {
          print("V1BuildOrderFeedBackController getJobMass onError $onError");
        });
  }

}
