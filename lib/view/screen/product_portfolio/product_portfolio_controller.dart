import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/routes/route_path/detailed_product_information_routers.dart';

class ProductPortfolioController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Current Index
  int currentIndex = 0;

  List<String> tieuDe = [
    "Phổ biến",
    "Mới nhất",
    "Bán chạy",
    "Giá",
  ];
  final dataMenu = [
    {
      'image': "https://samngoclinhkontum.com/wp-content/uploads/2019/03/gioi-thieu-ve-cay-sam-ngoc-linh-03.jpg",
      'lable': 'Sâm ngọc linh',
    },
    {
      'image': "https://media.baodansinh.vn/baodansinh/Images/2018/09/05/lenhuannt/Hinh_nh_cn_cnh_c_sam_Ngc_Linh.jpg",
      'lable': 'Sâm đá',
    },
    {
      'image': "https://phuhongthanh.vn/wp-content/uploads/2021/02/4-15199549610651368887618.jpg",
      'lable': 'Sâm bố chính',
    },
    {
      'image': "https://samngoclinhtumorong.com/wp-content/uploads/2020/07/su-khac-biet-giua-sam-ngoc-linh-va-sam-han-quoc-4.jpg",
      'lable': 'Sâm ngọc linh',
    },
    {
      'image': "https://www.tapchidongy.org/wp-content/uploads/2020/10/sam-ngoc-linh.jpg",
      'lable': 'Sâm ngọc linh',
    },
  ];

  //Khai báo Smart Refresher controller
  RefreshController refreshController = RefreshController(
    initialLoadStatus: LoadStatus.loading,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab({required int index}) {
    isLoading = true;
    currentIndex = index;

    update();
  }

  ///
  ///On Refresher
  ///
  Future<void> onRefresh() async {
    //resetNoData
    refreshController.resetNoData();
    Future.delayed(const Duration(milliseconds: 1000), () {
      refreshController.refreshCompleted();
    });
  }

  ///
  ///onLoading
  ///
  Future<void> onLoading() async {
    //get order isLoading
  }

  ///
  ///Go to Detailed Product Information
  ///
  void gotoDetailedProductInformation() {
    Get.toNamed(DetailedProductInformationRouters.DETAILED_PRODUCT_INFORMATION);
  }
}
