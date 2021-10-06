class KhoHangModel {
  String? idDuAnNhanVien;
  String? tenKho;

  KhoHangModel({
      this.idDuAnNhanVien,
      this.tenKho
      });

  KhoHangModel.fromJson(Map<String, dynamic> json) {
    idDuAnNhanVien = json['idDuAnNhanVien'].toString();
    tenKho = json['tenKho'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDuAnNhanVien'] = idDuAnNhanVien;
    data['tenKho'] = tenKho;
    return data;
  }
}
