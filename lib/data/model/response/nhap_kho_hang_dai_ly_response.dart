import 'kho_hang_dai_ly_response.dart';
import 'tai_khoan_response.dart';
import 'san_pham_response.dart';

class NhapKhoHangDaiLyResponse {
  String? id;
  KhoHangDaiLyResponse? idKhoHangDaiLy;
  TaiKhoanResponse? idTaiKhoan;
  SanPhamResponse? idSanPham;
  String? soLuong;
  String? tinhTrangSanPham;
  String? loai;

  String? createdAt;
  String? updatedAt;

  NhapKhoHangDaiLyResponse(
      {this.id,
      this.idKhoHangDaiLy,
      this.idTaiKhoan,
      this.idSanPham,
      this.soLuong,
      this.tinhTrangSanPham,
      this.loai,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  NhapKhoHangDaiLyResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    // mapping idKhoHangDaiLy
    if (json['idKhoHangDaiLy'] != null &&
        json['idKhoHangDaiLy'].toString().length != 24) {
      idKhoHangDaiLy = KhoHangDaiLyResponse.fromJson(
          json['idKhoHangDaiLy'] as Map<String, dynamic>);
    } else {
      idKhoHangDaiLy = null;
    }

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }

    // mapping idSanPham
    if (json['idSanPham'] != null &&
        json['idSanPham'].toString().length != 24) {
      idSanPham =
          SanPhamResponse.fromJson(json['idSanPham'] as Map<String, dynamic>);
    } else {
      idSanPham = null;
    }
    soLuong = json['soLuong'].toString();
    tinhTrangSanPham = json['tinhTrangSanPham'].toString();
    loai = json['loai'].toString();

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

    // check null idKhoHangDaiLy
    if (idKhoHangDaiLy != null) data['idKhoHangDaiLy'] = idKhoHangDaiLy;

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null idSanPham
    if (idSanPham != null) data['idSanPham'] = idSanPham;

    // check null soLuong
    if (soLuong != null) data['soLuong'] = soLuong;

    // check null tinhTrangSanPham
    if (tinhTrangSanPham != null) data['tinhTrangSanPham'] = tinhTrangSanPham;

    // check null loai
    if (loai != null) data['loai'] = loai;

    return data;
  }
}
