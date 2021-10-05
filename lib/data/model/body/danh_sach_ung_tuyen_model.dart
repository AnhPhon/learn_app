class DanhSachUngTuyenModel {
  String? idTuyenDung;
  String? taiKhoanUngTuyen;
  String? daXem;

  DanhSachUngTuyenModel({
      this.idTuyenDung,
      this.taiKhoanUngTuyen,
      this.daXem
      });

  DanhSachUngTuyenModel.fromJson(Map<String, dynamic> json) {
    idTuyenDung = json['idTuyenDung'].toString();
    taiKhoanUngTuyen = json['taiKhoanUngTuyen'].toString();
    daXem = json['daXem'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTuyenDung'] = idTuyenDung;
    data['taiKhoanUngTuyen'] = taiKhoanUngTuyen;
    data['daXem'] = daXem;
    return data;
  }
}
