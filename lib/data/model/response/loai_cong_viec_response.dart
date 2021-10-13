import 'nhom_dich_vu_response.dart';

class LoaiCongViecResponse {
  String? id;
  NhomDichVuResponse? idNhomDichVu;
  String? tenCongViec;

  String? createdAt;
  String? updatedAt;

  LoaiCongViecResponse({
      this.id,
      this.idNhomDichVu,
      this.tenCongViec,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  LoaiCongViecResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idNhomDichVu                                                              
    if (json['idNhomDichVu'] != null && json['idNhomDichVu'].toString().length!=24) {                                                  
      idNhomDichVu = NhomDichVuResponse.fromJson(json['idNhomDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idNhomDichVu = null;                                                               
    }                                                                                  
    tenCongViec = json['tenCongViec'].toString();

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

    // check null idNhomDichVu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu; 

    // check null tenCongViec
    if (tenCongViec != null) data['tenCongViec'] = tenCongViec; 


    return data;
  }
}
