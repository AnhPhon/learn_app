class ThuChiNhanVienRequest {
  String? id;
  String? idNhanVien;
  String? loai;
  String? tieuDe;
  String? soTien;
  String? noiDung;
  String? ngayThuChi;

  ThuChiNhanVienRequest({
    this.id,
    this.idNhanVien,
    this.loai,
    this.tieuDe,
    this.soTien,
    this.noiDung,
    this.ngayThuChi,
  });

  ///
  /// From JSON
  ///
  ThuChiNhanVienRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idNhanVien = json['idNhanVien'].toString();
    loai = json['loai'].toString();
    tieuDe = json['tieuDe'].toString();
    soTien = json['soTien'].toString();
    noiDung = json['noiDung'].toString();
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

    //check null Ngay Thu Chi
    if (ngayThuChi != null) data['ngayThuChi'] = ngayThuChi;

    return data;
  }
}
