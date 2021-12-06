import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/don_dich_vu_provider.dart';

class V3KetQuaBaoGiaController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  TextEditingController titleController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();
  String title = "Kết quả báo giá";

  String idDonDichVu = "";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    idDonDichVu = Get.arguments as String;
    isLoading = false;
    loadData();
    update();
  }

  ///
  /// load data
  ///
  void loadData() {
    donDichVuProvider.find(
      id: idDonDichVu,
      onSuccess: (data) {
        titleController = TextEditingController(text: data.tieuDe.toString());
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3KetQuaBaoGiaController loadData onError $error");
      },
    );
  }
}
