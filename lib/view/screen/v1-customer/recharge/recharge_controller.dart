import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/lich_su_vi_tien_request.dart';
import 'package:template/data/model/response/thong_tin_ngan_hang_response.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/lich_su_vi_tien_provider.dart';
import 'package:template/provider/thong_tin_ngan_hang_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V1RechargeController extends GetxController {
  File? image;
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  ThongTinNganHangProvider thongTinNganHangProvider =
      GetIt.I.get<ThongTinNganHangProvider>();
  ThongTinNganHangResponse thongTinNganHangResponse =
      ThongTinNganHangResponse();

  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  ViTienResponse viTienResponse = ViTienResponse();

  LichSuViTienProvider lichSuViTienProvider =
      GetIt.I.get<LichSuViTienProvider>();
  LichSuViTienRequest lichSuViTienRequest = LichSuViTienRequest();

  String title = "Thông tin thanh toán";

  String userId = "";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getBankInfomation();
  }

  ///
  ///get bank infomation
  ///
  Future<void> getBankInfomation() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    thongTinNganHangProvider.all(
      onSuccess: (value) {
        thongTinNganHangResponse = value.first;

        //get wallet
        viTienProvider.paginate(
          page: 1,
          limit: 5,
          filter: "&idTaiKhoan=$userId",
          onSuccess: (wallet) {
            viTienResponse = wallet.first;
            isLoading = false;
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///copy
  ///
  void onBtnCopyClick({required bool content}) {
    if (content) {
      Clipboard.setData(const ClipboardData(text: "FSS68686868"));
    } else {
      Clipboard.setData(
          ClipboardData(text: thongTinNganHangResponse.soTaiKhoan));
    }
    Get.showSnackbar(GetBar(
      message: "Copied",
      backgroundColor: ColorResources.BLACK.withOpacity(.3),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1000),
    ));
  }

  ///
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///on checkout click
  ///
  void onCheckoutClick() {
    //show loading
    EasyLoading.show(status: 'loading...');

    //validate
    if (image == null) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Lỗi", // title
        "Vui lòng tải lên hình ảnh thanh toán", // message
        icon: const Icon(Icons.error_outline),
        backgroundColor: const Color(0xffFFCDD2),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
    } else {
      imageUpdateProvider.add(
        file: image!,
        onSuccess: (image) {
          //set data
          lichSuViTienRequest.idTaiKhoan = userId;
          lichSuViTienRequest.idViTien = viTienResponse.id;
          lichSuViTienRequest.noiDung = "Nạp tiền vào ví";
          lichSuViTienRequest.loaiGiaoDich = "1";
          lichSuViTienRequest.soTien = Get.parameters['amountOfMoney'];
          lichSuViTienRequest.hinhAnhHoaDon = image.data;
          lichSuViTienRequest.trangThai = "1";

          //add
          lichSuViTienProvider.add(
            data: lichSuViTienRequest,
            onSuccess: (value) {
              //go to payment success page
              EasyLoading.dismiss();
              Get.toNamed(
                  "${AppRoutes.V1_PAYMENT_SUCCESS}?isBuy=${Get.parameters['isBuy']}&isInsurance=${Get.parameters['isInsurance']}");
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
        },
        onError: (error) {},
      );
    }
  }
}
