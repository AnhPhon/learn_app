import 'package:template/data/model/response/don_dich_vu_response.dart';

class ChiTietCongViecResponse {
    DonDichVuResponse? idDonDichVu;
    String? tenCongViec;
    String? quyCach;
    String? soLuong;
    String? sonVi;
  ChiTietCongViecResponse({
    this.idDonDichVu,
    this.tenCongViec,
    this.quyCach,
    this.soLuong,
    this.sonVi,
  });

  ///
  /// From JSON
  ///
  ChiTietCongViecResponse.fromJson(Map<String, dynamic> json) {
    idDonDichVu = (json['idDonDichVu'] == null) ? null : DonDichVuResponse.fromJson(json['idDonDichVu'] as Map<String, dynamic>);
    tenCongViec = json['tenCongViec'].toString();
    quyCach = json['quyCach'].toString();
    soLuong = json['soLuong'].toString();
    sonVi = json['sonVi'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu; 

    // check null idDonHang
    if (tenCongViec != null) data['tenCongViec'] = tenCongViec; 

    // check null idSanPham
    if (soLuong != null) data['soLuong'] = soLuong; 

    // check null soLuong
    if (sonVi != null) data['sonVi'] = sonVi; 
    if (quyCach != null) data['quyCach'] = quyCach; 


    return data;
  }
}
