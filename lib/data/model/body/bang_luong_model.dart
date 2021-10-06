class BangLuongModel {
  String? idNhanVien;
  String? file;

  BangLuongModel({
      this.idNhanVien,
      this.file
      });

  BangLuongModel.fromJson(Map<String, dynamic> json) {
    idNhanVien = json['idNhanVien'].toString();
    file = json['file'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNhanVien'] = idNhanVien;
    data['file'] = file;
    return data;
  }
}
