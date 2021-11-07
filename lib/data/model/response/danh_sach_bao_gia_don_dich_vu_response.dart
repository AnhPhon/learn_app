import 'dart:convert';

import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';

import 'don_dich_vu_response.dart';

class DanhSachBaoGiaDonDichVuResponse {
  String? id;
  DonDichVuResponse? idDonDichVu;
  String? taiKhoanBaoGia;
  String? tongTien;
  List<GiaVatTus>? giaVatTus;
  String? giaBao;
  String? ghiChu;
  String? file;
  String? daXem;

  String? createdAt;
  String? updatedAt;

  DanhSachBaoGiaDonDichVuResponse({
    this.id,
    this.idDonDichVu,
    this.taiKhoanBaoGia,
    this.tongTien,
    this.giaVatTus = const [],
    this.giaBao,
    this.ghiChu,
    this.file,
    this.daXem,
    this.createdAt,
    this.updatedAt
  });
  
  ///
  /// From JSON
  ///
  DanhSachBaoGiaDonDichVuResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tongTien = (json['tongTien'] == null) ? null : json['tongTien'].toString();

    // mapping idDonDichVu                                                              
    if (json['idDonDichVu'] != null && json['idDonDichVu'].toString().length!=24) {                                                  
      idDonDichVu = DonDichVuResponse.fromJson(json['idDonDichVu'] as Map<String, dynamic>); 
    } else {                                                                           
      idDonDichVu = null;                                                               
    }                                                                                  
    // mapping idDonDichVu                                                              
    if (json['giaVatTus'] != null && json['giaVatTus'].toString().length!=24) {                                                  
      giaVatTus = (json['giaVatTus'] as List<dynamic>).map((e) => GiaVatTus.fromMap(e as Map<String, dynamic>)).toList(); 
    } else {                                                                           
      giaVatTus = null;                                                               
    }                                                                                  
    taiKhoanBaoGia = json['taiKhoanBaoGia'].toString();
    giaBao = json['giaBao'].toString();
    ghiChu = json['ghiChu'].toString();
    file = json['file'].toString();
    daXem = json['daXem'].toString();

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

    // check null taiKhoanBaoGia
    if (taiKhoanBaoGia != null) data['taiKhoanBaoGia'] = taiKhoanBaoGia; 

    // check null giaBao
    if (giaBao != null) data['giaBao'] = giaBao; 

    // check null ghiChu
    if (ghiChu != null) data['ghiChu'] = ghiChu; 

    // check null file
    if (file != null) data['file'] = file; 

    // check null daXem
    if (daXem != null) data['daXem'] = daXem; 


    return data;
  }
}


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

  String toJson() => json.encode(toMap());

  factory GiaVatTus.fromJson(String source) => GiaVatTus.fromMap(json.decode(source) as Map<String, dynamic>);
}
