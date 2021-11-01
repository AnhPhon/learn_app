import 'nhan_vien_response.dart';

class ThuChiNhanVienResponse {
  String? id;
  NhanVienResponse? idNhanVien;
  String? loai;
  String? tieuDe;
  String? soTien;
  String? noiDung;

  String? createdAt;
  String? updatedAt;
  String? ngayThuChi;
  ThuChiNhanVienResponse({
    this.id,
    this.idNhanVien,
    this.loai,
    this.tieuDe,
    this.soTien,
    this.noiDung,
    this.createdAt,
    this.updatedAt,
    this.ngayThuChi,
  });

  ///
  /// From JSON
  ///
  ThuChiNhanVienResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();

    // mapping idNhanVien
    if (json['idNhanVien'] != null &&
        json['idNhanVien'].toString().length != 24) {
      idNhanVien =
          NhanVienResponse.fromJson(json['idNhanVien'] as Map<String, dynamic>);
    } else {
      idNhanVien = null;
    }
    loai = json['loai'].toString();
    tieuDe = json['tieuDe'].toString();
    soTien = json['soTien'].toString();
    noiDung = json['noiDung'].toString();

    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    ngayThuChi = json['ngayThuChi'].toString();
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

    // check null loai
    if (loai != null) data['loai'] = loai;

    // check null tieuDe
    if (tieuDe != null) data['tieuDe'] = tieuDe;

    // check null soTien
    if (soTien != null) data['soTien'] = soTien;

    // check null noiDung
    if (noiDung != null) data['noiDung'] = noiDung;

    //check null ngay thu chil
    if (ngayThuChi != null) data['ngayThuChi'] = noiDung;

    return data;
  }
}
