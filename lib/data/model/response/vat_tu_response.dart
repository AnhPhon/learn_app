import 'package:template/data/model/response/don_dich_vu_response.dart';

class VatTuResponse {
  String? id;
  String? tenVatTu;
  String? quyCach;
  String? donVi;
  String? donGia;
  String? khoiLuong;
  String? idDonDichVu;

  String? createdAt;
  String? updatedAt;

  VatTuResponse(
      {this.id,
      this.tenVatTu,
      this.quyCach,
      this.donVi,
      this.donGia,
      this.khoiLuong,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  VatTuResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    tenVatTu = json['tenVatTu'].toString();
    quyCach = json['quyCach'].toString();
    donVi = json['donVi'].toString();
    donGia = json['donGia'].toString();
    khoiLuong = json['khoiLuong'] as String;
    // mapping idDonDichVu
    // if (json['idDonDichVu'] != null &&
    //     json['idDonDichVu'].toString().length != 24) {
    //   idDonDichVu = DonDichVuResponse.fromJson(
    //       json['idDonDichVu'] as Map<String, dynamic>);
    // } else {
    //   idDonDichVu = null;
    // }

    idDonDichVu = json['idDonDichVu'].toString();

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

    // check null tenVatTu
    if (tenVatTu != null) data['tenVatTu'] = tenVatTu;

    // check null quyCach
    if (quyCach != null) data['quyCach'] = quyCach;

    // check null donVi
    if (donVi != null) data['donVi'] = donVi;

    // check null donGia
    if (donGia != null) data['donGia'] = donGia;

    // check null donGia
    if (khoiLuong != null) data['khoiLuong'] = khoiLuong;

    // check null donGia
    if (idDonDichVu != null) data['idDonDichVu'] = idDonDichVu;
    // check null donGia
    if (khoiLuong != null) data['khoiLuong'] = khoiLuong;

    return data;
  }

  @override
  String toString() {
    return tenVatTu!;
  }
}
