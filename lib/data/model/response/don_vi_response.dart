import 'package:template/data/model/response/nhom_dich_vu_response.dart';

class DonViResponse {
  String? id;
  String? ten;
  NhomDichVuResponse? idNhomDichVu;

  DonViResponse({
    this.id,
    this.ten,
    this.idNhomDichVu,
  });

  ///
  /// From JSON
  ///
  DonViResponse.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'].toString();
      ten = json['ten'].toString();
      idNhomDichVu = NhomDichVuResponse.fromJson(json['idNhomDichVu'] as Map<String, dynamic>);
    }
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;
    if (ten != null) data['ten'] = ten;
    if (idNhomDichVu != null) data['idNhomDichVu'] = idNhomDichVu;

    return data;
  }

  @override
  String toString() {
    return ten.toString();
  }
}
