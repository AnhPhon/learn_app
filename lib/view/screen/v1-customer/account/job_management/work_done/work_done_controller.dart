import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/request/yeu_cau_bao_hanh_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/yeu_cau_bao_hanh_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/yeu_cau_bao_hanh_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class V1WorkDoneController extends GetxController {
  //TextEditingController
  final customerOpinionController = TextEditingController();
  final warrantyClaimsContentController = TextEditingController();
  final evaluateController = TextEditingController();

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //donDichVu
  DonDichVuResponse donDichVuResponse = DonDichVuResponse();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  //PhanHoiDonDichVu
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();
  PhanHoiDonDichVuRequest phanHoiDonDichVuRequest = PhanHoiDonDichVuRequest();

  //YeuCauBaoHanh
  YeuCauBaoHanhProvider yeuCauBaoHanhProvider =
      GetIt.I.get<YeuCauBaoHanhProvider>();
  YeuCauBaoHanhRequest yeuCauBaoHanhRequest = YeuCauBaoHanhRequest();
  YeuCauBaoHanhRequest danhGiaBaoHanhRequest = YeuCauBaoHanhRequest();
  List<YeuCauBaoHanhResponse> yeuCauBaoHanhList = [];
  List<TextEditingController> yeuCauControllerList = [];
  List<YeuCauBaoHanhResponse> thucHienBaoHanhList = [];
  List<TextEditingController> danhGiaControllerList = [];

  //index
  int indexTinhTrang = 0;

  //title appbar
  String title = "Việc đã làm";

  //user id
  String userId = '';

  //loading
  bool isLoading = true;

  //isClicked
  bool isClickedContent = false;
  bool isClickedRequest = false;
  bool isClickedDone = false;

  @override
  void onInit() {
    super.onInit();
    //get arguments
    if (Get.arguments != null) {
      donDichVuResponse = Get.arguments as DonDichVuResponse;
      phanHoiDonDichVuRequest.idYeuCauBaoHanhs = [];
      getUserId().then((value) {
        getPhanHoiDonDichVu();
      });
    }
  }

  @override
  void onClose() {
    customerOpinionController.dispose();
    warrantyClaimsContentController.dispose();
    evaluateController.dispose();
    super.onClose();
  }

  ///
  ///get user id
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///PhanHoiDonDichVu
  ///
  void getPhanHoiDonDichVu() {
    phanHoiDonDichVuProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idDonDichVu=${donDichVuResponse.id}",
      onSuccess: (data) {
        //check is notempty
        if (data.isNotEmpty) {
          phanHoiDonDichVuRequest.id = data.first.id;

          //set yKienThoThau
          if (data.first.yKienThoThauViecDaLam != "null") {
            phanHoiDonDichVuRequest.yKienThoThauViecDaLam =
                data.first.yKienThoThauViecDaLam;
          }

          //mapping tinh trang thanh toan
          if (data.first.tinhTrangThanhToan != "null") {
            indexTinhTrang = int.parse(data.first.tinhTrangThanhToan!) - 1;
          }

          // mapping khachHangDanhGia
          if (data.first.khachHangDanhGiaViecDaLam != "null") {
            customerOpinionController.text =
                data.first.khachHangDanhGiaViecDaLam!;
            phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam =
                data.first.khachHangDanhGiaViecDaLam;
          }
          yeuCauBaoHanhList.clear();
          thucHienBaoHanhList.clear();
          yeuCauControllerList.clear();
          danhGiaControllerList.clear();
          final List<YeuCauBaoHanhResponse> thucHienList = [];

          // mapping warrantyClaims
          if (data.first.idYeuCauBaoHanhs!.isNotEmpty) {
            phanHoiDonDichVuRequest.idYeuCauBaoHanhs = data
                .first.idYeuCauBaoHanhs!
                .map((e) => e.id.toString())
                .toList();
            for (final item in data.first.idYeuCauBaoHanhs!) {
              yeuCauBaoHanhList.addIf(item.loai == "1", item);
              thucHienList.addIf(item.loai == "2", item);

              if (item.id == data.first.idYeuCauBaoHanhs!.last.id) {
                thucHienBaoHanhList = List.generate(
                    yeuCauBaoHanhList.length, (_) => YeuCauBaoHanhResponse());
                yeuCauControllerList = List.generate(
                    yeuCauBaoHanhList.length, (_) => TextEditingController());
                danhGiaControllerList = List.generate(
                    yeuCauBaoHanhList.length, (_) => TextEditingController());
                if (thucHienList.isNotEmpty) {
                  for (var i = 0; i < thucHienList.length; i++) {
                    thucHienBaoHanhList[i] = thucHienList[i];
                    if (i == thucHienList.length - 1) {
                      isLoading = false;
                      update();
                    }
                  }
                } else {
                  isLoading = false;
                  update();
                }
              }
            }
          } else {
            isLoading = false;
            update();
          }
        } else {
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print("V1WorkDoneController getPhanHoiDonDichVu onError $error");
      },
    );
  }

  ///
  ///set selected index
  ///
  void setSelectedIndexFee(int? index) {
    indexTinhTrang = index!;
    update();
  }

  ///
  ///btn Opinion Send
  ///
  void onBtnOpinionSend() {
    if (isClickedContent) {
      return;
    } else {
      //validate
      if (customerOpinionController.text.isEmpty) {
        Alert.error(
            message:
                'Vui lòng nhập đánh giá/ý kiến, nếu không có ý kiến thì nhập "không"');
      } else {
        isClickedContent = true;
        //set data
        phanHoiDonDichVuRequest.tinhTrangThanhToan =
            (indexTinhTrang + 1).toString();
        phanHoiDonDichVuRequest.khachHangDanhGiaViecDaLam =
            customerOpinionController.text;

        //update
        phanHoiDonDichVuProvider.update(
          data: phanHoiDonDichVuRequest,
          onSuccess: (data) {
            //chuyen trang thai
            donDichVuProvider.update(
              data: DonDichVuRequest(
                id: donDichVuResponse.id,
                idTrangThaiDonDichVu: DA_NGHIEM_THU,
              ),
              onSuccess: (success) {
                Alert.success(message: "Gửi đánh giá/ý kiến thành công");
              },
              onError: (error) {
                print("V1WorkDoneController onBtnOpinionSend onError $error");
              },
            );
            getPhanHoiDonDichVu();
          },
          onError: (error) {
            print("V1WorkDoneController onBtnOpinionSend onError $error");
          },
        );
      }
    }
  }

  ///
  ///pick image
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      uploadImage(images: files);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required List<File> images}) {
    imageUpdateProvider.addImages(
      files: images,
      onSuccess: (value) {
        if (value.files != null && value.files!.isNotEmpty) {
          yeuCauBaoHanhRequest.hinhAnhs = value.files;
        }
        EasyLoading.dismiss();
        update();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print("V3StoreInfomationController uploadImage onError $error");
      },
    );
  }

  ///
  ///btn warrantyClaims send
  ///
  void onBtnWarrantyClaimsSend() {
    if (isClickedRequest) {
      return;
    } else {
      //validate
      if (warrantyClaimsContentController.text.isEmpty) {
        Alert.error(message: "Vui lòng nhập nội dung yêu cầu bảo hành");
      } else {
        isClickedRequest = true;
        //set data
        yeuCauBaoHanhRequest.noiDung = warrantyClaimsContentController.text;
        yeuCauBaoHanhRequest.loai = "1";

        //create yeuCauBaoHanh
        yeuCauBaoHanhProvider.add(
          data: yeuCauBaoHanhRequest,
          onSuccess: (data) {
            //set data
            phanHoiDonDichVuRequest.idYeuCauBaoHanhs!.add(data.id!);

            //update phanHoiDonDichVu
            phanHoiDonDichVuProvider.update(
              data: phanHoiDonDichVuRequest,
              onSuccess: (data) {
                Alert.success(message: "Gửi yêu cầu bảo hành thành công");
                getPhanHoiDonDichVu();
              },
              onError: (error) {
                print("V1WorkDoneController onBtnOpinionSend onError $error");
              },
            );

            update();
          },
          onError: (error) {
            print(
                "V3StoreInfomationController onBtnWarrantyClaimsSend onError $error");
          },
        );
      }
    }
  }

  ///
  ///on btn evaluate send
  ///
  void onBtnEvaluateSend(int index) {
    if (isClickedDone) {
      return;
    } else {
      //validate
      if (danhGiaControllerList[index].text.isEmpty) {
        Alert.error(
            message:
                'Vui lòng đánh giá công tác bảo hành, nếu không có thì nhập "không"');
      } else {
        isClickedDone = true;
        //set data
        danhGiaBaoHanhRequest.danhGiaBaoHanh =
            danhGiaControllerList[index].text;
        danhGiaBaoHanhRequest.id = thucHienBaoHanhList[index].id;

        //create yeuCauBaoHanh
        yeuCauBaoHanhProvider.update(
          data: danhGiaBaoHanhRequest,
          onSuccess: (data) {
            Alert.success(message: "Gửi đánh giá bảo hành thành công");

            getPhanHoiDonDichVu();

            update();
          },
          onError: (error) {
            print(
                "V3StoreInfomationController onBtnEvaluateSend onError $error");
          },
        );
      }
    }
  }
}
