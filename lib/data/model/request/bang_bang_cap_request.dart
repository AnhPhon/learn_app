class BangBangCapRequest {
  String? id;
  String? idTaiKhoan;
  String? idTrinhDo;
  String? idChuyenMon;
  String? idLoaiTotNghiep;
  String? namTotNghiep;
  String? donViDaoTao;
  String? anhBangCap;
  BangBangCapRequest({
      this.id,
      this.idTaiKhoan,
      this.idTrinhDo,
      this.idChuyenMon,
      this.idLoaiTotNghiep,
      this.namTotNghiep,
      this.donViDaoTao,
      this.anhBangCap});
  
  ///
  /// From JSON
  ///
  BangBangCapRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    idTrinhDo = json['idTrinhDo'].toString();
    idChuyenMon = json['idChuyenMon'].toString();
    idLoaiTotNghiep = json['idLoaiTotNghiep'].toString();
    namTotNghiep = json['namTotNghiep'].toString();
    donViDaoTao = json['donViDaoTao'].toString();
    anhBangCap = json['anhBangCap'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['idTrinhDo'] = idTrinhDo;
    data['idChuyenMon'] = idChuyenMon;
    data['idLoaiTotNghiep'] = idLoaiTotNghiep;
    data['namTotNghiep'] = namTotNghiep;
    data['donViDaoTao'] = donViDaoTao;
    data['anhBangCap'] = anhBangCap;
    return data;
  }
}
