class DanhSachUngTuyenRequest {
  String? id;
  String? idTuyenDung;
  String? taiKhoanUngTuyen;
  String? daXem;
  DanhSachUngTuyenRequest({
      this.id,
      this.idTuyenDung,
      this.taiKhoanUngTuyen,
      this.daXem});
  
  ///
  /// From JSON
  ///
  DanhSachUngTuyenRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTuyenDung = json['idTuyenDung'].toString();
    taiKhoanUngTuyen = json['taiKhoanUngTuyen'].toString();
    daXem = json['daXem'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTuyenDung'] = idTuyenDung;
    data['taiKhoanUngTuyen'] = taiKhoanUngTuyen;
    data['daXem'] = daXem;
    return data;
  }
}
