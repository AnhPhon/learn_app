import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/helper/izi_alert.dart';

class ShippingAddressController extends GetxController {
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

  //title appbar
  String title = "Địa điểm nhận hàng";

  //loading
  bool isLoading = true;

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
  void mappingAddress() {
    if (donHangResponse != null) {
      getTinhTp();
      getQuanHuyen(
          idTinhTp: donHangResponse!.idTinhTp!.id.toString(), isFisrt: true);
      if (donHangResponse!.idPhuongXa != null) {
        getPhuongXa(
          idQuanHuyen: donHangResponse!.idQuanHuyen!.id.toString(),
          isFisrt: true,
        );
      } else {
        isLoading = false;
        update();
      }
      addressController.text = donHangResponse!.diaChi.toString();
    }
  }

  ///
  ///get TinhTp
  ///
  void getTinhTp() {
    //get TinhTp
    tinhTpProvider.all(
      onSuccess: (data) {
        tinhTpList = data;

        //mapping
        tinhTpResponse = tinhTpList[tinhTpList.indexWhere(
            (element) => element.id == donHangResponse!.idTinhTp!.id)];

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

        //mapping
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

        //mapping
        if (donHangResponse != null && isFisrt == true) {
          phuongXaResponse = phuongXaList[phuongXaList.indexWhere(
              (element) => element.id == donHangResponse!.idPhuongXa!.id)];
        }
        isLoading = false;
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
      IZIAlert.error(message: 'Vui lòng chọn tỉnh/thành phố');
      return;
    } else if (quanHuyenResponse == null) {
      IZIAlert.error(message: 'Vui lòng chọn quận/huyện');
      return;
    } else if (phuongXaResponse == null && phuongXaList.isNotEmpty) {
      IZIAlert.error(message: 'Vui lòng chọn phường/xã');
      return;
    } else if (addressController.text.isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập địa chỉ cụ thể');
      return;
    } else {
      //loading
      EasyLoading.show(status: 'loading...');

      //set data
      donHangRequest.id = donHangResponse!.id;
      donHangRequest.diaChi = addressController.text;
      if (phuongXaResponse != null) {
        donHangRequest.idPhuongXa = phuongXaResponse!.id;
      } else {
        donHangRequest.idPhuongXa = null;
      }
      donHangRequest.idQuanHuyen = quanHuyenResponse!.id;
      donHangRequest.idTinhTp = tinhTpResponse!.id;

      //update address
      donHangProvider.update(
        data: donHangRequest,
        onSuccess: (data) {
          EasyLoading.dismiss();
          Get.back(result: true);
          IZIAlert.success(message: 'Cập nhật địa chỉ thành công');
        },
        onError: (error) {
          print("V1ShippingAddressController updateAddress onError $error");
        },
      );
    }
  }
}
