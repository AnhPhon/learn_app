import 'dart:convert';

import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';

class GiaVatTus {
  String? id;
  ChiTietVatTuResponse? idChiTietVatTu;
  String? donGia;
  GiaVatTus({
    this.id,
    this.idChiTietVatTu,
    this.donGia,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idChiTietVatTu': idChiTietVatTu,
      'donGia': donGia,
    };
  }

  factory GiaVatTus.fromMap(Map<String, dynamic> map) {
    return GiaVatTus(
      id: map['id'] != null ? map['id'] as String : null,
      idChiTietVatTu: map['idChiTietVatTu'] != null ? ChiTietVatTuResponse.fromJson(map['idChiTietVatTu'] as Map<String, dynamic>) : null,
      donGia: map['donGia'] != null ? (map['donGia'] as int).toString(): null,
    );
  }

  String? toJson() => json.encode(toMap());

  factory GiaVatTus.fromJson(String source) => GiaVatTus.fromMap(json.decode(source) as Map<String, dynamic>);
}
