class BangBangCapRequest {
  String? id;
  String? idTaiKhoan;
  String? idTrinhDo;
  String? idChuyenMon;
  String? idLoaiTotNghiep;
  String? namTotNghiep;
  String? donViDaoTao;
  String? anhBangCap;
  List<dynamic>? anhBangCaps;

  BangBangCapRequest(
      {this.id,
      this.idTaiKhoan,
      this.idTrinhDo,
      this.idChuyenMon,
      this.idLoaiTotNghiep,
      this.namTotNghiep,
      this.donViDaoTao,
      this.anhBangCaps,
      this.anhBangCap});

  ///
  /// From JSON
  ///
  BangBangCapRequest.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idTrinhDo = json['idTrinhDo'].toString();
    idChuyenMon = json['idChuyenMon'].toString();
    idLoaiTotNghiep = json['idLoaiTotNghiep'].toString();
    namTotNghiep = json['namTotNghiep'].toString();
    donViDaoTao = json['donViDaoTao'].toString();
    anhBangCap = json['anhBangCap'].toString();

    if (json['anhBangCaps'] != null) {
      anhBangCaps = json['anhBangCaps'] as List<dynamic>;
    }
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

    // check null idTrinhDo
    if (idTrinhDo != null) data['idTrinhDo'] = idTrinhDo;

    // check null idChuyenMon
    if (idChuyenMon != null) data['idChuyenMon'] = idChuyenMon;

    // check null idLoaiTotNghiep
    if (idLoaiTotNghiep != null) data['idLoaiTotNghiep'] = idLoaiTotNghiep;

    // check null namTotNghiep
    if (namTotNghiep != null) data['namTotNghiep'] = namTotNghiep;

    // check null donViDaoTao
    if (donViDaoTao != null) data['donViDaoTao'] = donViDaoTao;

    // check null anhBangCap
    if (anhBangCap != null) data['anhBangCap'] = anhBangCap;

    // check null anhBangCaps
    if (anhBangCaps != null) {
      data['anhBangCaps'] = anhBangCaps;
    }

    return data;
  }
}
