import 'don_dich_vu_model.dart';
import 'vat_tu_model.dart';

class ChiTietVatTuModel {
  DonDichVuModel? idDonDichVu;
  VatTuModel? idVatTu;
  String? soLuong;

  ChiTietVatTuModel({
      this.idDonDichVu,
      this.idVatTu,
      this.soLuong});
  
  ///
  /// From JSON
  ///
  ChiTietVatTuModel.fromJson(Map<String, dynamic> json) {

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null) {                                                  
      idDonDichVu = DonDichVuModel.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  

    // mapping idVatTu                                                              
    if (json['idVatTu'] != null) {                                                  
      idVatTu = VatTuModel.fromJson(json['idVatTu'] as Map<String, dynamic>); 
    } else {                                                                           
      idVatTu = null;                                                               
    }                                                                                  
    soLuong = json['soLuong'].toString();

  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDonDichVu'] = idDonDichVu;
    data['idVatTu'] = idVatTu;
    data['soLuong'] = soLuong;
    return data;
  }
}
