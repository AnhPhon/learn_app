
import 'package:template/data/model/response/don_dich_vu_response.dart';

class BangGiaChiTietThamKhaoResponse {
  String? id;
  List<String>? hinhAnhs;
  List<String>? files;
  DonDichVuResponse? idNhomDichVu;
  BangGiaChiTietThamKhaoResponse({
    this.id,
    this.hinhAnhs,
    this.files,
    this.idNhomDichVu,
  });
  

  ///
  /// From JSON
  ///
  BangGiaChiTietThamKhaoResponse.fromJson(Map<String, dynamic> json) {
    hinhAnhs = (json['hinhAnhs'] as List<dynamic>).cast<String>();
    files = (json['files'] as List<dynamic>).cast<String>();
    idNhomDichVu = DonDichVuResponse.fromJson(json['idNhomDichVu'] as Map<String, dynamic>);
    id = json['id'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id; 
    if (hinhAnhs != null) data['hinhAnhs'] = hinhAnhs; 

    // check null idDonDichVu
    if (files != null) data['files'] = files; 

    // check null idVatTu
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu; 

    return data;
  }
}
