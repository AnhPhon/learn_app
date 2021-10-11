import 'nhom_dich_vu_model.dart';

class LoaiCongViecModel {
  NhomDichVuModel? idNhomDichVu;
  String? tenCongViec;

  LoaiCongViecModel({
      this.idNhomDichVu,
      this.tenCongViec});
  
  ///
  /// From JSON
  ///
  LoaiCongViecModel.fromJson(Map<String, dynamic> json) {

    // mapping idNhomDichVu                                                              
    if (json['idNhomDichVu'] != null) {                                                  
      idNhomDichVu = NhomDichVuModel.fromJson(json['idNhomDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhomDichVu = null;                                                               
    }                                                                                  
    tenCongViec = json['tenCongViec'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhomDichVu'] = idNhomDichVu;
    data['tenCongViec'] = tenCongViec;
    return data;
  }
}
