import 'don_dich_vu_response.dart';
import 'tai_khoan_response.dart';

class PhanHoiDonDichVuResponse {
  String? id;
  String? idDonDichVu;
  TaiKhoanResponse? idTaiKhoan;
  String? taiKhoanNhanDon;
  String? yKienThoThau;
  String? khachHangDanhGia;
  String? yeuCauBaoHanh;
  String? hinhAnhHuHai;
  String? noiDungYeuCauBaoHanh;
  String? danhGiaBaoHanh;
  String? tinhTrangThanhToan;

  String? createdAt;
  String? updatedAt;

  PhanHoiDonDichVuResponse(
      {this.id,
      this.idDonDichVu,
      this.idTaiKhoan,
      this.taiKhoanNhanDon,
      this.yKienThoThau,
      this.khachHangDanhGia,
      this.yeuCauBaoHanh,
      this.hinhAnhHuHai,
      this.noiDungYeuCauBaoHanh,
      this.danhGiaBaoHanh,
      this.tinhTrangThanhToan,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  PhanHoiDonDichVuResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();

    // mapping idDonDichVu
    // if (json['idDonDichVu'] != null && json['idDonDichVu'].toString().length!=24) {
    //   idDonDichVu = DonDichVuResponse.fromJson(json['idDonDichVu'] as Map<String, dynamic>);
    // } else {
    //   idDonDichVu = null;
    // }
    idDonDichVu = json["idDonDichVu"]["id"].toString();

    // mapping idTaiKhoan
    if (json['idTaiKhoan'] != null &&
        json['idTaiKhoan'].toString().length != 24) {
      idTaiKhoan =
          TaiKhoanResponse.fromJson(json['idTaiKhoan'] as Map<String, dynamic>);
    } else {
      idTaiKhoan = null;
    }
    taiKhoanNhanDon = json['taiKhoanNhanDon'].toString();
    yKienThoThau = json['yKienThoThau'].toString();
    khachHangDanhGia = json['khachHangDanhGia'].toString();
    yeuCauBaoHanh = json['yeuCauBaoHanh'].toString();
    hinhAnhHuHai = json['hinhAnhHuHai'].toString();
    noiDungYeuCauBaoHanh = json['noiDungYeuCauBaoHanh'].toString();
    danhGiaBaoHanh = json['danhGiaBaoHanh'].toString();
    tinhTrangThanhToan = json['tinhTrangThanhToan'].toString();

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

    // check null idTaiKhoan
    if (idTaiKhoan != null) data['idTaiKhoan'] = idTaiKhoan;

    // check null taiKhoanNhanDon
    if (taiKhoanNhanDon != null) data['taiKhoanNhanDon'] = taiKhoanNhanDon;

    // check null yKienThoThau
    if (yKienThoThau != null) data['yKienThoThau'] = yKienThoThau;

    // check null khachHangDanhGia
    if (khachHangDanhGia != null) data['khachHangDanhGia'] = khachHangDanhGia;

    // check null yeuCauBaoHanh
    if (yeuCauBaoHanh != null) data['yeuCauBaoHanh'] = yeuCauBaoHanh;

    // check null hinhAnhHuHai
    if (hinhAnhHuHai != null) data['hinhAnhHuHai'] = hinhAnhHuHai;

    // check null noiDungYeuCauBaoHanh
    if (noiDungYeuCauBaoHanh != null)
      data['noiDungYeuCauBaoHanh'] = noiDungYeuCauBaoHanh;

    // check null danhGiaBaoHanh
    if (danhGiaBaoHanh != null) data['danhGiaBaoHanh'] = danhGiaBaoHanh;

    // check null tinhTrangThanhToan
    if (tinhTrangThanhToan != null)
      data['tinhTrangThanhToan'] = tinhTrangThanhToan;

    return data;
  }
}
