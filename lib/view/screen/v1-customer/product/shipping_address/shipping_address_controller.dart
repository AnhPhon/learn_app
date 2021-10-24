import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V1ShippingAddressController extends GetxController {
  //TextEditingController
  final addressController = TextEditingController();

  //DonHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangRequest donHangRequest = DonHangRequest();
  DonHangResponse? donHangResponse;

  //tinhTp
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  List<TinhTpResponse> tinhTpList = [];
  TinhTpResponse? tinhTpResponse;

  //QuanHuyen
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get();
  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyenResponse;

  //PhuongXa
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse> phuongXaList = [];
  PhuongXaResponse? phuongXaResponse;

  //userId
  String userId = "";

  //title appbar
  String title = "Địa điểm nhận hàng";

  @override
  void onInit() {
    super.onInit();
    donHangResponse =
        (Get.arguments != null) ? Get.arguments as DonHangResponse : null;
    mappingAddress();
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }

  ///
  ///mapping address
  ///
  Future<void> mappingAddress() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    if (donHangResponse != null) {
      getTinhTp(isFisrt: true);
      getQuanHuyen(
          idTinhTp: donHangResponse!.idTinhTp!.id.toString(), isFisrt: true);
      getPhuongXa(
          idQuanHuyen: donHangResponse!.idQuanHuyen!.id.toString(),
          isFisrt: true);
      addressController.text = donHangResponse!.diaChi.toString();
    } else {
      getTinhTp();
    }
  }

  ///
  ///get TinhTp
  ///
  void getTinhTp({bool? isFisrt = false}) {
    //get TinhTp
    tinhTpProvider.all(
      onSuccess: (data) {
        tinhTpList = data;

        if (donHangResponse != null && isFisrt == true) {
          tinhTpResponse = tinhTpList[tinhTpList.indexWhere(
              (element) => element.id == donHangResponse!.idTinhTp!.id)];
        }
        update();
      },
      onError: (error) {
        print("V1ProductDetailController getTinhTp onError $error");
      },
    );
  }

  ///
  ///get QuanHuyen
  ///
  void getQuanHuyen({required String idTinhTp, bool? isFisrt = false}) {
    //get QuanHuyen
    quanHuyenProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTinhTp=$idTinhTp",
      onSuccess: (data) {
        quanHuyenList = data;
        if (donHangResponse != null && isFisrt == true) {
          quanHuyenResponse = quanHuyenList[quanHuyenList.indexWhere(
              (element) => element.id == donHangResponse!.idQuanHuyen!.id)];
        }
        update();
      },
      onError: (error) {
        print("V1ProductDetailController getQuanHuyen onError $error");
      },
    );
  }

  ///
  ///get PhuongXa
  ///
  void getPhuongXa({required String idQuanHuyen, bool? isFisrt = false}) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idQuanHuyen=$idQuanHuyen",
      onSuccess: (data) {
        phuongXaList = data;
        if (donHangResponse != null && isFisrt == true) {
          phuongXaResponse = phuongXaList[phuongXaList.indexWhere(
              (element) => element.id == donHangResponse!.idPhuongXa!.id)];
        }
        update();
      },
      onError: (error) {
        print("V1ProductDetailController getQuanHuyen onError $error");
      },
    );
  }

  ///
  ///set selected TinhTp
  ///
  void setSelectedTinhTp(TinhTpResponse? value) {
    tinhTpResponse = value;
    //clear list
    quanHuyenResponse = null;
    phuongXaResponse = null;
    quanHuyenList.clear();
    phuongXaList.clear();
    getQuanHuyen(idTinhTp: tinhTpResponse!.id.toString());
    update();
  }

  ///
  ///set selected QuanHuyen
  ///
  void setSelectedQuanHuyen(QuanHuyenResponse? value) {
    quanHuyenResponse = value;
    //clear list
    phuongXaResponse = null;
    phuongXaList.clear();
    getPhuongXa(idQuanHuyen: quanHuyenResponse!.id.toString());
    update();
  }

  ///
  ///set selected PhuongXa
  ///
  void setSelectedPhuongXa(PhuongXaResponse? value) {
    phuongXaResponse = value;
    update();
  }

  ///
  ///update
  ///
  void updateAddress(BuildContext context) {
    //validate
    if (tinhTpResponse == null) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng chọn tỉnh/thành phố",
      );
    } else if (quanHuyenResponse == null) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng chọn quận/huyện",
      );
    } else if (phuongXaResponse == null) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng chọn phường/xã",
      );
    } else if (addressController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Vui lòng nhập địa chỉ cụ thể",
      );
    } else {
      //loading
      EasyLoading.show(status: 'loading...');

      //set data
      donHangRequest.id = donHangResponse!.id;
      donHangRequest.diaChi = addressController.text;
      donHangRequest.idPhuongXa = phuongXaResponse!.id;
      donHangRequest.idQuanHuyen = quanHuyenResponse!.id;
      donHangRequest.idTinhTp = tinhTpResponse!.id;

      //update address
      donHangProvider.update(
        data: donHangRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          Get.back(result: true);
          showAnimatedDialog(
            context,
            const MyDialog(
              icon: Icons.check,
              title: "Hoàn tất",
              description: "Cập nhật địa chỉ thành công",
            ),
            dismissible: false,
            isFlip: true,
          );
        },
        onError: (error) {
          print("V1ShippingAddressController updateAddress onError $error");
        },
      );
    }
  }
}
