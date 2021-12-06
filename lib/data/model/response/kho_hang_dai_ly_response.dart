import 'tai_khoan_response.dart';
import 'tinh_tp_response.dart';
import 'quan_huyen_response.dart';
import 'phuong_xa_response.dart';
import 'san_pham_response.dart';

class KhoHangDaiLyResponse {
  String? id;
  TaiKhoanResponse? idTaiKhoan;
  String? ten;
  TinhTpResponse? idTinhTp;
  QuanHuyenResponse? idQuanHuyen;
  PhuongXaResponse? idPhuongXa;
  String? diaChi;
  SanPhamResponse? idSanPham;

  String? createdAt;
  String? updatedAt;

  KhoHangDaiLyResponse(
      {this.id,
      this.idTaiKhoan,
      this.ten,
      this.idTinhTp,
      this.idQuanHuyen,
      this.idPhuongXa,
      this.diaChi,
      this.idSanPham,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  KhoHangDaiLyResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }
    ten = json['ten'].toString();

    // mapping idTinhTp
    if (json['idTinhTp'] != null && json['idTinhTp'].toString().length != 24) {
      idTinhTp =
          TinhTpResponse.fromJson(json['idTinhTp'] as Map<String, dynamic>);
    } else {
      idTinhTp = null;
    }

    // mapping idQuanHuyen
    if (json['idQuanHuyen'] != null &&
        json['idQuanHuyen'].toString().length != 24) {
      idQuanHuyen = QuanHuyenResponse.fromJson(
          json['idQuanHuyen'] as Map<String, dynamic>);
    } else {
      idQuanHuyen = null;
    }

    // mapping idPhuongXa
    if (json['idPhuongXa'] != null &&
        json['idPhuongXa'].toString().length != 24) {
      idPhuongXa =
          PhuongXaResponse.fromJson(json['idPhuongXa'] as Map<String, dynamic>);
    } else {
      idPhuongXa = null;
    }
    diaChi = json['diaChi'].toString();

    // mapping idSanPham
    if (json['idSanPham'] != null &&
        json['idSanPham'].toString().length != 24) {
      idSanPham =
          SanPhamResponse.fromJson(json['idSanPham'] as Map<String, dynamic>);
    } else {
      idSanPham = null;
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

    // check null ten
    if (ten != null) data['ten'] = ten;

    // check null idTinhTp
    if (idTinhTp != null) data['idTinhTp'] = idTinhTp;

    // check null idQuanHuyen
    if (idQuanHuyen != null) data['idQuanHuyen'] = idQuanHuyen;

    // check null idPhuongXa
    if (idPhuongXa != null) data['idPhuongXa'] = idPhuongXa;

    // check null diaChi
    if (diaChi != null) data['diaChi'] = diaChi;

    // check null idSanPham
    if (idSanPham != null) data['idSanPham'] = idSanPham;

    return data;
  }

  @override
  String toString() {
    return ten.toString();
  }
}
