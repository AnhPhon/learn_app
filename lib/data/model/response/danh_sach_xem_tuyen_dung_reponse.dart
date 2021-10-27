import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';

import 'tai_khoan_response.dart';

class DanhSachXemTuyenDungResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  DangKyViecMoiResponse? idDangKyViecMoi;

  String? createdAt;
  String? updatedAt;

  DanhSachXemTuyenDungResponse(
      {this.id,
      this.idTaiKhoan,
      this.idDangKyViecMoi,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  DanhSachXemTuyenDungResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }

    // mapping idTaiKhoan
    if (json['idDangKyViecMoi'] != null &&
        json['idDangKyViecMoi'].toString().length != 24) {
      idDangKyViecMoi = DangKyViecMoiResponse.fromJson(
          json['idDangKyViecMoi'] as Map<String, dynamic>);
    } else {
      idDangKyViecMoi = null;
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

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null file
    if (idDangKyViecMoi != null) data['idDangKyViecMoi'] = idDangKyViecMoi;

    return data;
  }
}
