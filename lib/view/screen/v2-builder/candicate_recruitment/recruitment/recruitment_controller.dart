import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/loai_tin_tuyen_dung_model.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/dialog_content.dart';

class V2RecruitmentController extends GetxController {
  // refresh controller for load more refresh
  List<RefreshController>? refreshControllerList;

  final searchController = TextEditingController();
  bool isSearch = false;
  int currentIndex = 0;
  // Value slider
  double salary = 0;

  //loại tin tuyển dụng
  List<LoaiTinTuyenDungModel> loaiTinTuyenDung = [
    LoaiTinTuyenDungModel(id: '1', tieuDe: 'Tin hot'),
    LoaiTinTuyenDungModel(id: '2', tieuDe: 'Mới nhất'),
    LoaiTinTuyenDungModel(id: '1', tieuDe: 'Tuyển dụng'),
  ];

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //binding refresh controller
    refreshControllerList =
        List.generate(loaiTinTuyenDung.length, (_) => RefreshController());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //onRefresh
  Future<void> onRefresh() async {
    //resetNoData
    refreshControllerList![currentIndex].resetNoData();
    //get order isRefresh
    // pullOrder(isRefresh: true);
  }

  //onLoading
  Future<void> onLoading() async {
    //get order isLoading
    // pullOrder(isRefresh: false);
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// thay đổi lương
  ///
  void onChangedSalary(double salary) {
    this.salary = salary;
    update();
  }

  ///
  /// Thay đồi trạng thái là tìm kiếm
  ///
  void onChangedStatus() {
    isSearch = !isSearch;
    update();
  }

  ///
  /// Nhấn vào tin tuyển dụng thì xem thông tin của tin
  ///
  void onClickRecruitmentNews() {
    Get.toNamed(AppRoutes.V2_VIEW_RECRUITMENT_NEWS);
  }

  ///
  /// Nhấn vào icon lịch sử trên appbar
  ///
  void onClickHistory() {
    Get.toNamed(AppRoutes.V2_HISTORY_RECRUITMENT_NEWS);
  }

  ///
  ///  Hiẻn thị bộ lọc
  ///
  void showDialog() {
    Get.defaultDialog(
        title: "",
        content: const DialogContent(),
        cancel: ElevatedButton(
            onPressed: () {
              Navigator.of(Get.context!).pop();
            },
            child: const Text("Tìm kiếm")));
  }
}
