import 'nhan_vien_response.dart';
import 'du_an_nhan_vien_response.dart';

class CongViecNhanVienResponse {
  String? id;
  NhanVienResponse? idNhanVien;
  DuAnNhanVienResponse? idDuAnNhanVien;
  String? trangThai;
  String? tieuDe;
  String? tomTat;
  String? noiDung;
  String? ngayBatDau;
  String? ngayKetThuc;
  String? ngayThucTe;

  String? createdAt;
  String? updatedAt;

  CongViecNhanVienResponse(
      {this.id,
      this.idNhanVien,
      this.idDuAnNhanVien,
      this.trangThai,
      this.tieuDe,
      this.tomTat,
      this.noiDung,
      this.ngayBatDau,
      this.ngayKetThuc,
      this.ngayThucTe,
      this.createdAt,
      this.updatedAt});

  ///
  /// From JSON
  ///
  CongViecNhanVienResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idNhanVien
    if (json['idNhanVien'] != null &&
        json['idNhanVien'].toString().length != 24) {
      idNhanVien =
          NhanVienResponse.fromJson(json['idNhanVien'] as Map<String, dynamic>);
    } else {
      idNhanVien = null;
    }

    // mapping idDuAnNhanVien
    if (json['idDuAnNhanVien'] != null &&
        json['idDuAnNhanVien'].toString().length != 24) {
      idDuAnNhanVien = DuAnNhanVienResponse.fromJson(
          json['idDuAnNhanVien'] as Map<String, dynamic>);
    } else {
      idDuAnNhanVien = null;
    }
    trangThai = json['trangThai'].toString();
    tieuDe = json['tieuDe'].toString();
    tomTat = json['tomTat'].toString();
    noiDung = json['noiDung'].toString();
    ngayBatDau = json['ngayBatDau'].toString();
    ngayKetThuc = json['ngayKetThuc'].toString();
    ngayThucTe = json['ngayThucTe'].toString();

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

    // check null idNhanVien
    if (idNhanVien != null) data['idNhanVien'] = idNhanVien;

    // check null idDuAnNhanVien
    if (idDuAnNhanVien != null) data['idDuAnNhanVien'] = idDuAnNhanVien;

    // check null trangThai
    if (trangThai != null) data['trangThai'] = trangThai;

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    // check null tomTat
    if (tomTat != null) data['tomTat'] = tomTat;

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung;

    // check null ngayBatDau
    if (ngayBatDau != null) data['ngayBatDau'] = ngayBatDau;

    // check null ngayKetThuc
    if (ngayKetThuc != null) data['ngayKetThuc'] = ngayKetThuc;

    // check null ngayThucTe
    if (ngayThucTe != null) data['ngayThucTe'] = ngayThucTe;

    return data;
  }

  @override
  String toString() {
    return trangThai!;
  }
}
