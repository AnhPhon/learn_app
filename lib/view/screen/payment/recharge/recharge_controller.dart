import 'dart:io';
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
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

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
  String? image;

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

  //isClicked
  bool isClicked = false;

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
          limit: 10,
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

    IZIAlert.success(message: 'Copy $content thành công');
  }

  ///
  ///onChangeRadio
  ///
  void onChangeRadio(int value) {
    selected = value;
    update();
  }

  ///
  /// Pick HinhDaiDien
  ///
  Future pickHinhHoaDon() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');

      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            image = value.files![0];
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          IZIAlert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
    }
  }

  ///
  ///on checkout click
  ///
  void onCheckoutClick() {
    if (isClicked) {
      return;
    } else {
      //validate
      if (image == null) {
        IZIAlert.error(message: 'Vui lòng tải hình ảnh hóa đơn giao dịch');
      } else {
        isClicked = true;
        //show loading
        EasyLoading.show(status: 'loading...');

        //set data
        lichSuViTienRequest.idTaiKhoan = userId;
        lichSuViTienRequest.idViTien = viTienResponse.id;
        lichSuViTienRequest.noiDung = "Nạp tiền vào ví";
        lichSuViTienRequest.loaiGiaoDich = "1";
        lichSuViTienRequest.soTien = soTienToiThieu.toString();
        lichSuViTienRequest.hinhAnhHoaDon = image;
        lichSuViTienRequest.trangThai = "1";
        // lichSuViTienRequest.type = '0';

        final Map<String, dynamic> param = {
          'type': 2,
          'status': true,
          'hinhAnhHoaDon': image
        };
        //add
        lichSuViTienProvider.add(
          data: lichSuViTienRequest,
          onSuccess: (value) {
            //go to payment success page
            EasyLoading.dismiss();
            Get.toNamed('${AppRoutes.PAYMENT_SUCCESS}?isPayment=1')!
                .then((value) => {
                      if (value == true) {Get.back(result: param)}
                    });
          },
          onError: (error) {
            print("RechargeController onCheckoutClick onError $error");
          },
        );
      }
    }
  }
}
