// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_it/get_it.dart';
// import 'package:template/data/model/request/don_dich_vu_request.dart';
// import 'package:template/data/repository/don_dich_vu_repository.dart';
// import 'package:template/provider/chi_tiet_cong_viec_provider.dart';
// import 'package:template/provider/don_dich_vu_provider.dart';
// import 'package:template/routes/app_routes.dart';
// import 'package:template/utils/alert.dart';
// import 'package:template/utils/app_constants.dart';
// import 'package:template/utils/color_resources.dart';
// import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';
//
// class V2_3FormalPaymentController extends GetxController {
//   DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
//   DonDichVuRepository donDichVuRepository = GetIt.I.get<DonDichVuRepository>();
//   ChiTietCongViecProvider chiTietCongViecProvider = GetIt.I.get<ChiTietCongViecProvider>();
//   DonDichVuRequest? dichVuRequest;
//
//   int formalPaymentGroup = 0;
//   double soTien = 0;
//   double thanhToan = 0;
//
//   @override
//   void onInit() {
//     dichVuRequest = Get.arguments as DonDichVuRequest;
//     tinhTien();
//     super.onInit();
//   }
//
//   void tinhTien() {
//     if (dichVuRequest != null) {
//       soTien = double.parse(dichVuRequest!.soTien!);
//       //phiDichVu = double.parse(dichVuRequest!.phiDichVu!);
//       if (formalPaymentGroup == 0) {
//         thanhToan = soTien;
//       } else {
//         thanhToan = soTien * 10 / 100;
//       }
//     }
//   }
//
//   ///
//   /// change formal payment
//   ///
//   void onChangedFormalPayment(int val) {
//     formalPaymentGroup = val;
//     tinhTien();
//     update();
//   }
//
//   void showDialogAccept() {
//     Get.defaultDialog(
//         title: "Xác nhận thông tin",
//         content: DialogContentPriceAccept(
//           textContent: 'Bạn chắc chắn đồng ý thanh toán',
//           price: thanhToan,
//         ),
//         confirm: ElevatedButton(
//             onPressed: () {
//               onClickContinueButton();
//             },
//             child: const Text("Đồng ý")),
//         cancel: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: ColorResources.GREY,
//             ),
//             onPressed: () {
//               Get.back();
//             },
//             child: const Text("Hủy")));
//   }
//
//   void onClickContinueButton() {
//     double tienCoc = 0;
//     Get.toNamed('${AppRoutes.ORDER_INFORMATION}?soTien=$thanhToan&tienCoc=$tienCoc&noiDung=Thanh toán đơn dịch vụ')!.then((value) {
//       //đã thanh toán
//       if (value != null && value['type'] == 1) {
//         //set trạng thái đã thanh toán
//         if (formalPaymentGroup == 0) {
//           dichVuRequest!.idTrangThaiThanhToanKhac = DAT_COT;
//         } else {
//           dichVuRequest!.idTrangThaiThanhToanKhac = DA_THANH_TOAN;
//         }
//         dichVuRequest!.idTrangThaiDonDichVu = DON_DICH_VU_TRUNG_THAU;
//         //insert db
//         donDichVuRepository.update(dichVuRequest!).then((value) {
//           if (value.response.data != null) {
//             Get.back(result: true);
//             Alert.success(message: 'Tạo đơn thành công');
//           } else
//             Alert.error(message: 'Vui lòng thực hiện lại');
//         });
//       } else {
//         Get.back();
//         Alert.error(message: 'Thanh toán thất bại');
//       }
//     });
//   }
// }