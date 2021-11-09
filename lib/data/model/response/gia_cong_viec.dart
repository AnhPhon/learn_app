import 'dart:convert';

import 'package:template/data/model/response/chi_tiet_cong_viec_response.dart';

class GiaCongViecs {
  String? id;
  ChiTietCongViecResponse? idChiTietCongViec;
  String? donGia;
  GiaCongViecs({
    this.id,
    this.idChiTietCongViec,
    this.donGia,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idChiTietCongViec': idChiTietCongViec,
      'donGia': donGia,
    };
  }

  factory GiaCongViecs.fromMap(Map<String, dynamic> map) {
    return GiaCongViecs(
      id: map['id'] != null ? map['id'] as String : null,
      idChiTietCongViec: map['idChiTietCongViec'] != null ? ChiTietCongViecResponse.fromJson(map['idChiTietCongViec'] as Map<String, dynamic>) : null,
      donGia: map['donGia'] != null ? (map['donGia'] as int).toString(): null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GiaCongViecs.fromJson(String source) => GiaCongViecs.fromMap(json.decode(source) as Map<String, dynamic>);
}
