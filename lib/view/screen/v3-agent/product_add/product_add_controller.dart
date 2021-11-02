import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/nhap_kho_hang_dai_ly_request.dart';
import 'package:template/data/model/request/san_pham_request.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/loai_van_chuyen_response.dart';
import 'package:template/data/model/response/nhap_kho_hang_dai_ly_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/loai_van_chuyen_provider.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V3ProductAddController extends GetxController {
  //image
  File? image;
  List<File> imageList = [];

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  List<String> urlImage = [];

  //SanPham
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  SanPhamRequest sanPhamRequest = SanPhamRequest();

  //DanhMucSanPham
  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();
  List<DanhMucSanPhamResponse> danhMucSanPhamList = [];
  DanhMucSanPhamResponse? danhMucSanPhamResponse;

  //nhapKhoDaiLy
  NhapKhoHangDaiLyProvider nhapKhoHangDaiLyProvider =
      GetIt.I.get<NhapKhoHangDaiLyProvider>();
  NhapKhoHangDaiLyResponse? nhapKhoHangDaiLyResponse =
      NhapKhoHangDaiLyResponse();
  NhapKhoHangDaiLyRequest nhapKhoHangDaiLyRequest = NhapKhoHangDaiLyRequest();

  //TextEditingController
  TextEditingController name = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController quyCach = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController unit = TextEditingController();

  //userId
  String userId = "";

  //loading
  bool isLoading = true;

  //title appbar
  String title = "Thêm sản phẩm";

  @override
  void onInit() {
    super.onInit();
    getLoadData();
  }

  @override
  void onClose() {
    name.dispose();
    branch.dispose();
    price.dispose();
    code.dispose();
    quyCach.dispose();
    detail.dispose();
    unit.dispose();
    super.onClose();
  }

  ///
  ///get LoadData
  ///
  Future<void> getLoadData() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //getProductCategory
    getProductCategory();

    isLoading = false;
    update();
  }

  ///
  ///onchanged ShippingMethod
  ///
  void onchangedShippingMethod(String? value) {
    sanPhamRequest.kieuVanChuyen = value;
    update();
  }

  ///
  ///get product category
  ///
  void getProductCategory() {
    danhMucSanPhamProvider.all(
      onSuccess: (value) {
        danhMucSanPhamList = value;
        update();
      },
      onError: (error) {
        print("V3ProductAddController getProductCategory onError $error");
      },
    );
  }

  ///
  ///onchanged ProductCategory
  ///
  void onchangedProductCategory(DanhMucSanPhamResponse? value) {
    danhMucSanPhamResponse = value;
    update();
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
      uploadImage(image: imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required File image}) {
    imageUpdateProvider.add(
      file: image,
      onSuccess: (value) {
        urlImage.add(value.data.toString());
      },
      onError: (error) {
        print("V3StoreInfomationController uploadImage onError $error");
      },
    );
  }

  ///
  ///add
  ///
  void btnAdd(BuildContext context, {bool? isUpdateAndAdd = false}) {
    //validate
    if (urlImage.isEmpty) {
      Alert.error(message: 'Hình ảnh sản phẩm không được để trống');
    } else if (name.text.isEmpty) {
      Alert.error(message: 'Tên sản phẩm không được để trống');
    } else if (branch.text.isEmpty) {
      Alert.error(message: 'Thương hiệu sản phẩm không được để trống');
    } else if (price.text.isEmpty) {
      Alert.error(message: 'Giá sản phẩm không được để trống');
    } else if (code.text.isEmpty) {
      Alert.error(message: 'Mã sản phẩm không được để trống');
    } else if (quyCach.text.isEmpty) {
      Alert.error(message: 'Quy cách không được để trống');
    } else if (detail.text.isEmpty) {
      Alert.error(message: 'Chi tiết sản phẩm không được để trống');
    } else if (danhMucSanPhamResponse == null) {
      Alert.error(message: 'Bạn chưa chọn danh mục sản phẩm');
    } else if (unit.text.isEmpty) {
      Alert.error(message: 'Số lượng không được để trống');
    } else {
      //set data
      sanPhamRequest.hinhAnhDaiDien = urlImage[0];
      sanPhamRequest.hinhAnhSanPhams = urlImage;
      sanPhamRequest.ten = name.text;
      sanPhamRequest.thuongHieu = branch.text;
      sanPhamRequest.gia = price.text.replaceAll(",", "");
      sanPhamRequest.maSanPham = code.text;
      sanPhamRequest.quyCach = quyCach.text;
      sanPhamRequest.moTa = detail.text;
      sanPhamRequest.idDanhMucSanPham = danhMucSanPhamResponse!.id;
      sanPhamRequest.donVi = unit.text;
      sanPhamRequest.idTaiKhoan = userId;

      //add product
      sanPhamProvider.add(
        data: sanPhamRequest,
        onSuccess: (sanPham) {
          //set data
          nhapKhoHangDaiLyRequest.idSanPham = sanPham.id;

          //nhapKho
          nhapKhoHangDaiLyProvider.add(
            data: nhapKhoHangDaiLyRequest,
            onSuccess: (nhapKhoHangDaiLyAdd) {
              if (isUpdateAndAdd == false) {
                Get.offNamed(AppRoutes.V3_STORE);
              }
              Alert.success(message: 'Thêm sản phẩm thành công');
            },
            onError: (error) {
              print(
                  "V3ProductAddController nhapKhoHangDaiLyAdd onError $error");
            },
          );
        },
        onError: (error) {
          print("V3ProductAddController sanPhamAdd onError $error");
        },
      );
    }
  }

  ///
  ///btn update and add
  ///
  void btnUpdateAndAdd(BuildContext context) {
    btnAdd(context, isUpdateAndAdd: true);
    imageList.clear();
    urlImage.clear();
    name.clear();
    branch.clear();
    price.clear();
    code.clear();
    quyCach.clear();
    detail.clear();
    unit.clear();
    danhMucSanPhamResponse = null;
    sanPhamRequest.kieuVanChuyen = null;
    update();
  }
}
