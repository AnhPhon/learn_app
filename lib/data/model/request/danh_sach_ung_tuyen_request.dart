class DanhSachUngTuyenRequest {
  String? id;
  String? idTuyenDung;
  String? idTaiKhoanUngTuyen;
  String? idDangKyViecMoi;
  String? daXem;

  DanhSachUngTuyenRequest({
    this.idTuyenDung,
    this.idTaiKhoanUngTuyen,
    this.idDangKyViecMoi,
    this.daXem,
  });

  ///
  /// From JSON
  ///
  DanhSachUngTuyenRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTuyenDung = json['idTuyenDung'].toString();
    idTaiKhoanUngTuyen = json['idTaiKhoanUngTuyen'].toString();
    idDangKyViecMoi = json['idDangKyViecMoi'].toString();
    daXem = json['daXem'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // check null id
    if (id != null) data['id'] = id;

    // check null idTuyenDung
    if (idTuyenDung != null) data['idTuyenDung'] = idTuyenDung;

    // check null idTaiKhoanUngTuyen
    if (idTaiKhoanUngTuyen != null) {
      data['idTaiKhoanUngTuyen'] = idTaiKhoanUngTuyen;
    }
      
    // check null idDangKyViecMoi
    if (idDangKyViecMoi != null) {
      data['idDangKyViecMoi'] = idDangKyViecMoi;
    }

    // check null daXem
    if (daXem != null) data['daXem'] = daXem;

    return data;
  }
}
