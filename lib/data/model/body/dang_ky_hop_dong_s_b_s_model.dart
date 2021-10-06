class DangKyHopDongSBSModel {
  String? idTaiKhoan;
  String? file;
  String? trangThai;

  DangKyHopDongSBSModel({
      this.idTaiKhoan,
      this.file,
      this.trangThai
      });

  DangKyHopDongSBSModel.fromJson(Map<String, dynamic> json) {
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
