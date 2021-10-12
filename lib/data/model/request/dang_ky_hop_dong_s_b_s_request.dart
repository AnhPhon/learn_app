class DangKyHopDongSBSRequest {
  String? id;
  String? idTaiKhoan;
  String? file;
  String? trangThai;
  DangKyHopDongSBSRequest({
      this.id,
      this.idTaiKhoan,
      this.file,
      this.trangThai});
  
  ///
  /// From JSON
  ///
  DangKyHopDongSBSRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idTaiKhoan = json['idTaiKhoan'].toString();
    file = json['file'].toString();
    trangThai = json['trangThai'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaiKhoan'] = idTaiKhoan;
    data['file'] = file;
    data['trangThai'] = trangThai;
    return data;
  }
}
