import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/san_pham_request.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/upload_image_provider.dart';

class V3ProductAddController extends GetxController {
  //image
  File? image;
  List<File> imageList = [];
  List<String> urlImage = [];

  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  SanPhamRequest sanPhamRequest = SanPhamRequest();

  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucSanPhamResponse = [];

  List<TextEditingController> textControllerList = [];

  List<String> titleList = [
    "Tên sản phẩm",
    "Thương hiệu sản phẩm",
    "Giá sản phẩm",
    "Mã sản phẩm",
    "Quy cách",
    "Chi tiết sản phẩm",
  ];

  String title = "Thêm sản phẩm";

  @override
  void onInit() {
    super.onInit();
    textControllerList =
        List<TextEditingController>.filled(7, TextEditingController());
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
      imageList.add(imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///get product category
  ///
  void getProductCategory() {
    danhMucSanPhamProvider.all(
      onSuccess: (value) {
        danhMucSanPhamResponse = value;
        update();
      },
      onError: (error){
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///add
  ///
  void add() {
    //get link image
    for (final item in imageList) {
      imageUpdateProvider.add(
        file: item,
        onSuccess: (url) {
          urlImage.add(url.data.toString());
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }

    //set data
    sanPhamRequest.hinhAnhDaiDien = urlImage[0];
    sanPhamRequest.hinhAnhSanPham = urlImage[1];
    sanPhamRequest.ten = textControllerList[0].text;
    sanPhamRequest.thuongHieu = textControllerList[1].text;
    sanPhamRequest.gia = textControllerList[2].text;
    sanPhamRequest.maSanPham = textControllerList[3].text;
    sanPhamRequest.quyCach = textControllerList[4].text;
    sanPhamRequest.moTa = textControllerList[5].text;
    // sanPhamRequest.soLuongTonKho = textControllerList[6].text; (chua co)
    // sanPhamRequest.tinhTrangSanPham = (chua co)

    //add
    sanPhamProvider.add(
      data: sanPhamRequest,
      onSuccess: (value) {},
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }
}
