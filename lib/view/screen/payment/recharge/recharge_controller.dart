import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/lich_su_vi_tien_request.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/thong_tin_ngan_hang_response.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/lich_su_vi_tien_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/thong_tin_ngan_hang_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/snack_bar.dart';

class RechargeController extends GetxController {
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  ThongTinNganHangProvider thongTinNganHangProvider =
      GetIt.I.get<ThongTinNganHangProvider>();
  List<ThongTinNganHangResponse> thongTinNganHangResponse = [];

  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  ViTienResponse viTienResponse = ViTienResponse();

  LichSuViTienProvider lichSuViTienProvider =
      GetIt.I.get<LichSuViTienProvider>();
  LichSuViTienRequest lichSuViTienRequest = LichSuViTienRequest();

  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //upload file
  File? image;

  //titile
  String title = "Thông tin thanh toán";

//userId
  String userId = "";

//isLoading
  bool isLoading = true;

  //value radio
  int selected = 0;

//value số tiền tối thiểu
  double soTienToiThieu = 0;

  @override
  void onInit() {
    super.onInit();
    getBankInfomation();
    //set data
    if (Get.parameters['soTienToiThieu'] != null) {
      soTienToiThieu =
          double.parse(Get.parameters['soTienToiThieu'].toString());
    }
  }

  ///
  ///get bank infomation
  ///
  Future<void> getBankInfomation() async {
    //set userid
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get thông tin tài khoản
    taiKhoanProvider.find(
        id: userId,
        onSuccess: (value) {
          taiKhoanResponse = value;
        },
        onError: (e) => print("RechargeController getBankInfomation $e"));

    //get thông tin ngân hàng
    thongTinNganHangProvider.all(
      onSuccess: (value) {
        thongTinNganHangResponse = value;

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
            print("RechargeController getBankInfomation onError $error");
          },
        );
      },
      onError: (error) {
        print("RechargeController getBankInfomation onError $error");
      },
    );
  }

  ///
  ///copy
  ///
  void onBtnCopyClick({required String content}) {
    Clipboard.setData(ClipboardData(text: content));

    SnackBarUtils.showSnackBarSuccess(
        title: 'Copy thành công', message: content);
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
  ///onChangeRadio
  ///
  void onChangeRadio(int value) {
    selected = value;
    update();
  }

  ///
  ///on checkout click
  ///
  void onCheckoutClick() async {
    //validate
    if (image == null) {
      SnackBarUtils.showSnackBar(
          title: 'Hình ảnh hóa đơn giao dịch bắt buộc',
          message: 'Vui lòng tài hình ảnh hóa đơn giao dịch');
    } else {
      //show loading
      EasyLoading.show(status: 'loading...');
      imageUpdateProvider.add(
        file: image!,
        onSuccess: (image) {
          //set data
          lichSuViTienRequest.idTaiKhoan = userId;
          lichSuViTienRequest.idViTien = viTienResponse.id;
          lichSuViTienRequest.noiDung = "Nạp tiền vào ví";
          lichSuViTienRequest.loaiGiaoDich = "1";
          lichSuViTienRequest.soTien = soTienToiThieu.toString();
          lichSuViTienRequest.hinhAnhHoaDon = image.data;
          lichSuViTienRequest.trangThai = "1";

          //add
          lichSuViTienProvider.add(
            data: lichSuViTienRequest,
            onSuccess: (value) async {
              // final Map<String, dynamic> param = {
              //   'status': true,
              //   'tongTien': soTienToiThieu
              // };
              //go to payment success page
              EasyLoading.dismiss();
              await Get.toNamed('${AppRoutes.PAYMENT_SUCCESS}?isPayment=1')!
                  .then((value) => {
                        if (value == true) {Get.back(result: true)}
                      });
            },
            onError: (error) {
              print("RechargeController onCheckoutClick onError $error");
            },
          );
        },
        onError: (error) {
          EasyLoading.showError('Vui lòng thực hiện lại');
        },
      );
    }
  }
}
