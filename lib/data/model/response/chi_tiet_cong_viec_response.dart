import 'don_dich_vu_response.dart';

class ChiTietCongViecResponse {
  String? id;
  DonDichVuResponse? idDonDichVu;
  String? tenCongViec;
  String? quyCach;
  String? soLuong;
  String? donVi;

  String? createdAt;
  String? updatedAt;

  ChiTietCongViecResponse({
      this.id,
      this.idDonDichVu,
      this.tenCongViec,
      this.quyCach,
      this.soLuong,
      this.donVi,
      this.createdAt,
      this.updatedAt});
  
  ///
  /// From JSON
  ///
  ChiTietCongViecResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null && json['idDonDichVu'].toString().length!=24) {                                                  
      idDonDichVu = DonDichVuResponse.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  

    // mapping tenCongViec
    if (json != null && json['tenCongViec'] != null) {
      tenCongViec = json['tenCongViec'].toString();
    }
    // mapping quyCach
    if (json != null && json['quyCach'] != null) {
      quyCach = json['quyCach'].toString();
    }
    // mapping soLuong
    if (json != null && json['soLuong'] != null) {
      soLuong = json['soLuong'].toString();
    }
    // mapping donVi
    if (json != null && json['donVi'] != null) {
      donVi = json['donVi'].toString();
    }

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

    // check null tenCongViec
    if (tenCongViec != null) data['tenCongViec'] = tenCongViec;

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null donVi
    if (donVi != null) data['donVi'] = soLuong;

    return data;
  }
}
