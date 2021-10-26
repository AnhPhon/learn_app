import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/lich_su_vi_tien_request.dart';
import 'package:template/data/model/request/vi_tien_request.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/data/repository/lich_su_vi_tien_repository.dart';
import 'package:template/data/repository/vi_tien_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

import 'patment_dialog_accept.dart';

class PaymentAccountController extends GetxController {
  //Provider
  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  //Reponse
  ViTienResponse viTienResponse = ViTienResponse();

  //update ví tiền
  ViTienRepository viTienRepository = ViTienRepository();

  //value ViTienRequest
  ViTienRequest viTienRequest = ViTienRequest();

  //lichSuViTien
  LichSuViTienRequest lichSuViTienRequest = LichSuViTienRequest();
  LichSuViTienRepository lichSuViTienRepository = LichSuViTienRepository();

  String title = "Tài khoản của bạn";

  //isLoading
  bool isLoading = true;

  //value tổng tiền thanh toán
  double tongTienThanhToan = 0;
  double soDuTaiKhoan = 0;
  double soDuConLai = 0;

  //isShow
  bool isShowSoDu = false;

  //check urlBlack

  //url Back
  String? urlBack;
  //userId
  String? userId;

  @override
  void onInit() {
    super.onInit();
    //reset value
    tongTienThanhToan = 0;
    soDuTaiKhoan = 0;
    soDuConLai = 0;
    //set data
    if (Get.parameters['tongTien'] != null) {
      tongTienThanhToan = double.parse(Get.parameters['tongTien'].toString());
      getBalance();
    }
    //check url
    if (Get.parameters['url'] != null) {
      urlBack = Get.parameters['url'].toString();
    }
    update();
  }

  ///
  ///get balance
  ///
  void getBalance() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;

      viTienProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idTaiKhoan=$userId",
        onSuccess: (value) {
          viTienResponse = value.first;
          soDuTaiKhoan = double.parse(viTienResponse.tongTien.toString());

          //check số dư tài khoản có đủ không
          if ((soDuTaiKhoan - tongTienThanhToan) < 0) {
            soDuConLai = 0;
            isShowSoDu = true;
          } else {
            soDuConLai = soDuTaiKhoan - tongTienThanhToan;
            isShowSoDu = false;
          }

          //set
          isLoading = false;
          update();
        },
        onError: (error) {
          print("PaymentAccountController getBalance onError $error");
        },
      );
    });
  }

  ///
  ///dialog button back
  ///
  void showDialogBack() {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        contentPadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        title: "Bạn có chắc chắn muốn quay lại không?",
        content: PaymentDialogAccept(
          textContent:
              'Bấm nút hủy tạo đơn để hủy tạo đơn, nút trở lại để thoát',
          price: 0,
          isShowPrice: false,
        ),
        confirm: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Trở lại")),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorResources.GREY,
            ),
            onPressed: () {
              Get.back();
              Get.offAllNamed(urlBack!,
                  predicate: ModalRoute.withName(urlBack!));
            },
            child: const Text("Hủy tạo đơn")));
  }

  ///
  ///  Hiển thị xác nhận
  ///
  void showDialogAccept() {
    Get.defaultDialog(
        title: "Xác nhận thông tin",
        content: PaymentDialogAccept(
          textContent: 'Bạn đồng ý thanh toán với số tiền',
          price: tongTienThanhToan,
        ),
        confirm: ElevatedButton(
            onPressed: () {
              //set value viTienRequest
              viTienRequest.id = viTienResponse.id;
              viTienRequest.idTaiKhoan =
                  viTienResponse.idTaiKhoan!.id.toString();
              viTienRequest.tongTien = soDuConLai.toString();
              EasyLoading.show(status: 'loading...');

              viTienRepository.update(viTienRequest).then((value) {
                //update ví tiền thành công
                if (value.response.data != null) {
                  //set data lịch sử ví tiền
                  lichSuViTienRequest.idTaiKhoan = userId;
                  lichSuViTienRequest.idViTien = viTienResponse.id;
                  lichSuViTienRequest.noiDung = "Thanh toán thành công";
                  lichSuViTienRequest.loaiGiaoDich = "2";
                  lichSuViTienRequest.trangThai = "2";
                  lichSuViTienRequest.soTien = tongTienThanhToan.toString();

                  //insert db lịch sử ví tiền
                  lichSuViTienRepository.add(lichSuViTienRequest).then((value) {
                    if (value.response.data != null) {
                      EasyLoading.dismiss();
                      Get.toNamed('${AppRoutes.PAYMENT_SUCCESS}?isPayment=0')!
                          .then((value) {
                        if (value == true) {
                          Get.back();
                          Get.back(result: true);
                        }
                      });
                    } else {
                      Alert.error(message: 'Vui lòng thực hiện lại');
                    }
                  });
                } else {
                  Alert.error(message: 'Vui lòng thực hiện lại');
                }
              });
            },
            child: const Text("Đồng ý")),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorResources.GREY,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("Hủy")));
  }

  ///
  ///go to recharge
  ///
  void onRechargeClick() {
    Get.toNamed(
            '${AppRoutes.PAYMENT_RECHARGE}?soTienToiThieu=$tongTienThanhToan')!
        .then((value) {
      if (value == true) {
        Get.back(result: false);
      }
    });
  }
}
