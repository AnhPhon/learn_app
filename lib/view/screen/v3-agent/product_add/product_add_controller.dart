import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/kho_hang_dai_ly_request.dart';
import 'package:template/data/model/request/nhap_kho_hang_dai_ly_request.dart';
import 'package:template/data/model/request/san_pham_request.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/loai_van_chuyen_response.dart';
import 'package:template/data/model/response/nhap_kho_hang_dai_ly_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/provider/loai_van_chuyen_provider.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';
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

  //khoHangDaiLy
  KhoHangDaiLyProvider khoHangDaiLyProvider = GetIt.I.get();
  List<KhoHangDaiLyResponse> khoHangDaiLyList = [];
  KhoHangDaiLyResponse? khoHangDaiLyResponse;
  KhoHangDaiLyRequest khoHangDaiLyRequest = KhoHangDaiLyRequest();

  //LoaiVanChuyen
  LoaiVanChuyenProvider loaiVanChuyenProvider =
      GetIt.I.get<LoaiVanChuyenProvider>();
  List<LoaiVanChuyenResponse> loaiVanChuyenList = [];
  LoaiVanChuyenResponse? loaiVanChuyenResponse;

  //TextEditingController
  TextEditingController name = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController quyCach = TextEditingController();
  TextEditingController detail = TextEditingController();
  TextEditingController stock = TextEditingController();

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
    stock.dispose();
    super.onClose();
  }

  ///
  ///get LoadData
  ///
  Future<void> getLoadData() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get khoHangDaiLy
    khoHangDaiLyProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (khoHangDaiLy) {
        khoHangDaiLyList = khoHangDaiLy;

        //getShippingMethod
        getShippingMethod();

        //getProductCategory
        getProductCategory();

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3ProductAddController getKhoHangDaiLy onError $error");
      },
    );
  }

  ///
  ///onchanged khoHangDaiLy
  ///
  void onchangedkhoHangDaiLy(KhoHangDaiLyResponse? value) {
    khoHangDaiLyResponse = value;
    update();
  }

  ///
  ///get shipping method
  ///
  void getShippingMethod() {
    loaiVanChuyenProvider.all(
      onSuccess: (value) {
        loaiVanChuyenList = value;
        update();
      },
      onError: (error) {
        print("V3ProductAddController getShippingMethod onError $error");
      },
    );
  }

  ///
  ///onchanged ShippingMethod
  ///
  void onchangedShippingMethod(LoaiVanChuyenResponse? value) {
    loaiVanChuyenResponse = value;
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
    } else if (stock.text.isEmpty) {
      Alert.error(message: 'Số lượng không được để trống');
    } else if (khoHangDaiLyResponse == null) {
      Alert.error(message: 'Bạn chưa chọn kho hàng');
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
      sanPhamRequest.idTaiKhoan = userId;

      nhapKhoHangDaiLyRequest.idKhoHangDaiLy = khoHangDaiLyResponse!.id;
      nhapKhoHangDaiLyRequest.idTaiKhoan = userId;
      nhapKhoHangDaiLyRequest.soLuong = stock.text;

      //check product already exits
      nhapKhoHangDaiLyProvider.paginate(
        page: 1,
        limit: 100,
        filter:
            "&idTaiKhoan=$userId&idKhoHangDaiLy=${khoHangDaiLyResponse!.id}&sortBy=created_at:desc",
        onSuccess: (nhapKhoHangDaiLy) {
          final index = nhapKhoHangDaiLy.indexWhere((element) =>
              element.idSanPham!.maSanPham!.trim() == code.text.trim());
          //if product already exits
          if (index == -1) {
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
          } else {
            //set data
            sanPhamRequest.id = nhapKhoHangDaiLy[index].idSanPham!.id;
            //else
            sanPhamProvider.update(
              data: sanPhamRequest,
              onSuccess: (sanPhamUpdate) {
                //set data
                nhapKhoHangDaiLyRequest.idSanPham =
                    nhapKhoHangDaiLy[index].idSanPham!.id;
                nhapKhoHangDaiLyRequest.id = nhapKhoHangDaiLy[index].id;

                //nhapKho update
                nhapKhoHangDaiLyProvider.update(
                  data: nhapKhoHangDaiLyRequest,
                  onSuccess: (nhapKhoHangDaiLyUpdate) {
                    if (isUpdateAndAdd == false) {
                      Get.offNamed(AppRoutes.V3_STORE);
                    }
                    Alert.success(message: 'Thêm sản phẩm thành công');
                  },
                  onError: (error) {
                    print(
                        "V3ProductAddController nhapKhoHangDaiLyUpdate onError $error");
                  },
                );
              },
              onError: (error) {
                print("V3ProductAddController sanPhamUpdate onError $error");
              },
            );
          }
        },
        onError: (error) {
          print(
              "V3ProductAddController nhapKhoHangDaiLyPaginate onError $error");
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
    stock.clear();
    danhMucSanPhamResponse = null;
    khoHangDaiLyResponse = null;
    loaiVanChuyenResponse = null;
    update();
  }

  void printTest() {
    print(khoHangDaiLyResponse!.id);
  }
}
