class DangKyBaoHiemModel {
  String? idTaiKhoan;
  String? file;
  String? trangThai;

  DangKyBaoHiemModel({
      this.idTaiKhoan,
      this.file,
      this.trangThai
      });

  DangKyBaoHiemModel.fromJson(Map<String, dynamic> json) {
    idTaiKhoan = json['idTaiKhoan'].toString();
    file = json['file'].toString();
    trangThai = json['trangThai'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTaiKhoan'] = idTaiKhoan;
    data['file'] = file;
    data['trangThai'] = trangThai;
    return data;
  }
}
