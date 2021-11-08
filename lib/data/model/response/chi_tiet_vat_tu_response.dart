import 'don_dich_vu_response.dart';
import 'vat_tu_response.dart';

class ChiTietVatTuResponse {
  String? id;
  DonDichVuResponse? idDonDichVu;
  VatTuResponse? idVatTu;
  String? soLuong;
  String? createdAt;
  String? updatedAt;

  ChiTietVatTuResponse({
      this.id,
      this.idDonDichVu,
      this.idVatTu,
      this.soLuong,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ChiTietVatTuResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null && json['idDonDichVu'].toString().length!=24) {                                                  
      idDonDichVu = DonDichVuResponse.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  

    // mapping idVatTu                                                              
    if (json['idVatTu'] != null && json['idVatTu'].toString().length!=24) {                                                  
      idVatTu = VatTuResponse.fromJson(json['idVatTu'] as Map<String, dynamic>); 
    } else {                                                                           
      idVatTu = null;                                                               
    }                                                                                  
    soLuong = json['soLuong'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 

    // check null idDonDichVu
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idVatTu
    if (idVatTu != null) data['idVatTu'] = idVatTu; 

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong; 


    return data;
  }
}
